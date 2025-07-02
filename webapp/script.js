const content = document.getElementById('content');

let currentQuestion = 0;
let selections = [];

const questions = [
    {
        text: 'Hangi sporları seviyorsunuz?',
        options: ['Futbol', 'Basketbol', 'Yüzme', 'Koşu']
    },
    {
        text: 'Haftada kaç gün spor yaparsınız?',
        options: ['1', '2', '3', '4+']
    }
];

function renderSportSelect() {
    content.innerHTML = `
        <h2>Spor Seç</h2>
        <button onclick="startLevelPage()">Devam</button>
    `;
}

function startLevelPage() {
    content.innerHTML = `
        <h2>Seviyeni\nHemen Ölç!</h2>
        <button onclick="startQuiz()">Hemen Başla</button>
        <button onclick="renderSportSelect()">Daha Sonra</button>
    `;
}

function startQuiz() {
    currentQuestion = 0;
    selections = [];
    renderQuestion();
}

function renderQuestion() {
    const q = questions[currentQuestion];
    const options = q.options.map(opt => `
        <label><input type="checkbox" name="opt" value="${opt}"> ${opt}</label><br>
    `).join('');
    content.innerHTML = `
        <div class="message">Birden fazla seçim işaretleyebilirsiniz.</div>
        <h3>${q.text}</h3>
        ${options}
        <button onclick="prevQuestion()">Geri Gel</button>
        <button onclick="nextQuestion()">İlerle</button>
    `;
}

function prevQuestion() {
    if (currentQuestion > 0) {
        currentQuestion--;
        renderQuestion();
    } else {
        renderSportSelect();
    }
}

function nextQuestion() {
    const checked = Array.from(document.querySelectorAll('input[name="opt"]:checked')).map(i => i.value);
    selections[currentQuestion] = checked;
    if (currentQuestion < questions.length - 1) {
        currentQuestion++;
        renderQuestion();
    } else {
        showResult();
    }
}

function calculateScore() {
    let score = 0;
    selections.forEach(arr => { score += arr.length; });
    return Math.min(score, 10);
}

function showResult() {
    const score = calculateScore();
    const sports = selections[0] || [];
    const gauge = score ? `
        <div id="gauge"><div class="fill" style="width:${score * 10}%"></div></div>
        <div>${score}/10</div>
    ` : `<button onclick="startQuiz()">Teste Başla</button>`;

    content.innerHTML = `
        <h2>Yapabildiğin Sporlar</h2>
        <ul>${sports.map(s => `<li>${s}</li>`).join('')}</ul>
        <div id="score">${gauge}</div>
    `;
}

renderSportSelect();
