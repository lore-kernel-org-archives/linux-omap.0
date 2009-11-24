From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: hwmod and PER going idle before WFI
Date: Tue, 24 Nov 2009 11:03:23 -0800
Message-ID: <87fx83vj7o.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:19685 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933903AbZKXTDX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2009 14:03:23 -0500
Received: by ey-out-2122.google.com with SMTP id 4so1337313eyf.19
        for <linux-omap@vger.kernel.org>; Tue, 24 Nov 2009 11:03:29 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Hi Paul,

In working with the UART conversion to hwmod, I noticed something I
don't see when not using hwmod for managing the UARTs.

Namely, in the idle path for PER we do disable the PER UART (via
omap_uart_prepare_for_idle(2)) and then the GPIO context is saved via
omap3_per_save_context();

When switching to use omap_hwmod, I noticed via crashes and then via
lauterbach that as soon as UART3 clocks are disabled, PER goes idle.
This causes the subsequent GPIO context save to fault since PER has
gone idle.

I seem to remember having a similar problem before when the problem
was in the management of autodeps cause by a mis-merge.

The patch below is a hack/workaround that just moves the UART idle after
the GPIO context save because I haven't found the root cause yet.  

Any ideas what might be happening here?

Kevin


commit 5f3cbd67a54ae8b8cecbbd9ec3f55ffe07625e88
Author: Kevin Hilman <khilman@deeprootsystems.com>
Date:   Mon Nov 23 11:05:02 2009 -0800

    temp: OMAP3: PM: GPIO: disable PER UART after GPIO save
    
    FIXME: GPIO core needs to use clock API to prevent this.
    
    When PER UARTs are disabled in idle path and no GPIOs are in use,
    the PER block may go idle.  This causes the GPIO context save
    that happens right after UART disabling to fail with data aborts
    when accessing the GPIO regs in PER.

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 627a509..da32764 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -398,7 +398,6 @@ void omap_sram_idle(void)
 	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
 	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
 	if (per_next_state < PWRDM_POWER_ON) {
-		omap_uart_prepare_idle(2);
 		omap2_gpio_prepare_for_idle(per_next_state);
 		if (per_next_state == PWRDM_POWER_OFF) {
 			if (core_next_state == PWRDM_POWER_ON) {
@@ -408,6 +407,7 @@ void omap_sram_idle(void)
 			} else
 				omap3_per_save_context();
 		}
+		omap_uart_prepare_idle(2);
 	}
 
 	if (pwrdm_read_pwrst(cam_pwrdm) == PWRDM_POWER_ON)
