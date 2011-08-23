From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 6/9] OMAP4: HWMOD: Add HWMOD_CONTROL_OPT_CLKS_IN_RESET for dss_core
Date: Tue, 23 Aug 2011 15:28:16 +0300
Message-ID: <1314102499-30407-7-git-send-email-tomi.valkeinen@ti.com>
References: <1314102499-30407-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:33604 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754193Ab1HWM2s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 08:28:48 -0400
Received: by mail-bw0-f52.google.com with SMTP id zs2so41928bkb.25
        for <linux-omap@vger.kernel.org>; Tue, 23 Aug 2011 05:28:47 -0700 (PDT)
In-Reply-To: <1314102499-30407-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

DSS needs all DSS clocks to be enabled to be able to finish reset
properly. Before v3.1-rc1 the omapdss driver was managing clocks and
resets correctly. However, when omapdss started using runtime PM at
v3.1-rc1, the responsibility for the reset moved to HWMOD framework.

HWMOD framework does not currently enable all the DSS clocks when
resetting the DSS hardware. This causes the HWMOD frameworks boot-time
reset to fail, possibly leaving the DSS hardware in undefined state.

This patch sets HWMOD_CONTROL_OPT_CLKS_IN_RESET for dss_core. The flag
is actually not used on OMAP4, because dss_core hardware does not have
soft-reset functionality and thus the HWMOD framework never resets nor
waits for the reset to finish.

However, while the flag is not strictly needed currently, I think it
represents the HW correctly: all the DSS clocks should be enabled after
power-on to allow DSS hardware to finish its reset.

A custom reset function will be added in the following patches which
manages this correctly for OMAP4.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 48c0458..4c2ac7e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1262,6 +1262,7 @@ static struct omap_hwmod_opt_clk dss_opt_clks[] = {
 
 static struct omap_hwmod omap44xx_dss_hwmod = {
 	.name		= "dss_core",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.class		= &omap44xx_dss_hwmod_class,
 	.clkdm_name	= "l3_dss_clkdm",
 	.main_clk	= "dss_dss_clk",
-- 
1.7.4.1

