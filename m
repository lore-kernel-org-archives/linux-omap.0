From: Jan Weitzel <j.weitzel@phytec.de>
Subject: [PATCH v3] ARM: omap4: i2c reset regs postidle
Date: Tue, 17 May 2011 11:26:21 +0200
Message-ID: <1305624381-22524-1-git-send-email-j.weitzel@phytec.de>
References: <4DD15BD5.9010303@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.x-arc.de ([217.6.246.34]:52862 "EHLO root.phytec.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753419Ab1EQJ01 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 May 2011 05:26:27 -0400
In-Reply-To: <4DD15BD5.9010303@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, b-cousson@ti.com, andy.green@linaro.org, patches@linaro.org
Cc: andy@warmcat.com, tony@atomide.com, peter.maydell@linaro.org, ben-linux@fluff.org, Jan Weitzel <j.weitzel@phytec.de>

omap4430 get i2c timeouts at each access after an NACK message.
OMAP_I2C_FLAG_RESET_REGS_POSTIDLE fix it.

Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>
Tested-by: Andy Green <andy.green@linaro.org>
Acked-by: Andy Green <andy.green@linaro.org>
---
Works on top of tmlind linux-omap-2.6.git
v3: commit message
v2: add Tested-by / Acked-by

 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 5f4a1b2..3d3b4f4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2130,7 +2130,8 @@ static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
 };
 
 static struct omap_i2c_dev_attr i2c_dev_attr = {
-	.flags  = OMAP_I2C_FLAG_BUS_SHIFT_NONE,
+	.flags  = OMAP_I2C_FLAG_BUS_SHIFT_NONE |
+		  OMAP_I2C_FLAG_RESET_REGS_POSTIDLE,
 };
 
 /* i2c1 */
-- 
1.7.0.4

