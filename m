From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/2] OMAP2+: UART: Fix incorrect population of default uart pads
Date: Mon, 07 May 2012 10:39:12 -0700
Message-ID: <87r4uv51rz.fsf@ti.com>
References: <1334065246-21294-1-git-send-email-govindraj.raja@ti.com>
	<1334065246-21294-2-git-send-email-govindraj.raja@ti.com>
	<87397uhv0q.fsf@ti.com>
	<CAMrsUdKnDaO7qV2NpNvTb3QdO-XeM_PF645Mc43RozFVex71hQ@mail.gmail.com>
	<20120504172417.GE5613@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:49544 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757110Ab2EGRi7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 May 2012 13:38:59 -0400
Received: by dadm1 with SMTP id m1so3031417dad.36
        for <linux-omap@vger.kernel.org>; Mon, 07 May 2012 10:38:58 -0700 (PDT)
In-Reply-To: <20120504172417.GE5613@atomide.com> (Tony Lindgren's message of
	"Fri, 4 May 2012 10:24:18 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Raja, Govindraj" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Russ Dill <russ.dill@gmail.com>

Tony Lindgren <tony@atomide.com> writes:

> * Raja, Govindraj <govindraj.raja@ti.com> [120424 01:41]:
>> On Tue, Apr 24, 2012 at 5:15 AM, Kevin Hilman <khilman@ti.com> wrote=
:
>> > "Govindraj.R" <govindraj.raja@ti.com> writes:
>> >
>> >> From: "Govindraj.R" <govindraj.raja@ti.com>
>> >>
>> >> The following commit:
>> >> (7496ba3 =C2=A0ARM: OMAP2+: UART: Add default mux for all uarts)
>> >> added default pads for all uarts. But not all boards tend to
>> >> use all uarts and most of unused uart pins are muxed for
>> >> other purpose. This commit breaks the modules which where trying
>> >> to use unused uart pins on their boards.
>> >>
>> >> So remove the default pads adding.
>> >
>> > I just noticed that this patch breaks runtime PM & wakeups for UAR=
T
>> > console (at least on 3530/Overo with ttyO2 console.)
>> >
>> > By removing the pads, the initial device_init_wakeup() is not call=
ed on
>> > port init. =C2=A0Without this call serial_omap_pm() disables runti=
me PM
>> > because it checks device_may_wakeup().
>> >
>> > Since runtime PM was disabled, I manually re-enabled it and then e=
nabled
>> > wakeups:
>> >
>> > =C2=A0echo auto > /sys/devices/platform/omap_uart.2/power/control
>> > =C2=A0echo enabled > /sys/devices/platform/omap_uart.2/tty/ttyO2/p=
ower/wakeup
>> >
>> > Then, after enabling auto-suspend timeouts, it seems wakeups are s=
till
>> > not working since the console hangs.
>> >
>> > Reverting $SUBJECT patch gets things working again.
>>=20
>> This was decided as part of discussion [1]
>>=20
>> If we are _reconsidering_ taking this patch [2]
>> to dynamically probe uart pins and enable rx wakeup.
>>=20
>> I can re-work on the patch[2] as per tony's comments[1]
>> and re-post it.
> =20
> Just to follow up on this.. Let's first get things working reliably,
> and only then add more PM support.
>
> We absolutely can't revert $SUBJECT because it's known to mess up
> at least smsc911x and ehci on zoom3, hsi on n900 and probably
> many other things.
>
> For the -rc cycle, it seems that [2] is out of question at this point
> as too intrusive. If the PM & wakeups are broken in the default cases=
,
> then I suggest we just take few steps back and disable any deeper PM
> states in the -rc series.

Unfortunately, no need to do anything more to disable deeper PM states.

Because $SUBJECT disables runtime PM for UART, it keeps both PER and
CORE on all the time. :(

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
