From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: dts: Disable smc91x on n900 until bootloader dependency
 is removed
Date: Thu, 9 Oct 2014 10:53:57 -0700
Message-ID: <20141009175357.GG10014@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53429 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbaJIRyd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Oct 2014 13:54:33 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@linaro.org>, linux-arm-kernel@lists.infradead.org

I added smc91x support but turns out we currently do not set the
smc91x timings in gpmc.c but rely on the bootloader timings. This
produces the following error unless the smc91x GPMC timings are
initialized by the bootloader:

Unhandled fault: external abort on non-linefetch (0x1008) at 0xd080630e
...
[<c04067fc>] (smc_drv_probe) from [<c038e9c4>] (platform_drv_probe+0x2c/0x5c)
[<c038e9c4>] (platform_drv_probe) from [<c038d450>] (driver_probe_device+0x104/0x22c)
[<c038d450>] (driver_probe_device) from [<c038d60c>] (__driver_attach+0x94/0x98)
[<c038d60c>] (__driver_attach) from [<c038bc3c>] (bus_for_each_dev+0x54/0x88)
[<c038bc3c>] (bus_for_each_dev) from [<c038cc3c>] (bus_add_driver+0xd8/0x1d8)
[<c038cc3c>] (bus_add_driver) from [<c038dd74>] (driver_register+0x78/0xf4)
[<c038dd74>] (driver_register) from [<c0008924>] (do_one_initcall+0x80/0x1c0)
[<c0008924>] (do_one_initcall) from [<c0852d9c>] (kernel_init_freeable+0x1b8/0x28c)
[<c0852d9c>] (kernel_init_freeable) from [<c05ce86c>] (kernel_init+0x8/0xec)
[<c05ce86c>] (kernel_init) from [<c000e728>] (ret_from_fork+0x14/0x2c)

Let's fix the issue by disabling the smc91x module for now until we
have sorted out the issues in gpmc.c.

Reported-by: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -659,6 +659,9 @@
 
 	ethernet@gpmc {
 		compatible = "smsc,lan91c94";
+
+		status = "disabled";
+
 		interrupt-parent = <&gpio2>;
 		interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;	/* gpio54 */
 		reg = <1 0x300 0xf>;		/* 16 byte IO range at offset 0x300 */
