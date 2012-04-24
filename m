From: Kevin Hilman <khilman@ti.com>
Subject: Re: OMAP3EVM not booting on l-o master
Date: Tue, 24 Apr 2012 10:07:51 -0700
Message-ID: <87obqhawig.fsf@ti.com>
References: <C8443D0743D26F4388EA172BF4E2A7A9317C3A03@DBDE01.ent.ti.com>
	<C8443D0743D26F4388EA172BF4E2A7A9317C3B18@DBDE01.ent.ti.com>
	<alpine.DEB.2.00.1204050330380.10302@utopia.booyaka.com>
	<alpine.DEB.2.00.1204050403460.10302@utopia.booyaka.com>
	<C8443D0743D26F4388EA172BF4E2A7A9317C4B44@DBDE01.ent.ti.com>
	<alpine.DEB.2.00.1204051303000.10302@utopia.booyaka.com>
	<C8443D0743D26F4388EA172BF4E2A7A9317C5DB6@DBDE01.ent.ti.com>
	<alpine.DEB.2.00.1204060111400.10302@utopia.booyaka.com>
	<C8443D0743D26F4388EA172BF4E2A7A9317C5EEF@DBDE01.ent.ti.com>
	<1335173044.2149.64.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:59374 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755481Ab2DXRHo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Apr 2012 13:07:44 -0400
Received: by pbbrq13 with SMTP id rq13so346941pbb.8
        for <linux-omap@vger.kernel.org>; Tue, 24 Apr 2012 10:07:43 -0700 (PDT)
In-Reply-To: <1335173044.2149.64.camel@sokoban> (Tero Kristo's message of
	"Mon, 23 Apr 2012 12:24:04 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: "Mohammed, Afzal" <afzal@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tero,

Tero Kristo <t-kristo@ti.com> writes:

> On Fri, 2012-04-06 at 07:52 +0000, Mohammed, Afzal wrote:
>> Hi Paul,
>> 
>> On Fri, Apr 06, 2012 at 12:43:06, Paul Walmsley wrote:
>> > Perhaps you might be willing to add some debugging to omap_mux_late_init() 
>> > to find out what part of that function is causing it to hang?
>> 
>> It is getting hung as interrupt handler "omap_hwmod_mux_handle_irq"
>> is being repeatedly called.
>> 
>
> Hi Afzal,
>
> can you try the attached patch with this branch and omap3evm board? I
> don't have the board myself so I can't test it myself (I tested this
> with omap3beagle and it works with that one.)

Thanks for digging into this problem and coming up with a proposed
solution.  Some questions below...

>
> -Tero
>
>
> From 26733dd988ccc9e72355a39e01b2d6e9215a892d Mon Sep 17 00:00:00 2001
> From: Tero Kristo <t-kristo@ti.com>
> Date: Mon, 23 Apr 2012 12:14:46 +0300
> Subject: [PATCH] ARM: OMAP3: PM: move wakeup event ack to hwmod_io handler
>
> PRCM IO interrupts are handled with a shared interrupt handler logic.
> Currently hwmod_io is processing the actual event, but the acking
> of the IO wakeups is done from the PM code with a separate handler.
> If a wakeup event is detected during init before the PM code is in
> place, the interrupt handler can hang in an infinite loop. Fix this
> by removing the pm_io handler, and calling its functionality from
> within the hwmod_io handler. This fix applies only to OMAP3, as
> OMAP4 does not have similar wakeup handling logic.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>


Doesn't this mean that even on a !PM kernel that IO events might still
be firing for nothing?

Seems like it would be better to ensure that these interrupts are just
disabled until the PM core initializes and can enable them.

Kevin
