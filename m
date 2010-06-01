From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Tue, 01 Jun 2010 09:57:31 +0300
Message-ID: <4C04AF5B.1000702@nokia.com>
References: <Pine.LNX.4.44L0.1005271253240.3239-100000@iolanthe.rowland.org>	<201005302202.39511.rjw@sisk.pl>	<AANLkTilUQ2AG76nbK6LwI8_7zw0_yMSoAOr9pmuz7xrt@mail.gmail.com>	<201005312347.24251.rjw@sisk.pl> <AANLkTilvOgSFTDFtXbjJobMZWxgfvsC97TqC7_a_NHBX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTilvOgSFTDFtXbjJobMZWxgfvsC97TqC7_a_NHBX@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?ext_Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Peter Zijlstra <peterz@infradead.org>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

Hi,

ext Arve Hj=F8nnev=E5g wrote:

> It sounded like you were suggesting that initiating suspend from idle
> would somehow avoid the race condition with wakeup events. All I'm
> saying is that you would need to block suspend in all the same places=
=2E
> If you don't care about ignoring wakeup events, then sure you can
> initiate suspend from idle.
>  =20

Sorry if i'm asking something that was already said, but the thread is=20
quite complex and i am not sure i have been able to grasp all of it.

So, regardless of the SW implementation:

-1) are you focusing on "good" HW or do you want to address all at the=20
same time?

-2) would you be ok with addressing "bad" HW as a special case, which=20
requires workarounds and shouldn't dictate the overall design?

-3) do you agree with the assumption that new HW is expected to get=20
reasonably better and therefore workarounds at point 2) will=20
progressively be confined to devices less and less common?

-4) going to the definition of "good" and "bad" (maybe this should have=
=20
come earlier in the list), can we define "good" HW as HW where:
 * suspend state and lowest achievable runtime idle state are basically=
=20
equivalent from both power consumption and latency pov
 * the HW itself is properly able to track wakeup sources while it is i=
n=20
its deepest power state (as example OMAP3 has few independent=20
wake-capable pads and a "wake ring" where one only gets the information=
=20
that at least one of the pads belonging to such ring has received a wak=
eup)
 * wakeup sources can be dynamically masked at HW level, so that if a=20
peripheral is not interesting, it doesn't wakeup the system (for exampl=
e=20
the camera button when the camera cover is closed)

-5) HW that is not capable of properly generating asynchronous signal i=
s=20
most likely the cause for extra timers in kernel and it should be=20
considered "bad" - in any other case having recurring in-kernel timers=20
should be treated as bugs, if their existence is not tied to some=20
meaningful work

thanks, igor
