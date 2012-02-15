From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP34xx
Date: Wed, 15 Feb 2012 11:27:33 +0000
Message-ID: <20120215112733.GA25263@n2100.arm.linux.org.uk>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk> <20120212104132.GA17557@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41084 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754727Ab2BOL1m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Feb 2012 06:27:42 -0500
Content-Disposition: inline
In-Reply-To: <20120212104132.GA17557@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Sun, Feb 12, 2012 at 10:41:32AM +0000, Russell King - ARM Linux wrote:
> Another issue (through lower priority) is this:
> 
> twl-common.c:(.init.text+0x2e48): undefined reference to `omap34xx_vddmpu_volt_data'
> twl-common.c:(.init.text+0x2e4c): undefined reference to `omap34xx_vddcore_volt_data'
> twl-common.c:(.init.text+0x2e5c): undefined reference to `omap36xx_vddmpu_volt_data'
> twl-common.c:(.init.text+0x2e60): undefined reference to `omap36xx_vddcore_volt_data'
> twl-common.c:(.init.text+0x2830): undefined reference to `omap44xx_vdd_mpu_volt_data'
> twl-common.c:(.init.text+0x283c): undefined reference to `omap44xx_vdd_iva_volt_data'
> twl-common.c:(.init.text+0x2844): undefined reference to `omap44xx_vdd_core_volt_data'
> 
> produced by the allnoconfig build.
> 
> The voltage domain code is always built into the kernel, but it references
> the operating point code for the voltage tables.  The voltage tables are
> only built in when PM_OPP is enabled.
> 
> So, this means that either the voltage tables must always be built in, or
> the references need to be surrounded by #ifdef CONFIG_PM_OPP.  The former
> can be done in two ways: either move those tables out of opp*.c, or get
> rid of PM_OPP entirely as it must always be enabled.

Since no one has picked up on this, here's my current patch for it:

diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
index c005e2f..57db203 100644
--- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
@@ -108,6 +108,7 @@ void __init omap3xxx_voltagedomains_init(void)
 	 * XXX Will depend on the process, validation, and binning
 	 * for the currently-running IC
 	 */
+#ifdef CONFIG_PM_OPP
 	if (cpu_is_omap3630()) {
 		omap3_voltdm_mpu.volt_data = omap36xx_vddmpu_volt_data;
 		omap3_voltdm_core.volt_data = omap36xx_vddcore_volt_data;
@@ -115,6 +116,7 @@ void __init omap3xxx_voltagedomains_init(void)
 		omap3_voltdm_mpu.volt_data = omap34xx_vddmpu_volt_data;
 		omap3_voltdm_core.volt_data = omap34xx_vddcore_volt_data;
 	}
+#endif
 
 	if (cpu_is_omap3517() || cpu_is_omap3505())
 		voltdms = voltagedomains_am35xx;
diff --git a/arch/arm/mach-omap2/voltagedomains44xx_data.c b/arch/arm/mach-omap2/voltagedomains44xx_data.c
index 4e11d02..c3115f6 100644
--- a/arch/arm/mach-omap2/voltagedomains44xx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains44xx_data.c
@@ -100,9 +100,11 @@ void __init omap44xx_voltagedomains_init(void)
 	 * XXX Will depend on the process, validation, and binning
 	 * for the currently-running IC
 	 */
+#ifdef CONFIG_PM_OPP
 	omap4_voltdm_mpu.volt_data = omap44xx_vdd_mpu_volt_data;
 	omap4_voltdm_iva.volt_data = omap44xx_vdd_iva_volt_data;
 	omap4_voltdm_core.volt_data = omap44xx_vdd_core_volt_data;
+#endif
 
 	for (i = 0; voltdm = voltagedomains_omap4[i], voltdm; i++)
 		voltdm->sys_clk.name = sys_clk_name;

