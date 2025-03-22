# Friday Night Funkin' - Psychness Engine
このエンジンは、[Psych Engine](https://github.com/ShadowMario/FNF-PsychEngine) 1.0.3を改造し、様々な機能を追加したちょっぴり上級者向けのエンジンです。

## ビルドするには？
Psych Engineと変わらないはずです！
[Psych Engine 1.x のビルド方法はこちらを参照してください！](https://github.com/ShadowMario/FNF-PsychEngine/blob/main/docs/BUILDING.md)

## 新しい機能の例:

### 少しだけ改造されたチャートエディタ
![enter image description here](https://private-user-images.githubusercontent.com/127845723/425750416-6738531d-ae7f-44b6-ade1-101f90b47c76.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDI2NTE0MjUsIm5iZiI6MTc0MjY1MTEyNSwicGF0aCI6Ii8xMjc4NDU3MjMvNDI1NzUwNDE2LTY3Mzg1MzFkLWFlN2YtNDRiNi1hZGUxLTEwMWY5MGI0N2M3Ni5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMzIyJTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDMyMlQxMzQ1MjVaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0xZTdhZWZlNzcyNzIyMjljNWMyMmU2M2E0NzQ2NzkyODBiNjRmNmRjODg4MDljY2I4MTlmMzFkOThkNTExNWJlJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.o4P4F46Om27jYrYwUY-o9v_GDdQ_fE8XFO58Drn1FaA)
- 履歴機能が追加されました。
- Ctrl + OでOpponentのNoteが全選択(現在のSection内のみ)できるようになりました。
- Ctrl + PでPlayerのNoteが全選択(現在のSection内のみ)できるようになりました。
- チャートがセーブされていない状態でゲームを閉じようとすると、警告が現れるようになりました。

### 全く新しいLuaの世界
![enter image description here](https://private-user-images.githubusercontent.com/127845723/425751285-42b84c1a-22cf-4b3a-9c65-76975b2b7328.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDI2NTIyMzcsIm5iZiI6MTc0MjY1MTkzNywicGF0aCI6Ii8xMjc4NDU3MjMvNDI1NzUxMjg1LTQyYjg0YzFhLTIyY2YtNGIzYS05YzY1LTc2OTc1YjJiNzMyOC5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMzIyJTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDMyMlQxMzU4NTdaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT01ZjFkMmJmM2ZmOTg3NjBmY2YwMDMxZWIxMjkxNTRiZDFlNTI1NjViZGUwZjJlMTMzNTFiM2RjNTQ3ZDY2OGQzJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.WiXmPVHHgUysjuaQaakthH4f0fpFmGB79cDBKPnp52A)

おや...？

![enter image description here](https://private-user-images.githubusercontent.com/127845723/425750888-becbd66a-8292-4af8-8dd8-7a1cd93c636b.gif?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDI2NTE4NzMsIm5iZiI6MTc0MjY1MTU3MywicGF0aCI6Ii8xMjc4NDU3MjMvNDI1NzUwODg4LWJlY2JkNjZhLTgyOTItNGFmOC04ZGQ4LTdhMWNkOTNjNjM2Yi5naWY_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMzIyJTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDMyMlQxMzUyNTNaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0zODhiODUyNDVjMjZmMTFiMjFiODY0ZWIzNGI4NTJiY2Q0YjkwZmE4MGQxMTk3ZTc3OGM3OTY2ZWYzMDA1OWZkJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.5Vgk4DE_DIbIVObqFCo8iDxL4zku8zRjrZ0LdEhT9FY)

- Main MenuでLuaが使用可能
- Custom Stateで0からLuaでStateを組み立てることが可能 (上のgifもこれで作られました!)

## クレジット:

### Psychness Engine

- _nes0116 - Head Developer, Programmer.

### Psych Engine

* Shadow Mario - Head Developer, Programmer.

* Riveren - Main Artist.

### Special Thanks

* bbpanzu - Ex-Team Member (Programmer).

* crowplexus - HScript Iris, Input System v3, and Other PRs.

* Kamizeta - Creator of Pessy, Psych Engine's mascot.

* MaxNeton - Loading Screen Easter Egg Artist/Animator.

* Keoiki - Note Splash Animations and Latin Alphabet.

* SqirraRNG - Crash Handler and Base code for Chart Editor's Waveform.

* EliteMasterEric - Runtime Shaders support and Other PRs.

* MAJigsaw77 - .MP4 Video Loader Library (hxvlc).

* Tahir Toprak Karabekiroglu - Note Splash Editor and Other PRs.

* iFlicky - Composer of Psync, Tea Time and some sound effects.

* KadeDev - Fixed some issues on Chart Editor and Other PRs.

* superpowers04 - LUA JIT Fork.

* CheemsAndFriends - Creator of FlxAnimate.

* Ezhalt - Pessy's Easter Egg Jingle.

* MaliciousBunny - Video for the Final Update.

_____________________________________