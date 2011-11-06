From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH v2 3/4] ARM: OMAP3: cm-t35: fix audio
Date: Sun,  6 Nov 2011 16:16:25 +0200
Message-ID: <1320588986-9480-3-git-send-email-grinberg@compulab.co.il>
References: <1320588827-9407-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:47335
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752619Ab1KFOQm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Nov 2011 09:16:42 -0500
In-Reply-To: <1320588827-9407-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

TWL4030 audio codec is not being registered if no platform data is
supplied. Provide platform data for the TWL4030 audio codec.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
v2: - Rebase on top of fixes branch
    - fix the commit message (10x to Sergei)

 arch/arm/mach-omap2/board-cm-t35.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 724a23c..7b71fe1 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -477,7 +477,8 @@ static struct twl4030_platform_data cm_t35_twldata = {
 static void __init cm_t35_init_i2c(void)
 {
 	omap3_pmic_get_config(&cm_t35_twldata, TWL_COMMON_PDATA_USB,
-			TWL_COMMON_REGULATOR_VDAC);
+			      TWL_COMMON_REGULATOR_VDAC |
+			      TWL_COMMON_PDATA_AUDIO);
 
 	omap3_pmic_init("tps65930", &cm_t35_twldata);
 }
-- 
1.7.3.4

