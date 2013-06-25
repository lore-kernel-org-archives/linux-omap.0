From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] ARM: OMAP5: voltagedomain data: remove temporary OMAP4 voltage data
Date: Tue, 25 Jun 2013 18:56:00 -0500
Message-ID: <1372204560-1304-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44426 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752148Ab3FYX4J (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Jun 2013 19:56:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul@pwsan.com>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

commit 20d49e9ccfece526db755940721aa13e331936d4
(ARM: OMAP5: voltagedomain data: Add OMAP5 voltage domain data)

Introduced dummy volt data for OMAP5 with OMAP4460 voltage information.

However with the fixes introduced in later patches

commit cd8abed1da91a3250aa4b3857479613a2b446f84
(ARM: OMAP2+: Powerdomain: Remove the need to always have a voltdm
 associated to a pwrdm)

We are no longer restricted in that respect. Further, OPP voltage
information is supposed to be provided by dts information. This needs
to be added in future patches as various voltage modules are converted
to dts.

This also fixes the build breakage for voltagedomains54xx_data.c when just
OMAP5 SoC is enabled: https://patchwork.kernel.org/patch/2764191/

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
---

Discussed in thread: http://marc.info/?t=137184664400002&r=1&w=2

Tested against 
linux-next-20130625 + git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux.git
for_3.11/out_of_tree/omap5_clk_data with omap2plus_defconfig
on OMAP5432 uEVM.
NOTE: we still have the issue reported in https://patchwork.kernel.org/patch/2568091/
and "ARM: OMAP2+: AM43x: resolve SMP related build error" does not help solve
the problem either for OMAP5.

 arch/arm/mach-omap2/voltagedomains54xx_data.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/mach-omap2/voltagedomains54xx_data.c b/arch/arm/mach-omap2/voltagedomains54xx_data.c
index 72b8971..33d22b8 100644
--- a/arch/arm/mach-omap2/voltagedomains54xx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains54xx_data.c
@@ -85,16 +85,6 @@ void __init omap54xx_voltagedomains_init(void)
 	struct voltagedomain *voltdm;
 	int i;
 
-	/*
-	 * XXX Will depend on the process, validation, and binning
-	 * for the currently-running IC. Use OMAP4 data for time being.
-	 */
-#ifdef CONFIG_PM_OPP
-	omap5_voltdm_mpu.volt_data = omap446x_vdd_mpu_volt_data;
-	omap5_voltdm_mm.volt_data = omap446x_vdd_iva_volt_data;
-	omap5_voltdm_core.volt_data = omap446x_vdd_core_volt_data;
-#endif
-
 	for (i = 0; voltdm = voltagedomains_omap5[i], voltdm; i++)
 		voltdm->sys_clk.name = sys_clk_name;
 
-- 
1.7.9.5

