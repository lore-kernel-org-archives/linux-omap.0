From: "Koyamangalath, Abhilash" <abhilash.kv@ti.com>
Subject: gpio126: Multiple gpio paths (2) : CAM_STROBE & SDMMC1_DAT4
Date: Mon, 21 Feb 2011 19:28:05 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870370562CF6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43154 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753160Ab1BUN6K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Feb 2011 08:58:10 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1LDw6jK019169
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 07:58:08 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1LDw6kI025725
	for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 19:28:06 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

There is this boot-time message on the am3517evm (and possibly 
other omap 35xx based boards as well)
[    0.000000] _omap_mux_init_gpio: Multiple gpio paths
 (2) for gpio126
I realized that this happens due to dual mappings for gpio_126 in arch/arm/mach-omap2/mux34xx.c:

static struct omap_mux __initdata omap3_muxmodes[] = {
:
_OMAP3_MUXENTRY(CAM_STROBE, 126,
                "cam_strobe", NULL, NULL, NULL,
                "gpio_126", "hw_dbg11", NULL, "safe_mode"),
:
_OMAP3_MUXENTRY(SDMMC1_DAT4, 126,
                "sdmmc1_dat4", NULL, "sim_io", NULL,
                "gpio_126", NULL, NULL, "safe_mode"),
:
#if defined(CONFIG_OMAP_MUX) && defined(CONFIG_OMAP_PACKAGE_CBB) static struct omap_mux __initdata omap3_cbb_subset[] = {
:
       _OMAP3_MUXENTRY(CAM_STROBE, 126,
                "cam_strobe", NULL, NULL, NULL,
                "gpio_126", NULL, NULL, "safe_mode"),

Removing one instance of CAM_STROBE from omap3_muxmodes rids us
of this (pr_info) message and should be fine as this is defined in 
omap3_xxx_subset as well. But I'm concerned if this would break things 
on the other omap3 boards?

For completeness, I've listed my patch (only for the CBB package) below 
(this also modifies the Mode 5 value of CAM_STROBE from NULL to hw_dbg11
in omap3_cbb_subset, which is incorrect right now); please comment:

---
 arch/arm/mach-omap2/mux34xx.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/mux34xx.c b/arch/arm/mach-omap2/mux34xx.c index 440c98e..2517141 100644
--- a/arch/arm/mach-omap2/mux34xx.c
+++ b/arch/arm/mach-omap2/mux34xx.c
@@ -86,9 +86,6 @@ static struct omap_mux __initdata omap3_muxmodes[] = {
 	_OMAP3_MUXENTRY(CAM_PCLK, 97,
 		"cam_pclk", NULL, NULL, NULL,
 		"gpio_97", "hw_dbg2", NULL, "safe_mode"),
-	_OMAP3_MUXENTRY(CAM_STROBE, 126,
-		"cam_strobe", NULL, NULL, NULL,
-		"gpio_126", "hw_dbg11", NULL, "safe_mode"),
 	_OMAP3_MUXENTRY(CAM_VS, 95,
 		"cam_vs", NULL, NULL, NULL,
 		"gpio_95", "hw_dbg1", NULL, "safe_mode"), @@ -1299,7 +1296,7 @@ static struct omap_mux __initdata omap3_cbb_subset[] = {
 		"gpio_97", NULL, NULL, "safe_mode"),
 	_OMAP3_MUXENTRY(CAM_STROBE, 126,
 		"cam_strobe", NULL, NULL, NULL,
-		"gpio_126", NULL, NULL, "safe_mode"),
+		"gpio_126", "hw_dbg11", NULL, "safe_mode"),
 	_OMAP3_MUXENTRY(CAM_VS, 95,
 		"cam_vs", NULL, NULL, NULL,
 		"gpio_95", NULL, NULL, "safe_mode"),
--
1.6.2.4
