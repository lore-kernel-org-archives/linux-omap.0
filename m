From: Felipe Balbi <felipe.lima@indt.org.br>
Subject: [RFC patch] I2C: TWL4030: Remove unneded pr_err define
Date: Mon, 19 Nov 2007 03:45:28 +0200
Message-ID: <1195436730-10631-2-git-send-email-felipe.lima@indt.org.br>
References: <1195436730-10631-1-git-send-email-felipe.lima@indt.org.br>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1195436730-10631-1-git-send-email-felipe.lima@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
Cc: david-b@pacbel.net
List-Id: linux-omap@vger.kernel.org

pr_err definition was moved to include/linux/kernel.h
it's unecessary keeping that in twl4030_core.c

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
---
 drivers/i2c/chips/twl4030_core.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/chips/twl4030_core.c b/drivers/i2c/chips/twl4030_core.c
index 991ebf4..5b77d99 100644
--- a/drivers/i2c/chips/twl4030_core.c
+++ b/drivers/i2c/chips/twl4030_core.c
@@ -51,8 +51,6 @@
 
 #define DRIVER_NAME			"twl4030"
 
-#define pr_err(fmt, arg...)	printk(KERN_ERR DRIVER_NAME ": " fmt, ##arg);
-
 /**** Macro Definitions */
 #define TWL_CLIENT_STRING		"TWL4030-ID"
 #define TWL_CLIENT_USED			1
-- 
1.5.3.5.666.gfb5f
