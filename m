From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Subject: Re: OTG MUSB driver issue?
Date: Mon, 2 Mar 2009 22:10:59 +0100
Message-ID: <ac9c93b10903021310q104842bahcd5296fef7d596e5@mail.gmail.com>
References: <ac9c93b10902280246j39b37adcx5c9abd5c6dd6a444@mail.gmail.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB02FAD03AF5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e6d376615567eb0464294108
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f176.google.com ([209.85.220.176]:61614 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbZCBVLD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2009 16:11:03 -0500
Received: by fxm24 with SMTP id 24so2172738fxm.37
        for <linux-omap@vger.kernel.org>; Mon, 02 Mar 2009 13:10:59 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02FAD03AF5@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "beagleboard@googlegroups.com" <beagleboard@googlegroups.com>

--0016e6d376615567eb0464294108
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Anand, Felipe, thanks for the feedback.

I did a short test. I copied the the musb driver source dir from the
linux-omap git to the angstrom 2.6.28.12 kernel, compiled it and
tested it.
Same problem. I verified that the driver code indeed got recompiled
(threw away the .o files and uimage)
Attached is a picture from my webcam. The colored stripes are always
on different locations.

Also the diffs between the 2 pictures that I reported before:
ce_blank.png  ce_blank.png-
frans@linux-suse:~> cmp -l ce*
 12709 161   0
 12710 303  60
 12711 125 120
 12712 356   1
 12761 237  10
 12762 247   0
 12763 246 105
 12764  51  20
 12797 156 100
 12798 332   0
 12799 347 100
 12800 146   6
 13713 335  24
 13714 153 307
 13715  20 326
 13716 106 114

Best regards, Frans.

2009/3/2 Gadiyar, Anand <gadiyar@ti.com>:
>> 2009/2/27 Felipe Balbi <me@felipebalbi.com>:
>> > On Fri, Feb 27, 2009 at 06:52:38PM +0100, Frans Meulenbroeks wrote:
>> >> Hi,
>> >>
>> >> Several times I encountered issues with devices connected to the
>> >> beagle board's OTG port (through a powered hub). (kernel 2.6.28-omap1=
).
>> >> Today this happened again and I was lucky enough to be able to find
>> >> the symptoms.
>> >>
>> >> Scenario: I had a file on a USB hard disk. This file was copied to an
>> >> SD card. After copying the file was corrupted.
>> >> Removing the card and hard disk and connecting them to my linux box
>> >> allowed me to compare the SD and hard disk version (using cmp -l).
>> >> There were differences on four places. Each difference was 4 bytes (3=
2
>> >> bits) and occurred on a 4 byte boundary.
>> >>
>> >> I have no idea what causes it, but I strongly suspect the MUSB driver=
.
>> >> A hauppauge usb tv card also does not work when connected to the hub,
>> >> whereas the same card works without problem on a linksys NSLU2 (which
>> >> also has an arm processor).
>> >>
>> >> Anyone suggestions? Patches ??
>> >
>> > I guess that should be already fixed with patches queued up in Greg's
>> > queue, but then again, let me check more. Could you:
>> >
>> > # echo 5 > /sys/modules/musb_hdrc/parameters/debug
>> > # echo 8 > /proc/sysrq-trigger
>> >
>> > then connect device and send me log output ?
>> >
>> > --
>> > balbi
>> >
>>
>> Hi Balbi,
>>
>> Thanks for your help.
>> It was echo 5 > /sys/module/musb_hdrc/parameters/musb_debug
>>
>> Also beforestarting the system I removed all other usb devices from
>> the hub (I have to use a hub to get enough power for the hard disk).
>>
>> After connecting the disk it took about two seconds before the system
>> started to generate log data.
>> The system kept on generating debug info so after about two minutes I
>> decided that it was enough and switched off the beagle and saved the
>> log file. If =A0this is too short let me know and I'll repeat the
>> experiment.
>> The last 30 lines or so are probably caused by the device loosing
>> power. At that point it was still very busy generating messages
>>
>> The log file is attached: 54 k gizpped 1.2M unzipped.
>>
>> If you happen to have a patch that would be great.
>>
>> Best regards, Frans
>
>
> I tried this on the current linux-omap codebase (as of today). I
> transferred a 1 GB file back-and-forth a couple of times between
> a flash drive and an SD card on a USB card reader (both connected
> through a USB hub to the MUSB port). There was no data corruption.
>
> How big was your file? Any chance the card reader or the hard drive
> is bad?
>
> What kind of corruption do you see? (You mentioned 4 bytes were different
> in 4 places. How different?)
>
> - Anand
>
> P.S. I tested this on the 3430 SDP. Only changes I made from the
> defconfig were to remove CONFIG_USB_STORAGE_DEBUG and CONFIG_DEBUG_LL.
>

--0016e6d376615567eb0464294108
Content-Type: image/jpeg; name="test.jpg"
Content-Disposition: attachment; filename="test.jpg"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_frtnai6x0

/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAYEBQYFBAYGBQYHBwYIChAKCgkJChQODwwQFxQYGBcU
FhYaHSUfGhsjHBYWICwgIyYnKSopGR8tMC0oMCUoKSj/2wBDAQcHBwoIChMKChMoGhYaKCgoKCgo
KCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCj/wAARCAHgAoADASIA
AhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQA
AAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3
ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWm
p6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEA
AwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSEx
BhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElK
U1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3
uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD5Wooo
oAKKKKACiiigAooooAKKKKACra2TCBJTyrenaq0S75FX1OK6iMLt4AUegrOpPl2A5t7d1PAJFCWk
7kBYnJ+ldVFCgydi565q5Cu0ZA5rH6xboOxzthoE0xBuG8pfTvXV2dvFbwiOBFRR1x39zQhxzUqq
eeRXNUqynoUoiqnqMVynjCy8m+S5T/V3AyfZhwR/L8663qQyn6iob61TUrF7Z8bj80bdw1KjPklc
bVzziinSI0cjI4IZTgg9jTa9QzCiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACi
iigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKK
KACiiigAooooAKKKKACiiigBQxFOEtMopWKU2iXzB35pd6nNQ0UWK9owoq3/AGfPg4CH6MKb9guc
ZELH6c0uZdzK6K1FSSQSx/6xGX6io6dx3CiiimAUUUUAFFFOjQyOFXqaALOmw77hXP3F5roIsAYw
eap20aRxbF6D9avwYJGT74NclWVwRYjXgAGrSKfXr1qGLBOfX0qzF14PJHWuVstE0YO33qRQQRkg
mmKRjgmpMg8j86zKBAAP0p46gDjFNB46dKXnaCevtSA5rxrp2ZF1CEfI52yjHRux/GuUr1CRUlil
hmG6GQYZa891iwbTr6SA5KDlGPdexr0MNV5lyvchoo0UUV1EhRRRQAUUUUAFFFFABRRRQAUUUUAF
FFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUU
UUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUASCeQdG/Sni7mHR6gopcqAux6l
cKeWyPSmXkscyq6x7HP3sdG/wqrRSUEtUFgoooqgCiiigAq9p0Y3biO1QfZ/9r9KvQoFxg4x3qG7
7Gyw1R7IuwMSOR+VWo354JNVki+b73Sp0j4xuyK53BnH9ZpLqW4zyDnmrMUnJwckVpJ4b7m7z/2z
/wDr1Onh/H3brH/bP/69ec8XR/m/BnL/AGvg19v8H/kZkbYbk/pUySZXIBzVIOCRzgn9amjk2gnP
Fdf1efY7PrdHv+ZbBPqKcM4wTmr66XkY87j/AHP/AK9KNJxj9/8Ahs/+vXn/AFql3/M5f7Ywf8/4
P/IzlPJz0qjrFgNUsnRFBuI+Yj39x+NaIhyMZxihYWU8NjHoK1jXjF3TNf7Rw3834P8AyPLmUqxV
gQw4II6Uldt4p8OKbj7ZFNtWU/Muzo3r171hf2H/ANPH/jn/ANevtf8AV7MUvepW+cf8xQxtCa5o
y09GY1FFFeMdQUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQ
AUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFAB
RRRQAUUUUASeRJ/cNLHGyuNyGnus5wGDH8a9A+J/xHbx0+mZ0g6f9j83rc+bv37f9hcY2e/WpuTd
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
KKKACiiigAoooFABRTgoo2ilcrkY2inhQaawx0ouDg1qJRRRTJCiiigApcUKKfSuXGN9xm2jbT6O
lK5fIhu2jaKdRRcOVDdoowKWjFFxWExijGadiigdgxigdKBRigdiOiiiqMAooooAKKKKACiiigAo
oooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACii
igAooooAKKKKACiiigAooooAKKKKANr+3f8Ap2/8f/8ArUf27/07f+P/AP1qxaK73meKe8/wX+Rz
/VKXb8yx9p/2P1o+0/7H61XorzuRHf8AWKnc6g+K/wDpy/8AIv8A9ak/4Sv/AKcv/Iv/ANauYorn
+p0f5fzPM/s/D/y/i/8AM6f/AISv/py/8i//AFqP+Er/AOnL/wAi/wD1q5iij6nR/l/Fh/Z+H/l/
F/5nT/8ACV/9OX/kX/61H/CV/wDTl/5F/wDrVzFFH1Oj/L+LD+z8P/L+L/zLX2jj7v600XP+z+tQ
ngU0VvyI7HTiuhIDRSCloNwHBzQy5oFO6U7goRIiMUgpz9abTRlLR6BmnKc5ptOSnYIti96Wk70V
JohaKKWkUJRRRQAUUUCgBcikFLSYoGdp/wAJxx/yD/8AyP8A/Y0n/Cc/9Q7/AMj/AP2NcZnigH2r
j/s/D/y/i/8AM8v+x8H/ACfi/wDMjooorvOsKKKKACiiigAooooAKKKKACiiigAooooAKKKKACii
igAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKPpR2xQAUUUUAFFFHPp
QAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAL2pB1o7UDrQUPpcUlKKk1QgNPpopQaRSGyUyn
vTKpGNTcKVetJSr1pkIXpS0GjrUmwoooopFCUlOoFArXCijFKBQOwlFOptA7C4pMUZzRuoFoR0UU
VZzhRRRQAUUUUAFFFFABRRXpPxk+F/8Awrf+yP8Aib/2l/aHnf8ALt5Pl+Xs/wBts53+3SgDzaii
igAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKK
ACiiigAoycYycUUUAFFFFABRRRQAUUUUAFFFFABRRRQMKKKBQIKKKKB2CjNFBoBDxSg00HilzU2N
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
zjru5ob8wtcdMjqp3ncaqLJt6RitBIFz87D35zTtkCLyRmoUrFalVblk5EQqGRvMOWwKuS3MRGFx
+VUmUSN8nFVH0JfqCIhOC1TxQxg5L8VCtuxPNO+zY703buFmPnKrxGwP4VCksgNSrAq85qTeijqK
V0Fn1IjLOw70iQ7slzinNcL2BNRG4YjAwKauBKIV59PWlDRxng81WZ2PVjTaOV9QuWXuBjjmozOx
HpUVFNRSC4pZj1Y0lFFUIKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiigc9KACitFdHuOPN
eCP/AHpRSjTYlYia+hUeqgv/ACqeeIGbRWoltpay4kvJ3T1WLGfzNM/4lqFhsnf0yQKXOuiHYzqK
00vLSM5isI89/MYvn8KsRa48J3W9nbxvnIKp0o5n0QJGRFbzTf6mKST/AHVJqc6beiJpWtZlRRkk
oQAK0I9f1ZC32e5ljB7JwKqTz396SJXmlPcEk0lKXWw+Uz6Ktppt0/3YWJ9Kjms5oSPMTbn1qlJd
xWZBRSlSvUYpKoQUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRSrjPzZxQAlFWEjjZ
TjOaa8G3oaXMgIlGTjOKmjgU/eamiE9yKcIcjrSbAnKW6jkZ/GmNLCp+RR+VNFqfWpFssgknpUXX
Vj16ERuTn5U4pjTyHPOKneNYyRwaa2GU9Kat2HYg81j94mljZSfm6U4QZHJphUJ71WhJb8yILgEZ
qN4vN5TioA4HaporgL6CptbYfqMe3ZByRSRFAfmJxVqa4R4dpPPqBVMRkk7ckU029wuXIjEAD1q0
lxCB82M1mrA2Opo+z89alxT6grovSXkSj5ACc1Ve9YnjNILYZ5PFPEaJ3oUYoepAZpXPU0ghdu/N
TmaNemM1G1yc8CqV+iFZCrbjHzHmnhUTngVXaZz3wKjJJ6mjlY7ottOq9OajNw2OBUFFPlQrsczs
3U02iiqEFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAH41Z
ggRpFE06op6t1x+AquBnvSgDmkNRZful0+KXbbSS3Cj+LZtH601IRcuqwxrEOhZ24qoJNv3RSGVj
3qeVjbOkisNJt4B9ouxJL1IUcChH0mPcSXY9hsx/WuZ3t60u9sdTWbpN7sOY6RdUtYhiOAk+5xTI
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
Z/8Ar0BczunJNAOeMV3v/CvDtB/tX/yX/wDsq4UISO9FguhtKB7U8IcjNSAKOnX3osw5kRAcZ5NJ
5ZI5AqXcozUfngZ5xSsxpoTyRjkinqqKM/zqs82c4NRl2IxnijlfUZcaVVqNpxVUknqaKrlC5L57
dqYZGPU02inZAFFFFMAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKK
ACiiigAooooAKKKKACiiigAooooAKKKKACiilCk0BcSinbDjrTcHvTSuFwoooosAUUUUgCiiigAo
oooAKKKKACiiigDa/tz/AKd//H//AK1H9uf9O/8A4/8A/WrForD6vT7HP9VpdvzNr+3P+nf/AMf/
APrUf25/07/+P/8A1qxaKPq9PsH1Wl2/M2v7c/6d/wDx/wD+tR/bn/Tv/wCP/wD1qxaKPq9PsH1W
l2/M3v8AhIv+nX/yJ/8AWo/4SL/p1/8AIn/1qwaKX1Wl2/MX1Oj/AC/mW/tn/TP9acL7H/LP/wAe
qlRWvs49jX2UOw7fT94/GoqKqxdibcCPSnKQevSq9FFgsW4wpPepgqgcVQWRgetO85/WocWBdLqD
1GajedR0PNUixPc0U1ACZrjI4phkY96ZRVKKQwJJ70UUUwCiiigAooooAKKKKACiiigAooooAKKK
KACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACikp4QmgaV
xtA56VKIh3NSKMDAFTzFKD6kAQntT1iHepR9BS9aXMWoIj246UoAp20DjmnDHtSuVYi285GaCmal
z6Ck7daLhYi8kdjTPLPOKsA+gpMj0xQmxcqN/wAD+LD4W+25svtX2nZ/y12bdu72OfvfpXU/8La/
6gv/AJNf/YV5u3IppiWqUiHTPSv+Ftf9QX/ya/8AsKP+Ftf9QX/ya/8AsK8zMPoajMZFO6JcWeof
8La/6gv/AJNf/YUf8La/6gv/AJNf/YV5bRTJPUv+Ftf9QX/ya/8AsKP+Ftf9QX/ya/8AsK8tooA9
S/4W1/1Bf/Jr/wCwrlfHPi3/AISn7F/oX2X7Nv8A+Wu/du2+wx939a5eigAooooAKKKKACiiigAo
oooAKKKKACiiigAooooAKK2v7d/6dv8Ax/8A+tS/27/07f8AkT/61Y89T+T8Tn9pV/k/FGJRXT/8
JX/05f8AkX/61H/CV/8ATl/5F/8ArVn7Wt/z7/FGftsR/wA+v/JkcxRXT/8ACV/9OX/kX/61H/CV
/wDTl/5F/wDrUe1rf8+/xQe2xH/Pr/yZHMUV0/8Awlf/AE5f+Rf/AK1H/CV/9OX/AJF/+tR7Wt/z
7/FB7bEf8+v/ACZHMUV0/wDwlf8A05f+Rf8A61H/AAlf/Tl/5F/+tR7Wt/z7/FB7bEf8+v8AyZHM
UV0//CV/9OX/AJF/+tR/wlf/AE5f+Rf/AK1Hta3/AD7/ABQe2xH/AD6/8mRzFFdP/wAJX/05f+Rf
/rUf8JX/ANOX/kX/AOtR7Wt/z7/FB7bEf8+v/JkcxRXT/wDCV/8ATl/5F/8ArUf8JX/05f8AkX/6
1Hta3/Pv8UHtsR/z6/8AJkcxRXT/APCV/wDTl/5F/wDrUf8ACV/9OX/kX/61Hta3/Pv8UHtsR/z6
/wDJkcxRXT/8JX/05f8AkX/61H/CV/8ATl/5F/8ArUe1rf8APv8AFB7bEf8APr/yZHMUV0//AAlf
/Tl/5F/+tR/wlf8A05f+Rf8A61Hta3/Pv8UHtsR/z6/8mRzFFdP/AMJX/wBOX/kX/wCtR/wlf/Tl
/wCRf/rUe1rf8+/xQe2xH/Pr/wAmRzFFdP8A8JX/ANOX/kX/AOtR/wAJX/05f+Rf/rUe1rf8+/xQ
e2xH/Pr/AMmRzFb3irw7/YP2X/SvtHn7v+Wezbtx7n1qz/wlf/Tl/wCRf/rUf8JX/wBOX/kX/wCt
R7Wt/wA+/wAUHtsR/wA+v/JkcxRXT/8ACV/9OX/kX/61H/CV/wDTl/5F/wDrUe1rf8+/xQe2xH/P
r/yZHMUV0/8Awlf/AE5f+Rf/AK1H/CV/9OX/AJF/+tR7Wt/z7/FB7bEf8+v/ACZHMUV0/wDwlf8A
05f+Rf8A61H/AAlf/Tl/5F/+tR7Wt/z7/FB7bEf8+v8AyZHMUV0//CV/9OX/AJF/+tR/wlf/AE5f
+Rf/AK1Hta3/AD7/ABQe2xH/AD6/8mRzFFdP/wAJX/05f+Rf/rUf8JX/ANOX/kX/AOtR7Wt/z7/F
B7bEf8+v/JkcxRWz/bn/AE7/APj/AP8AWpy6yx/5dv8Ax/8A+tWntKn8v4mntKr+x+KMSit9dVOe
YB/33/8AWp41dR/yw/8AH/8A61S6s/5fxK5q/wDz7/FHPBCe1SJCTW4dZA/5YA/8D/8ArU46zj/l
h/4//wDWpe1qfy/iNTrL/l1+KMVQAMAc04DHXiupHi7P/Lh/5G/+xo/4S0g8WPT/AKbf/Y1j7av/
AM+/xRH1jF/8+P8AyZHLYANLx7V0v/CVOw5tP/In/wBahPFJHBs8/wDbX/61P2tb/n3+KK+sYv8A
58/+TI5o4703OKcF9CKdt9a6TvG8nvSYJp+2lHFADD9Kb1P+FTYppoEMHAOMnFKBkClGDR0oGIMC
kzilHOetNPAwKBAPrTscHmmg+1GOPpTE7iFAwyRmmGEV3C+N8jP9n8f9dv8A7GnjxqP+fD/yN/8A
Y1xfWMQv+XX/AJMjy3icY/8AmH/8mRwRiIphUjtXoH/Caf8ATh/5G/8AsaP+E05wdP8A/I3/ANjT
WJxH/Pr/AMmQvb4z/oH/APJkefUV3x8Zgk507H/bb/7GmnxjjpYf+Rv/ALGn9ZxH/Pr/AMmQvb4z
/nx/5Mj/2Q==
--0016e6d376615567eb0464294108--
