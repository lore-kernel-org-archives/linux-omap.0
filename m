From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH 3/4] ARM: OMAP3: cm-t35: fix audio
Date: Wed, 19 Oct 2011 11:39:19 +0200
Message-ID: <1319017160-20391-4-git-send-email-grinberg@compulab.co.il>
References: <1319017160-20391-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:49177
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755030Ab1JSJjl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Oct 2011 05:39:41 -0400
In-Reply-To: <1319017160-20391-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

TWL4030 audio codec is not being registered if no platform data is
supplied. Plovide platform data for the TWL4030 audio codec.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap2/board-cm-t35.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 1ee056f5..18cd50c 100644
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

