From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: mysterious crashes on OMAP5 uevm
Date: Thu, 10 Sep 2015 10:57:31 +0200
Message-ID: <167B7D55-F7B8-4C39-AD85-AB99624E784C@goldelico.com>
References: <CANOLnOO3NdK1r1jZQtS=TcHEE7SQwhGHh0YsqqoCJpFW3NO05Q@mail.gmail.com>
 <20150908143810.GD4215@atomide.com>
 <CANOLnOODjTaBcL1QzAm7o4YOB=_P-s7JYovu6fhNSqJSV2Bq+Q@mail.gmail.com>
 <20150908210708.GH4215@atomide.com>
 <E0068B56-0DEE-4E2F-94CF-DB104AE16D63@goldelico.com>
 <20150910083026.GA21098@n2100.arm.linux.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150910083026.GA21098@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Grazvydas Ignotas <notasas@gmail.com>, Marek Belisko <marek@goldelico.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


Am 10.09.2015 um 10:30 schrieb Russell King - ARM Linux <linux@arm.linux.or=
g.uk>:

> On Thu, Sep 10, 2015 at 08:42:57AM +0200, Dr. H. Nikolaus Schaller wrote:
>> =

>> Am 08.09.2015 um 23:07 schrieb Tony Lindgren <tony@atomide.com>:
>> =

>>> * Grazvydas Ignotas <notasas@gmail.com> [150908 13:44]:
>>>> On Tue, Sep 8, 2015 at 4:38 PM, Tony Lindgren <tony@atomide.com> wrote:
>>>>> * Grazvydas Ignotas <notasas@gmail.com> [150908 05:50]:
>>>>>> Hi,
>>>>>> =

>>>>>> this is a longstanding problem I'm seeing since the very beginning,
>>>>>> which was around 3.12 or so (when I've first got the hardware) and it
>>>>>> seems 4.2 is affected by it still. Basically what happens is Xorg
>>>>>> randomly segfaults at some "impossible" location. I don't have the
>>>>>> details at the moment (could get them is needed), but from what I
>>>>>> examined with gdb some time ago the situation did not make any sense.
>>>>>> =

>>>>>> There are 2 workarounds that I know which make the problem go away
>>>>>> (one is enough):
>>>>>> - recompile Xorg with -marm (I'm using Debian armhf so it's thumb2 b=
y default)
>>>>>> - disable ARCH_MULTI_V6 in the kernel config
>>>>>> =

>>>>>> Because of the above workarounds I have forgotten about it several
>>>>>> times, but it regularly comes back and bites again. It would look li=
ke
>>>>>> some missing erratum workaround, but I have all of them enabled in t=
he
>>>>>> kernel.
>>>>>> =

>>>>>> Does anyone know about this? Perhaps some missing erratum workaround
>>>>>> in the bootloader? u-boot isn't too old here (2015.07).
>>>>> =

>>>>> Seems like some incorrect handling with CONFIG_CPU_V6 compiled in..
>>>>> Maybe try to narrow it down by commenting out some CONFIG_CPU_V6 and
>>>>> __LINUX_ARM_ARCH__ =3D 6 ifdefs in the git grep CONFIG_CPU_V6
>>>>> places ignoring uncompress and davinci code.
>>>> =

>>>> ok with that it was quite easy to find. On a kernel with ARCH_MULTI_V6
>>>> disabled, it is enough to just do this:
>>>> =

>>>> --- a/arch/arm/kernel/signal.c
>>>> +++ b/arch/arm/kernel/signal.c
>>>> @@ -340,13 +340,13 @@ setup_return(struct pt_regs *regs, struct ksigna=
l *ksig,
>>>>               /*
>>>>                * The LSB of the handler determines if we're going to
>>>>                * be using THUMB or ARM mode for this signal handler.
>>>>                */
>>>>               thumb =3D handler & 1;
>>>> =

>>>> -#if __LINUX_ARM_ARCH__ >=3D 7
>>>> +#if 0 //__LINUX_ARM_ARCH__ >=3D 7
>>>>               /*
>>>>                * Clear the If-Then Thumb-2 execution state
>>>>                * ARM spec requires this to be all 000s in ARM mode
>>>>                * Snapdragon S4/Krait misbehaves on a Thumb=3D>ARM
>>>>                * signal transition without this.
>>>>                */
>>>> =

>>>> ... and the problem appears, so I guess this needs some real
>>>> multiplatform handling,.
>>> =

>>> OK nice to hear you found it. Yeah looks like some runtime
>>> capability check is needed.
>>> =

>>>>> Do you have some easy way to reproduce this issue?
>>>> =

>>>> Just moving a browser window around with mouse usually triggers it
>>>> within a minute.
>>> =

>>> OK good to know.
>> =

>> It looks as if this is the solution for the same symptom on our OMAP3 bo=
ard (gta04).
>> There, it suffices to draw on the touch screen for ~10 seconds to make t=
he xserver segfault.
>> =

>> [we are using the binary xserver from debian wheezy
>> ii  xserver-xorg-core                        2:1.12.4-6+deb7u5          =
   armhf        Xorg X server - core server]
>> =

>> We know about this bug for a while, but so far did think that some touch=
 screen
>> event bit has changed and we have to fix our touch screen driver.
>> =

>> Now, disabling CONFIG_ARCH_MULTI_V6 also makes the bug go away and addin=
g the
>>>> #if 0 //__LINUX_ARM_ARCH__ >=3D 7
>> makes it re-appear.
>> =

>> A while ago I tried to debug running the x-server under strace and could=
 find that it also has
>> something to do with SIGALRM.
>> =

>> And that is very consistent with =93enable/disable=94 by modifying arch/=
arm/kernel/signal.c
> =

> It would be really nice if someone could diagnose what's going on here.
> What exception is causing the X server to be killed (someone said a
> segfault)?  What is the register state at the point that happens?  What
> does the code look like  Is it happening inside the SIGALRM handler, or
> when the SIGALRM handler has returned?
> =

> I'd suggest attaching gdb to the X server, but remember to set gdb to
> ignore SIGPIPEs.

I don=92t have a setup to run gdb (with source) on the device and really ze=
ro
experience with Xserver sources. But maybe Grazvydas can do that better
than me.

Attached is some strace I had recorded during my earlier experiments.
X-Server appears not only to heavily use SIGALRM but SIGIO.

And it looks as if it a SEGFAULT appears inside the SIGIO handler after
having done 3 syscalls (select, read, clock_gettime) but before the
sigreturn. At least in this example.

Xserver then does a graceful shutdown after SEGFAULT. I.e. it prints the
segfault message by itself.

Hope this is a useful piece to solve the puzzle and helps a little.

BR,
Nikolaus

=85
--- SIGALRM (Alarm clock) @ 0 (0) ---
--- SIGIO (I/O possible) @ 0 (0) ---
select(12, [9 10 11], NULL, NULL, {0, 0}) =3D 1 (in [9], left {0, 0})
read(9, ";\230\353T^\351\n\0\3\0\0\0:\4\0\0;\230\353T^\351\n\0\3\0\1\0=3D\7=
\0\0"..., 256) =3D 64
clock_gettime(CLOCK_MONOTONIC, {7330, 494831541}) =3D 0
sigreturn()                             =3D ? (mask now [ILL ABRT KILL USR1=
 SEGV PIPE TERM STKFLT CHLD STOP TSTP TTIN XFSZ VTALRM PROF IO PWR RTMIN])
sigreturn()                             =3D ? (mask now [])
setitimer(ITIMER_REAL, {it_interval=3D{0, 0}, it_value=3D{0, 0}}, NULL) =3D=
 0
select(256, [1 3 4 5 12 13 14 15 16 19], NULL, NULL, {0, 0}) =3D 1 (in [19]=
, left {0, 0})
clock_gettime(CLOCK_MONOTONIC, {7330, 499042967}) =3D 0
setitimer(ITIMER_REAL, {it_interval=3D{0, 20000}, it_value=3D{0, 20000}}, N=
ULL) =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 500050047}) =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 501911619}) =3D 0
--- SIGIO (I/O possible) @ 0 (0) ---
select(12, [9 10 11], NULL, NULL, {0, 0}) =3D 1 (in [9], left {0, 0})
read(9, ";\230\353Tw\20\v\0\3\0\0\0h\4\0\0;\230\353Tw\20\v\0\3\0\1\0\256\7\=
0\0"..., 256) =3D 64
clock_gettime(CLOCK_MONOTONIC, {7330, 504536131}) =3D 0
sigreturn()                             =3D ? (mask now [HUP QUIT ILL])
clock_gettime(CLOCK_MONOTONIC, {7330, 506275633}) =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 506855467}) =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 507587889}) =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 508442381}) =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 508961180}) =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 509418943}) =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 509998777}) =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 511860350}) =3D 0
--- SIGIO (I/O possible) @ 0 (0) ---
select(12, [9 10 11], NULL, NULL, {0, 0}) =3D 1 (in [9], left {0, 0})
read(9, ";\230\353TT7\v\0\3\0\0\0\242\4\0\0;\230\353TT7\v\0\3\0\1\0\367\7\0=
\0"..., 256) =3D 64
clock_gettime(CLOCK_MONOTONIC, {7330, 514484861}) =3D 0
sigreturn()                             =3D ? (mask now [])
clock_gettime(CLOCK_MONOTONIC, {7330, 516224363}) =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 516743162}) =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 517200926}) =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 517719725}) =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 518452147}) =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 519367674}) =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 519947508}) =3D 0
--- SIGALRM (Alarm clock) @ 0 (0) ---
sigreturn()                             =3D ? (mask now [])
--- SIGIO (I/O possible) @ 0 (0) ---
select(12, [9 10 11], NULL, NULL, {0, 0}) =3D 1 (in [9], left {0, 0})
read(9, ";\230\353Tn^\v\0\3\0\0\0\370\4\0\0;\230\353Tn^\v\0\3\0\1\0y\10\0\0=
"..., 256) =3D 64
clock_gettime(CLOCK_MONOTONIC, {7330, 525074461}) =3D 0
sigreturn()                             =3D ? (mask now [])
setitimer(ITIMER_REAL, {it_interval=3D{0, 0}, it_value=3D{0, 0}}, NULL) =3D=
 0
select(256, [1 3 4 5 12 13 14 15 16 19], NULL, NULL, {0, 0}) =3D 1 (in [19]=
, left {0, 0})
clock_gettime(CLOCK_MONOTONIC, {7330, 528400877}) =3D 0
setitimer(ITIMER_REAL, {it_interval=3D{0, 20000}, it_value=3D{0, 20000}}, N=
ULL) =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 529377440}) =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 530018309}) =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 531910399}) =3D 0
--- SIGIO (I/O possible) @ 0 (0) ---
select(12, [9 10 11], NULL, NULL, {0, 0}) =3D 1 (in [9], left {0, 0})
read(9, ";\230\353T\246\205\v\0\3\0\0\0V\5\0\0;\230\353T\246\205\v\0\3\0\1\=
0\336\10\0\0"..., 256) =3D 64
clock_gettime(CLOCK_MONOTONIC, {7330, 534534910}) =3D 0
sigreturn()                             =3D ? (mask now [HUP QUIT ILL])
writev(20, [{"\6\0T\3\256\332o\0\345\0\0\0\3\0\0\1\0\0\0\0h\0\377\0h\0\377\=
0\0\1\1\0"..., 224}], 1) =3D 224
clock_gettime(CLOCK_MONOTONIC, {7330, 542164305}) =3D 0
--- SIGIO (I/O possible) @ 0 (0) ---
select(12, [9 10 11], NULL, NULL, {0, 0}) =3D 1 (in [9], left {0, 0})
read(9, ";\230\353TX\255\v\0\3\0\0\0\317\5\0\0;\230\353TX\255\v\0\3\0\1\0T\=
t\0\0"..., 256) =3D 64
clock_gettime(CLOCK_MONOTONIC, {7330, 546253660}) =3D 0
sigreturn()                             =3D ? (mask now [HUP QUIT ILL])
read(20, "5\20\4\0\236\0\0\1\3\0\0\1\33\1\257\0\224\4\6\0\237\0\0\1\236\0\0=
\1)\0\0\0"..., 4096) =3D 1088
clock_gettime(CLOCK_MONOTONIC, {7330, 548756102}) =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 549366453}) =3D 0
--- SIGALRM (Alarm clock) @ 0 (0) ---
sigreturn()                             =3D ? (mask now [HUP QUIT ILL])
--- SIGIO (I/O possible) @ 0 (0) ---
select(12, [9 10 11], NULL, NULL, {0, 0}) =3D 1 (in [9], left {0, 0})
read(9, ";\230\353T\273\323\v\0\3\0\0\0K\6\0\0;\230\353T\273\323\v\0\3\0\1\=
0\314\t\0\0"..., 256) =3D 64
clock_gettime(CLOCK_MONOTONIC, {7330, 554707029}) =3D 0
sigreturn()                             =3D ? (mask now [HUP QUIT ILL])
setitimer(ITIMER_REAL, {it_interval=3D{0, 0}, it_value=3D{0, 0}}, NULL) =3D=
 0
select(256, [1 3 4 5 12 13 14 15 16 19], NULL, NULL, {0, 0}) =3D 1 (in [19]=
, left {0, 0})
clock_gettime(CLOCK_MONOTONIC, {7330, 558155516}) =3D 0
setitimer(ITIMER_REAL, {it_interval=3D{0, 20000}, it_value=3D{0, 20000}}, N=
ULL) =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 559132078}) =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 560749510}) =3D 0
--- SIGIO (I/O possible) @ 0 (0) ---
select(12, [9 10 11], NULL, NULL, {0, 0}) =3D 1 (in [9], left {0, 0})
read(9, ";\230\353T\325\372\v\0\3\0\0\0\326\6\0\0;\230\353T\325\372\v\0\3\0=
\1\0:\n\0\0"..., 256) =3D 64
clock_gettime(CLOCK_MONOTONIC, {7330, 564564207}) =3D 0
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
write(2, "\n", 1
)                       =3D 1
clock_gettime(CLOCK_MONOTONIC, {7330, 565968016}) =3D 0
write(0, "[  7330.565] ", 13)           =3D 13
write(0, "\n", 1)                       =3D 1
write(2, "Backtrace:\n", 11Backtrace:
)            =3D 11
clock_gettime(CLOCK_MONOTONIC, {7330, 568195799}) =3D 0
write(0, "[  7330.568] ", 13)           =3D 13
write(0, "Backtrace:\n", 11)            =3D 11
write(2, "\n", 1
)                       =3D 1
clock_gettime(CLOCK_MONOTONIC, {7330, 571125486}) =3D 0
write(0, "[  7330.571] ", 13)           =3D 13
write(0, "\n", 1)                       =3D 1
futex(0xb6c587d0, FUTEX_WAKE_PRIVATE, 2147483647) =3D 0
write(2, "Segmentation fault at address (n"..., 36Segmentation fault at add=
ress (nil)
) =3D 36
clock_gettime(CLOCK_MONOTONIC, {7330, 575092772}) =3D 0
write(0, "[  7330.575] ", 13)           =3D 13
write(0, "Segmentation fault at address (n"..., 36) =3D 36
write(2, "\nFatal server error:\n", 21
Fatal server error:
) =3D 21
clock_gettime(CLOCK_MONOTONIC, {7330, 577412108}) =3D 0
write(0, "[  7330.577] ", 13)           =3D 13
write(0, "\nFatal server error:\n", 21) =3D 21
write(2, "Caught signal 11 (Segmentation f"..., 55Caught signal 11 (Segment=
ation fault). Server aborting
) =3D 55
--- SIGALRM (Alarm clock) @ 0 (0) ---
sigreturn()                             =3D ? (mask now [ABRT BUS FPE USR1 =
SEGV USR2 ALRM STKFLT CHLD CONT TTIN TTOU URG XCPU VTALRM PROF WINCH IO PWR=
 RTMIN])
clock_gettime(CLOCK_MONOTONIC, {7330, 582752684}) =3D 0
write(0, "[  7330.582] ", 13)           =3D 13
write(0, "Caught signal 11 (Segmentation f"..., 55) =3D 55
write(2, "\n", 1
)                       =3D 1
clock_gettime(CLOCK_MONOTONIC, {7330, 585041502}) =3D 0
write(0, "[  7330.585] ", 13)           =3D 13
write(0, "\n", 1)                       =3D 1
write(2, "\nPlease consult the The X.Org Fo"..., 85
Please consult the The X.Org Foundation support =

	 at http://wiki.x.org
for help. =

) =3D 85
clock_gettime(CLOCK_MONOTONIC, {7330, 587208250}) =3D 0
write(0, "[  7330.587] ", 13)           =3D 13
write(0, "\nPlease consult the The X.Org Fo"..., 85) =3D 85
write(2, "Please also check the log file a"..., 84Please also check the log=
 file at "/var/log/Xorg.0.log" for additional information.
) =3D 84
clock_gettime(CLOCK_MONOTONIC, {7330, 589466551}) =3D 0
write(0, "[  7330.589] ", 13)           =3D 13
write(0, "Please also check the log file a"..., 84) =3D 84
write(2, "\n", 1
)                       =3D 1
clock_gettime(CLOCK_MONOTONIC, {7330, 593525389}) =3D 0
write(0, "[  7330.593] ", 13)           =3D 13
write(0, "\n", 1)                       =3D 1
close(1)                                =3D 0
close(3)                                =3D 0
close(4)                                =3D 0
close(5)                                =3D 0
unlink("/tmp/.X11-unix/X0")             =3D 0
unlink("/tmp/.X0-lock")                 =3D 0
rt_sigprocmask(SIG_BLOCK, [ALRM CHLD TSTP TTIN TTOU VTALRM WINCH IO], [SEGV=
 IO], 8) =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 599567869}) =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 601948240}) =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 603168943}) =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 604145506}) =3D 0
fcntl64(9, F_GETFL)                     =3D 0x2802 (flags O_RDWR|O_NONBLOCK=
|O_ASYNC)
fcntl64(9, F_SETFL, O_RDWR|O_NONBLOCK)  =3D 0
fcntl64(9, F_GETFD)                     =3D 0
close(9)                                =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 606983641}) =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 608509520}) =3D 0
write(0, "[  7330.608] ", 13)           =3D 13
write(0, "(II) evdev: Touchscreen: Close\n", 31) =3D 31
clock_gettime(CLOCK_MONOTONIC, {7330, 610798338}) =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 611408690}) =3D 0
write(0, "[  7330.611] ", 13)           =3D 13
write(0, "(II) UnloadModule: \"evdev\"\n", 27) =3D 27
clock_gettime(CLOCK_MONOTONIC, {7330, 613361815}) =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 614368895}) =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 615009764}) =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 615986326}) =3D 0
fcntl64(10, F_GETFL)                    =3D 0x2802 (flags O_RDWR|O_NONBLOCK=
|O_ASYNC)
fcntl64(10, F_SETFL, O_RDWR|O_NONBLOCK) =3D 0
fcntl64(10, F_GETFD)                    =3D 0
close(10)                               =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 618336180}) =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 619007567}) =3D 0
write(0, "[  7330.619] ", 13)           =3D 13
write(0, "(II) evdev: Power Button: Close\n", 32) =3D 32
clock_gettime(CLOCK_MONOTONIC, {7330, 621601561}) =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 622181395}) =3D 0
write(0, "[  7330.622] ", 13)           =3D 13
write(0, "(II) UnloadModule: \"evdev\"\n", 27) =3D 27
fcntl64(11, F_GETFL)                    =3D 0x2802 (flags O_RDWR|O_NONBLOCK=
|O_ASYNC)
fcntl64(11, F_SETFL, O_RDWR|O_NONBLOCK) =3D 0
fcntl64(11, F_GETFD)                    =3D 0
rt_sigaction(SIGIO, {SIG_IGN, [IO], 0x4000000 /* SA_??? */}, {0xb6f0d63d, [=
IO], 0x4000000 /* SA_??? */}, 8) =3D 0
close(11)                               =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 626606443}) =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 627308348}) =3D 0
write(0, "[  7330.627] ", 13)           =3D 13
write(0, "(II) evdev: AUX Button: Close\n", 30) =3D 30
clock_gettime(CLOCK_MONOTONIC, {7330, 629261473}) =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 629810789}) =3D 0
write(0, "[  7330.629] ", 13)           =3D 13
write(0, "(II) UnloadModule: \"evdev\"\n", 27) =3D 27
rt_sigprocmask(SIG_SETMASK, [SEGV IO], NULL, 8) =3D 0
--- SIGALRM (Alarm clock) @ 0 (0) ---
sigreturn()                             =3D ? (mask now [])
rt_sigprocmask(SIG_BLOCK, [IO], [SEGV IO], 8) =3D 0
clock_gettime(CLOCK_MONOTONIC, {7330, 634663084}) =3D 0
write(0, "[  7330.634] ", 13)           =3D 13
write(0, "(NI) OMAPFBLeaveVT\n", 19)    =3D 19
ioctl(7, KDSETMODE, 0)                  =3D 0
--- SIGALRM (Alarm clock) @ 0 (0) ---
sigreturn()                             =3D ? (mask now [])
ioctl(7, KDSKBMODE, 0x3)                =3D 0
ioctl(7, SNDCTL_TMR_TIMEBASE or TCGETS, {B38400 -opost -isig -icanon -echo =
...}) =3D 0
ioctl(7, SNDCTL_TMR_START or TCSETS, {B38400 opost isig icanon echo ...}) =
=3D 0
ioctl(7, SNDCTL_TMR_TIMEBASE or TCGETS, {B38400 opost isig icanon echo ...}=
) =3D 0
ioctl(7, VIDIOC_RESERVED or VT_GETMODE, 0xbef3b348) =3D 0
ioctl(7, VIDIOC_ENUM_FMT or VT_SETMODE, 0xbef3b348) =3D 0
ioctl(7, VT_ACTIVATE, 0x1)              =3D 0
ioctl(7, VT_WAITACTIVE, 0x1)            =3D 0
close(7)                                =3D 0
write(2, "Server terminated with error (1)"..., 52Server terminated with er=
ror (1). Closing log file.
) =3D 52
clock_gettime(CLOCK_MONOTONIC, {7330, 655903318}) =3D 0
write(0, "[  7330.655] ", 13)           =3D 13
write(0, "Server terminated with error (1)"..., 52) =3D 52
close(0)                                =3D 0
rt_sigprocmask(SIG_BLOCK, [ALRM CHLD TSTP TTIN TTOU VTALRM WINCH IO], [SEGV=
 IO], 8) =3D 0
rt_sigprocmask(SIG_UNBLOCK, [ABRT], NULL, 8) =3D 0
tgkill(4586, 4586, SIGABRT)             =3D 0
--- SIGABRT (Aborted) @ 0 (0) ---
root@gta04:~# =
