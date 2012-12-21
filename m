From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: reset handling in am335x hwmod data
Date: Fri, 21 Dec 2012 16:32:48 +0100
Message-ID: <87ehij8lpb.fsf@dell.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:60118 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432Ab2LUPjI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Dec 2012 10:39:08 -0500
Received: by mail-wi0-f179.google.com with SMTP id o1so2833695wic.12
        for <linux-omap@vger.kernel.org>; Fri, 21 Dec 2012 07:39:07 -0800 (PST)
Received: from peko by dell.be.48ers.dk with local (Exim 4.80)
	(envelope-from <jacmet@sunsite.dk>)
	id 1Tm4ae-0000VK-BJ
	for linux-omap@vger.kernel.org; Fri, 21 Dec 2012 16:32:48 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

On a custom am335x board I was surprised to see the kernel resetting
gpio pins not mentioned anywhere in the dts.

In this specific case the pin is connected to nCONFIG of a FPGA. The
FPGA is commanded to start configuration from a SPI flash in the
bootloader, so it can happen in parallel with kernel
load/uncompress/startup, but as the kernel resets the gpio during
initialization this doesn't work.

Digging a bit into it, I see the hwmod of the gpio controller is
configured to reset at startup, and it works correctly (E.G. the pin is
left asserted) if I change it to HWMOD_INIT_NO_RESET:

--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -992,7 +992,7 @@ static struct omap_hwmod am33xx_gpio1_hwmod = {
        .name           = "gpio2",
        .class          = &am33xx_gpio_hwmod_class,
        .clkdm_name     = "l4ls_clkdm",
-       .flags          = HWMOD_CONTROL_OPT_CLKS_IN_RESET,
+       .flags          = (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
        .mpu_irqs       = am33xx_gpio1_irqs,
        .main_clk       = "l4ls_gclk",
        .prcm           = {

Now the question is why is this configured like this? I don't have any
experience with omap hwmod, but on other (non-TI) boards I haven't
experienced similar issues. Should E.G. the gpio controllers be changed
to not reset or should it be configurable in the dts?

-- 
Bye, Peter Korsgaard
