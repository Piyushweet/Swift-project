import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answer0: UIButton!
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var progressLabel: UILabel!
    
    @IBAction func submitAnswer0(_ sender: Any) {
        checkAnswer(idx: 0)
    }
    
    @IBAction func submitAnswer1(_ sender: Any) {
        checkAnswer(idx: 1)
    }
    
    @IBAction func submitAnswer2(_ sender: Any) {
        checkAnswer(idx: 2)
    }
    
    @IBAction func submitAnswer3(_ sender: Any) {
        checkAnswer(idx: 3)
    }

    var currentQuestion: Question?
    var currentQuestionPosition: Int = 0
    var noCorrect: Int = 0
    
    func checkAnswer(idx: Int) {
        if (currentQuestion!.correctAnswer == idx) {
            noCorrect += 1
        }
        loadNextQuestion()
    }
    func setQuestions() {
        questionLabel.text = currentQuestion!.question
        answer0.setTitle(currentQuestion!.answers[0], for: .normal)
        answer1.setTitle(currentQuestion!.answers[1], for: .normal)
        answer2.setTitle(currentQuestion!.answers[2], for: .normal)
        answer3.setTitle(currentQuestion!.answers[3], for: .normal)
        progressLabel.text = "Question: \(currentQuestionPosition + 1)/ \(questions.count)"
    }
    func loadNextQuestion() {
        if (currentQuestionPosition + 1 < questions.count) {
            currentQuestionPosition += 1
            currentQuestion = questions[currentQuestionPosition]
            setQuestions()
        } else {
            performSegue(withIdentifier: "sgShowResults", sender: nil)
        }
    }
    struct Question {
        let question: String
        let answers: [String]
        let correctAnswer: Int
    }
    var questions: [Question] = [
        Question(
            question: "What is the capital of france?",
            answers: ["Berlin","Paris", "London", "Madrid"],
            correctAnswer: 1),
        Question(
            question: "Who is the author of Harry potter?",
            answers: ["J.R.R Tolkien", "Martin Luther", "J.K Rowling", "Stephan King"],
            correctAnswer: 2),
        Question(
            question: "What is the powerhouse of cell?",
            answers: ["Nucleus", "Ribosome", "Mitrochondria", "Golgi appartus"],
            correctAnswer: 2),
        Question(
            question: "What is the largest mammal of earth?",
            answers: ["Giraffe", "Blue Whale", "Elephant", "Hippopotamus"],
            correctAnswer: 1),
        Question(
            question: "What is the symbol for element gold in chemical reaction?",
            answers: ["GI ", "Go", "Ag", "Au"],
            correctAnswer: 3),
        Question(
            question: "Which planet is known as red planet?",
            answers: ["Mars", "Neptune", "Venus", "Mercury"],
            correctAnswer: 0)
    ]
    var vlc: AVAudioPlayer!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuestion = questions[0]
        setQuestions() //this gives the value to the answers
        
        do
        {
            let s=Bundle.main.path(forResource: "a", ofType: "mp3")
            try
            vlc=AVAudioPlayer(contentsOf: NSURL(string: s!) as! URL)
            vlc.play()
        }
        catch{}
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "sgShowResults") {
            print("begun")
            let vc = segue.destination as! ResultsViewController
            vc.noCorrect = noCorrect
            vc.total = questions.count
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Music(_ sender: Any) {
        vlc.play()
    }
    
}

