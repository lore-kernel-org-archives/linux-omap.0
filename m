From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv9 6/8] I2C: OMAP: Remove the definition of SYSS_RESETDONE_MASK
Date: Thu, 21 Jun 2012 15:38:47 +0530
Message-ID: <1340273329-8319-7-git-send-email-shubhrajyoti@ti.com>
References: <1340273329-8319-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340273329-8319-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Remove the definition of SYSS_RESETDONE_MASK and use the
one in omap_hwmod.h.

Also fixes the warning
 CC      drivers/i2c/busses/i2c-omap.o
drivers/i2c/busses/i2c-omap.c:163: warning: "SYSS_RESETDONE_MASK" redefined

Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 2a50094..cbf7ecd 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -159,9 +159,6 @@ enum {
 #define OMAP_I2C_SYSTEST_SDA_O		(1 << 0)	/* SDA line drive out */
 #endif
 
-/* OCP_SYSSTATUS bit definitions */
-#define SYSS_RESETDONE_MASK		(1 << 0)
-
 /* OCP_SYSCONFIG bit definitions */
 #define SYSC_CLOCKACTIVITY_MASK		(0x3 << 8)
 #define SYSC_SIDLEMODE_MASK		(0x3 << 3)
-- 
1.7.5.4
