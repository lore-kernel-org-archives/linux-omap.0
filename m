From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv10 5/7] I2C: OMAP: Remove the definition of SYSS_RESETDONE_MASK
Date: Mon, 25 Jun 2012 16:41:40 +0530
Message-ID: <1340622702-21622-6-git-send-email-shubhrajyoti@ti.com>
References: <1340622702-21622-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44078 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755891Ab2FYLMj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Jun 2012 07:12:39 -0400
In-Reply-To: <1340622702-21622-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Shubhrajyoti D <shubhrajyoti@ti.com>

Remove the definition of SYSS_RESETDONE_MASK and use the
one in omap_hwmod.h.

Also fixes the warning
 CC      drivers/i2c/busses/i2c-omap.o
drivers/i2c/busses/i2c-omap.c:163: warning: "SYSS_RESETDONE_MASK" redefined

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index f1109f4..8344ad030 100644
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

