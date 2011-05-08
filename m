From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: !CONFIG_OMAP_32K_TIMER on OMAP4/panda
Date: Sun, 8 May 2011 10:29:37 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B0374D103A2@dbde02.ent.ti.com>
References: <BANLkTi=YdcHp4mxcZ1MtG8m5st4zeSY=gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42183 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843Ab1EHFAh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 May 2011 01:00:37 -0400
In-Reply-To: <BANLkTi=YdcHp4mxcZ1MtG8m5st4zeSY=gg@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rabin Vincent <rabin@rab.in>, linux-omap <linux-omap@vger.kernel.org>

Hello,

linux-omap-owner@vger.kernel.org wrote on Saturday, May 07, 2011 10:21 PM:

> On a linux-next kernel built for the Pandaboard, disabling
> CONFIG_OMAP_32K_TIMER makes the kernel use the gptimer as the
> clocksource, but this appears to be non-functional.  Judging from the
> all-zeros printk timings and the fact the "sleep 1" hangs indefinitely,
> it looks like the clocksource reads are always zero.
> 
> Boot log below and .config attached.  Ideas?
> 
> [    0.000000] Linux version 2.6.39-rc6-next-20110506+ (rabin@debian)
[...]
> [    0.000000] Freeing init memory: 112K

This looks similar to the issue I observed on TI816X with 32K timer disabled.

I have created following patch (currently a tempfix) for making timekeeping work 
with MPU timer selected (other option is to use ".flags = HWMOD_INIT_NO_RESET" 
in hwmod data for the timer used as clocksource):

commit 77cce922c00ced4407776cc0a1d84cee40b7da90
Author: Hemant Pedanekar <hemantp@ti.com>
Date:   Thu Apr 28 12:59:24 2011 +0530

    dmtimer: Initialize the hwmod for timer used as clocksource
    
    Since dmtimer driver still doesn't use hwmods, the 2nd timer used as clocksource
    is not set up. This results into timekeepoing failure when the timer used as
    clocksource gets reset during hwmod setup.
    
    To prevent this, explicitly call omap_hwmod_setup_one() for timer used as
    clocksource.
    
    Note that is is aplpicable when NOT using 32k timer which is the case for
    TI816X. For other configurations, this code will not be executed unless 32K
    timer is explicitly disabled.
    
    Signed-off-by: Hemant Pedanekar <hemantp@ti.com>

diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 3b9cf85..290fbfa 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -229,6 +229,11 @@ static void __init omap2_gp_clocksource_init(void)
 		"%s: failed to request dm-timer\n";
 	static char err2[] __initdata = KERN_ERR
 		"%s: can't register clocksource!\n";
+	char clocksource_hwmod_name[8]; /* 8 = sizeof("timerXX0") */
+
+	/* XXX: This may not be always true, we might get different timer */
+	sprintf(clocksource_hwmod_name, "timer%d", gptimer_id + 1);
+	omap_hwmod_setup_one(clocksource_hwmod_name);
 
 	gpt = omap_dm_timer_request();
 	if (!gpt)

   Hemant