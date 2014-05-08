From: Kevin Hilman <khilman@linaro.org>
Subject: Re: omap4-panda-es boot issues with v3.15-rc4
Date: Thu, 08 May 2014 08:31:41 -0700
Message-ID: <7hppjos2w2.fsf@paris.lan>
References: <536B7E44.2040303@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:48805 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127AbaEHPbo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2014 11:31:44 -0400
Received: by mail-pa0-f42.google.com with SMTP id rd3so3027307pab.1
        for <linux-omap@vger.kernel.org>; Thu, 08 May 2014 08:31:44 -0700 (PDT)
In-Reply-To: <536B7E44.2040303@ti.com> (Roger Quadros's message of "Thu, 8 May
	2014 15:53:24 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "Menon, Nishanth" <nm@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>, taras.kondratiuk@linaro.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, "Kristo, Tero" <t-kristo@ti.com>

Roger Quadros <rogerq@ti.com> writes:

> Hi,
>
> Nishant pointed me to a booting issue with omap4-panda-es on linux-next but I'm observing
> similar issues, although less frequent, with v3.15-rc4 as well.
>
> Configuration:
>
> - kernel v3.15-rc4 or linux-next (20140507)
> - multi_v7_defconfig with LEDS_TRIGGER_HEARTBEAT and LEDS_GPIO enabled
> - u-boot/master	173d294b94cf
>
> Observations:
>
> - Out of 10 boots a few may not succeed and hang midway without any warnings. Heartbeat LED stops.
> e.g. http://www.hastebin.com/ebumojegoq.vhdl
>
> - Hang more noticeable on linux-next (20140507) than on v3.15-rc4

I've beeen noticing the same thing for awhile with my boot tests.  For
me, next-20140508 is failing most of the time now.

> - Hang more noticeable with USB_EHCI_HCD enabled but hang observed even without USB_EHCI_HCD.
> Maybe related to when high speed interrupts occur in the boot process.
>
> - On successful boots following warning is seen
> [    4.010375] gic_timer_retrigger: lost localtimer interrupt
>
> - On successful boots heartbeat LED stops blinking after boot process and left idle. LED can remain stuck in
> ON state as well. It does blink again when doing activity on console.
>
> Workaround:
>
> - Disabling CPU_IDLE or even just disabling C3 (MPU OSWR) seems to fix all the above issues.
>
> I don't really know what exactly is the issue but it seems to be specific to OMAP4, GIC, MPU OSWR.

I can confirm that disabling CONFIG_CPU_IDLE seems to make the problem
go away.  Hmm....

Kevin


