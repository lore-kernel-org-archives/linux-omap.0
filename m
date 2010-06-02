From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 2 Jun 2010 02:32:57 -0700
Message-ID: <AANLkTimE1N76sB6UHm4-YMJ97gQ7-Ztndf97dTLdm5nX@mail.gmail.com>
References: <Pine.LNX.4.44L0.1005271253240.3239-100000@iolanthe.rowland.org>
	<201005302202.39511.rjw@sisk.pl>
	<AANLkTilUQ2AG76nbK6LwI8_7zw0_yMSoAOr9pmuz7xrt@mail.gmail.com>
	<201005312347.24251.rjw@sisk.pl>
	<AANLkTilvOgSFTDFtXbjJobMZWxgfvsC97TqC7_a_NHBX@mail.gmail.com>
	<alpine.LFD.2.00.1006011411200.2933@localhost.localdomain>
	<AANLkTikZHmF6baP7dEXEGFE8YsbEteRjlhb5wqZX8ll1@mail.gmail.com>
	<alpine.LFD.2.00.1006020905410.2933@localhost.localdomain>
	<AANLkTinDm3FIrbS1jqEzW15THmr1hdd7ox0Mllm1VLjZ@mail.gmail.com>
	<alpine.LFD.2.00.1006021059150.2933@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1006021059150.2933@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Florian Mickler <florian@mickler.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Alan Stern <stern@rowland.harvard.edu>, Peter Zijlstra <peterz@infradead.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

2010/6/2 Thomas Gleixner <tglx@linutronix.de>:
> On Wed, 2 Jun 2010, Arve Hj=F8nnev=E5g wrote:
>> 2010/6/2 Thomas Gleixner <tglx@linutronix.de>:
>> > On Tue, 1 Jun 2010, Arve Hj=F8nnev=E5g wrote:
>> >>
>> >> Because suspend itself causes you to not be idle you cannot abort
>> >> suspend just because you are not idle anymore.
>> >
>> > You still are addicted to the current suspend mechanism. :)
>> >
>>
>> No I want you to stop confusing low power idle modes with suspend. I
>> know how to enter low power modes from idle if that low power mode i=
s
>> not too disruptive.
>
> What prevents us from going into a disruptive mode from idle ? I don'=
t
> see a reason - except crappy ACPI stuff, which I'm happy to ignore.
>

What do you consider disruptive? Disabling active interrupts? Stopping
the monotonic clock?

>> > If I understood you correctly then you can shutdown the CPU in idl=
e
>> > completelty already, but that's not enough due to:
>> >
>> > =A0 =A01) crappy applications keeping the cpu away from idle
>> > =A0 =A02) timers firing
>> >
>> > Would solving those two issues be sufficient for you or am I missi=
ng
>> > something ?
>>
>> Solving those two is enough for current android phones, but it may n=
ot
>> be enough for other android devices.
>
> In which way ? May not be enough is a pretty vague statement.

They may not be based on hardware that can get to the same power mode
from idle as suspend. This could be acpi based hardware, it could be
like the hardware we started with that did not have regular timers
that could run in the low power mode, or devices could loose their
state in the lowest power mode.

>
>> 1 is not solvable (meaning we cannot fix all apps),
>
> We can mitigate it with cgroups and confine crap there, i.e. force
> idle them.
>

I think using suspend is much simpler. It avoids having to worry about
dependencies between processes.

>> and 2 is difficult to fix since the periodic
>> work is useful while the device is actually in use. One possible way
>> to solve 2 is to allow timers on a not-idle clock.
>
> That's what I had in mind.
>
>> Unrelated to Android, I also want to use opportunistic suspend on my
>> desktop.
>
> I expect that intel/amd fixing their stuff is going to happen way
> before we sprinkled suspend blockers over a full featured desktop
> distro.
>

You do not need to sprinkle suspend blocker all over the distro for it
to be useful. You can convert the existing auto-suspend code to use
opportunistic suspend and all apps that don't use suspend blocker will
behave as they do today while allowing apps to use suspend blockers to
keep the system running after the auto-suspend timeout expired.

--=20
Arve Hj=F8nnev=E5g
