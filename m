From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 5/7] Serial: OMAP: add runtime pm support for omap-serial driver
Date: Wed, 09 Mar 2011 15:06:24 -0800
Message-ID: <87oc5jvqq7.fsf@ti.com>
References: <1298903958-6496-1-git-send-email-govindraj.raja@ti.com>
	<1298903958-6496-6-git-send-email-govindraj.raja@ti.com>
	<87r5am499h.fsf@ti.com>
	<AANLkTim35McK1cFFEXyS49D6b8CT+4pQfmKAswOn3e7_@mail.gmail.com>
	<87hbbdjc7y.fsf@ti.com>
	<AANLkTim0Xuu8Bs4tzyH1kQp2eS5nUq8stQX4MGzELEE6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <AANLkTim0Xuu8Bs4tzyH1kQp2eS5nUq8stQX4MGzELEE6@mail.gmail.com>
	(Govindraj's message of "Wed, 9 Mar 2011 20:37:11 +0530")
Sender: linux-serial-owner@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

Govindraj <govindraj.ti@gmail.com> writes:

[...]

>>
>> So here's an experiment to try with autosuspend. =C2=A0I suspect thi=
s will
>> work, just hack it up to prove the concept. =C2=A0If it works, we ca=
n make
>> something more generic. =C2=A0Here are a few alternatives to try. =C2=
=A0I may
>> experiment with some of them tomorrow as well, but please let me kno=
w
>> what you try:
>>
>> Using autosuspend, clocks will get cut independently of the idle pat=
h.
>> Then, use the PRCM ISR detection of UART module wakeups to call the
>> UART's interrupt handler. =C2=A0The interrupt handler will pm_runtim=
e_get(),
>> enable the clocks, and then take care of the interrupt. =C2=A0Done.
>>
>> Alternatively, you could test it on current code by simply removing =
the
>> resume_from_idle call from the idle path and calling it instead from=
 the
>> PRCM ISR when UART module wakeups are detected.
>
> I remember doing similar experiment didn't seem to help,
>

To show it's possible, I did really hacky proof of concept, hard-coded
to UART3 console for n900/beagle, but at least it shows that this
approach can work, and the module-level wakeups are working and can be
used as the trigger for UART wakeup instead of resume_from_idle.  Of
course, it still has problems with using serial after non-UART wakeups,
but once omap-serial is using runtime PM, that will no longer be an
issue.

My hacky branch is called pm-wip/uart-wkup and is in my pm git tree[1]
(based at the pm-core branch)

To test module-level wakeups (instead of IO-ring) I again forced CORE t=
o
stay on during suspend, and tested wakeup from suspend on 3430/n900:

  echo 3 > /debug/pm_debug/core_pwrdm/suspend
  echo mem > /sys/power/state

Kevin

[1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm=
=2Egit

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
