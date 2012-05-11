From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP3EVM not booting on l-o master
Date: Fri, 11 May 2012 16:39:17 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205111638140.3201@utopia.booyaka.com>
References: <C8443D0743D26F4388EA172BF4E2A7A9317C3A03@DBDE01.ent.ti.com> <C8443D0743D26F4388EA172BF4E2A7A9317C3B18@DBDE01.ent.ti.com> <alpine.DEB.2.00.1204050330380.10302@utopia.booyaka.com> <alpine.DEB.2.00.1204050403460.10302@utopia.booyaka.com>
 <C8443D0743D26F4388EA172BF4E2A7A9317C4B44@DBDE01.ent.ti.com> <alpine.DEB.2.00.1204051303000.10302@utopia.booyaka.com> <C8443D0743D26F4388EA172BF4E2A7A9317C5DB6@DBDE01.ent.ti.com> <alpine.DEB.2.00.1204060111400.10302@utopia.booyaka.com>
 <C8443D0743D26F4388EA172BF4E2A7A9317C5EEF@DBDE01.ent.ti.com> <1335173044.2149.64.camel@sokoban> <87obqhawig.fsf@ti.com> <1335532591.2149.163.camel@sokoban> <87fwbowyuu.fsf@ti.com> <1335790016.2149.185.camel@sokoban> <87vckht0lf.fsf@ti.com>
 <alpine.DEB.2.00.1205020242420.19695@utopia.booyaka.com> <87aa1qhd49.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43849 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308Ab2EKWjS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 May 2012 18:39:18 -0400
In-Reply-To: <87aa1qhd49.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "linux-omap\\@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Kevin,

On Wed, 2 May 2012, Kevin Hilman wrote:

> >From 22726db6fc514cc5110db43fdf05d5afda8e4a59 Mon Sep 17 00:00:00 2001
> From: Kevin Hilman <khilman@ti.com>
> Date: Tue, 1 May 2012 07:06:42 -0700
> Subject: [PATCH] ARM: OMAP3: PM: leave PRCM interrupts disabled until
>  explicitly enabled.
> 
> By default, request_irq() will auto-enable the requested IRQ.
> 
> For PRCM interrupts, we may want to avoid that until the PM core code
> is fully ready to handle the interrupts.  This is particularily true
> for IO pad interrupts on OMAP3, which are shared between the hwmod
> core and the PRM core.
> 
> In order to avoid PRCM IO-chain interrupts until the PM core is ready
> to handle them, ready, set the IRQ_NOAUTOEN flag for the PRCM IO-chain
> interrupt,  which means it will remain disabled after request_irq().
> 
> Then, explicitly enable the PRCM interrupts after the request_irq() in
> the PM core (but not in the hwmod core.)
> 
> Special thanks to Tero Kristo for suggesting to isolate the fix to
> only the IO-chain interrupt on OMAP3 instead of all PRCM interrupts.
> 
> Tested-by: Afzal Mohammed <afzal@ti.com>
> Acked-by: Tero Kristo <t-kristo@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>

Acked-by: Paul Walmsley <paul@pwsan.com>

If for some reason it doesn't get in for 3.5, let me know and I'll queue 
with the other IO chain patches for 3.6 as we discussed.

- Paul
