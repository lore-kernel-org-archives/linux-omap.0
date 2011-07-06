From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH] OMAP4: I2C : I2C context save
Date: Wed, 6 Jul 2011 11:49:05 +0530
Message-ID: <1309933145-8825-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50095 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830Ab1GFGTP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jul 2011 02:19:15 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Shubhrajyoti D <shubhrajyoti@ti.com>

Restore of context is not done for OMAP4. This patch 
adds the OMAP_I2C_FLAG_RESET_REGS_POSTIDLE in the OMAP4
hwmod which activates the restore for OMAP4.
Currently the OMAP4 doesnot hit device off still the
driver may have support for it.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
Applies on top of patches from Andy Green
http://www.spinics.net/lists/linux-i2c/msg05632.html
Tested on OMAP4430

 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 0fe9556..5e2c748 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2130,7 +2130,8 @@ static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
 };
 
 static struct omap_i2c_dev_attr i2c_dev_attr = {
-	.flags  = OMAP_I2C_FLAG_BUS_SHIFT_NONE,
+	.flags  = OMAP_I2C_FLAG_BUS_SHIFT_NONE |
+			OMAP_I2C_FLAG_RESET_REGS_POSTIDLE,
 };
 
 /* i2c1 */
-- 
1.7.1

