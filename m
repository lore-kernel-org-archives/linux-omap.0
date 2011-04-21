From: Jan Weitzel <j.weitzel@phytec.de>
Subject: [PATCH] ARM: omap4: i2c reset regs postidle
Date: Thu, 21 Apr 2011 13:47:00 +0200
Message-ID: <1303386420-12997-1-git-send-email-j.weitzel@phytec.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.phytec.co.uk ([217.6.246.34]:52330 "EHLO root.phytec.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493Ab1DULrM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Apr 2011 07:47:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, andy.green@linaro.org, patches@linaro.org
Cc: andy@warmcat.com, tony@atomide.com, peter.maydell@linaro.org, ben-linux@fluff.org, Jan Weitzel <j.weitzel@phytec.de>

Without OMAP_I2C_FLAG_RESET_REGS_POSTIDLE I got i2c controller
timeouts on each accsess after an NACK message.
Taking this flag fix it.

This patch is on top of the i2c feature implementation flags
patches

Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>
---
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

