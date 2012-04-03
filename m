From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv4 15/18] OMAP4: hwmod data: I2C: add flag for context restore
Date: Tue, 3 Apr 2012 17:08:24 +0530
Message-ID: <1333453107-7697-16-git-send-email-shubhrajyoti@ti.com>
References: <1333453107-7697-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35238 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754336Ab2DCLj1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Apr 2012 07:39:27 -0400
In-Reply-To: <1333453107-7697-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Shubhrajyoti D <shubhrajyoti@ti.com>, Benoit Cousson <b-cousson@ti.com>, Paul Wamsley <paul@pwsan.com>

Restore of context is not done for OMAP4. This patch
adds the OMAP_I2C_FLAG_RESET_REGS_POSTIDLE in the OMAP4
hwmod data which activates the restore for OMAP4.
Currently the OMAP4 does not hit device off still the
driver may have support for it.

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Wamsley <paul@pwsan.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 08daa5e..cddce60 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2262,7 +2262,8 @@ static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
 };
 
 static struct omap_i2c_dev_attr i2c_dev_attr = {
-	.flags	= OMAP_I2C_FLAG_BUS_SHIFT_NONE,
+	.flags	= OMAP_I2C_FLAG_BUS_SHIFT_NONE |
+			OMAP_I2C_FLAG_RESET_REGS_POSTIDLE,
 };
 
 /* i2c1 */
-- 
1.7.1

