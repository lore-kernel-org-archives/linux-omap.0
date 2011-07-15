From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4] OMAP4: hwmod data: I2C: add flag for context restore
Date: Fri, 15 Jul 2011 11:31:54 +0530
Message-ID: <1310709714-3295-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Restore of context is not done for OMAP4. This patch 
adds the OMAP_I2C_FLAG_RESET_REGS_POSTIDLE in the OMAP4
hwmod data which activates the restore for OMAP4.
Currently the OMAP4 does not hit device off still the
driver may have support for it.

Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
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
