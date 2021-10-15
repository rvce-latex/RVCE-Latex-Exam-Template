# RVCE-Latex-Exam-Template Class
## Declaration
Firstly, I would like to thank `Philip S. Hirschhorn` for providing `exam.cls`. This class code is directly taken from `Exam.cls` and it's been slightly modifed to match the need of RV College of Engineering. I don't know whether I can reuse the code with prior permission from `Philip S. Hirschhorn`. So I (P Narashimaraja, Assistant professor of RVCE) will take up the sole responsibility if there is any violation in reusing the code.

## What's different / extra from `exam.cls`?
Since our institution needs to know how many marks of Questions are mapped across the *Course Outcomes (CO)s* of the subject (course) and also, to know the quality of the questions, through *Bloom's Taxonomy* levels, and it's distribution across the question sets - I have added some extra code into the original class file.

## How to use this `rvexam` class?
One can follow all the instructions given in `exam.cls` for basic usage of this class. Here I will only try to present the extra/modification of commands to generate the CO & BT table.
1. Defining CO and BT level for each question (or) to each part (or) to each subpart. As an example,
> `\question[10][2][3]`

    Here the `\question` command uses 3 arguments, instead of one. The first argument is for **Marks** 
    