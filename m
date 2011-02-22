From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: Linux-next as of 20110222 broken on OMAP4
Date: Tue, 22 Feb 2011 13:51:44 +0100
Message-ID: <4D63B160.3010103@ti.com>
References: <b858222d69a83460e469b80ee13cfbe8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57863 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751921Ab1BVMvq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Feb 2011 07:51:46 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1MCpkj0029786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 22 Feb 2011 06:51:46 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id p1MCpkRA021217
	for <linux-omap@vger.kernel.org>; Tue, 22 Feb 2011 06:51:46 -0600 (CST)
In-Reply-To: <b858222d69a83460e469b80ee13cfbe8@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Hi Anand,

On 2/22/2011 10:49 AM, Gadiyar, Anand wrote:
> Looks like linux-next as of today is broken on at least OMAP4.
> 
> Turning on earlyprintk, I get a crash in omap_init_mcspi. Disabling
> CONFIG_SPI_OMAP24XX gets me as far as the following lines from my
> bootup log, but I haven't attempted to debug further.
> 
> If there are any patches out there to fix this, let me know.
> Else I will debug this sometime tomorrow.

Yes, it was discussed with Tony and temporarily fixed yesterday.

The SPI fix is is already in omap-for-linus, and the timer1 temp fix is below.
We need to find a better way to handle timer now that they are initialized pretty soon.

Regards,
Benoit

---
>From 9a8dc4fdab03d00d556d05ad8b64c547493ad84d Mon Sep 17 00:00:00 2001
From: Benoit Cousson <b-cousson@ti.com>
Date: Tue, 22 Feb 2011 10:36:27 +0100
Subject: [PATCH] OMAP4: hwmod data: Prevent timer1 to be reset and idle during init

Since the timer1 is now started before the hwmod_init, we cannot
reset it and idle it anymore.

Add the appropriate flags to prevent the hwmod framework to do that.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 182aa79..79a8601 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -3989,6 +3989,7 @@ static struct omap_hwmod_ocp_if *omap44xx_timer1_slaves[] = {
 static struct omap_hwmod omap44xx_timer1_hwmod = {
 	.name		= "timer1",
 	.class		= &omap44xx_timer_1ms_hwmod_class,
+	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_timer1_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_timer1_irqs),
 	.main_clk	= "timer1_fck",
-- 
1.7.0.4

> 
> - Anand
> 
> 
> [    0.622802] print_constraints: dummy:
> [    0.627655] NET: Registered protocol family 16
> [    0.632537] GPMC revision 6.0
> [    0.635681] Trying to install interrupt handler for IRQ402
> [    0.641418] Trying to install interrupt handler for IRQ403
> [    0.647125] Trying to install interrupt handler for IRQ404
> [    0.652862] Trying to install interrupt handler for IRQ405
> [    0.658599] Trying to install interrupt handler for IRQ406
> [    0.664306] Trying to install interrupt handler for IRQ407
> [    0.670043] Trying to install interrupt handler for IRQ408
> [    0.675781] Trying to install type control for IRQ409
> [    0.681060] Trying to set irq flags for IRQ409
> [    0.685699] gpmc: irq-20 could not claim: err -22
> [    0.695556] omap_device: omap_gpio.0: new worst case activate latency
> 0: 91552
> [    0.703552] OMAP GPIO hardware version 0.1
> [    0.708221] OMAP GPIO hardware version 0.1
> [    0.712890] OMAP GPIO hardware version 0.1
> [    0.717498] OMAP GPIO hardware version 0.1
> [    0.722137] OMAP GPIO hardware version 0.1
> [    0.726776] OMAP GPIO hardware version 0.1[    0.738403] omap_mux_init:
> Add partition: #1: core, flags: 2
> [    0.746276] omap_mux_init: Add partition: #2: wkup, flags: 2
> [    0.752349] error setting wl12xx data
> [    0.759674] omap_device: omap_uart.0: new worst case deactivate latency
> 0: 30517
> [    0.769805] Failed omap4_twl6030_hsmmc_set_late_init
> [    0.777587] hw-breakpoint: found 6 breakpoint and 1 watchpoint
> registers.
> [    0.784667] hw-breakpoint: 1 breakpoint(s) reserved for watchpoint
> single-step.
> [    0.792266] hw-breakpoint: maximum watchpoint size is 4 bytes.
> [    0.803466] pm_dbg_init: only OMAP3 supported
> [    0.808441] OMAP DMA hardware revision 0.0
> [    0.849426] bio: create slab<bio-0>  at 0
> [    0.856201] print_constraints: vwl1271: 1800 mV
> [    0.864959] SCSI subsystem initialized
> [    0.870605] usbcore: registered new interface driver usbfs
> [    0.876739] usbcore: registered new interface driver hub
> [    0.882751] usbcore: registered new device driver usb
> [    0.889221] omap_device: omap_i2c.1: new worst case activate latency 0:
> 30517
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

