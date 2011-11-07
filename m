From: David Anders <x0132446@ti.com>
Subject: [PATCH] omap4: i2c: add post idle reset registers flag
Date: Mon, 7 Nov 2011 14:49:49 -0600
Message-ID: <1320698989-13361-1-git-send-email-x0132446@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35922 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752213Ab1KGUuA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Nov 2011 15:50:00 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: danders.dev@gmail.com, linux-omap@vger.kernel.org, tony@atomide.com, aneesh@ti.com, jayabharath@ti.com, andy.green@linaro.org, khilman@ti.com, linux-i2c@vger.kernel.org
Cc: ben-linux@fluff.org, David Anders <x0132446@ti.com>

omap44xx i2c devices need to have the registers reset post idle
similar to omap3xxx devices. this adds the additional flag for
OMAP_I2C_FLAG_RESET_REGS_POSTIDLE to the omap44xx i2c_dev_attr.

Signed-off-by: David Anders <x0132446@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 7695e5d..e93dc40 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2257,7 +2257,8 @@ static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
 };
 
 static struct omap_i2c_dev_attr i2c_dev_attr = {
-	.flags	= OMAP_I2C_FLAG_BUS_SHIFT_NONE,
+	.flags	=  OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
+			OMAP_I2C_FLAG_BUS_SHIFT_NONE,
 };
 
 /* i2c1 */
-- 
1.7.0.4

