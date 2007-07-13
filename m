From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: [PATCH] ARM: OMAP2: Add camera block base address definition.
Date: Fri, 13 Jul 2007 11:35:51 +0300
Message-ID: <11843157513870-git-send-email-sakari.ailus@nokia.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
---
 include/asm-arm/arch-omap/omap24xx.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/asm-arm/arch-omap/omap24xx.h b/include/asm-arm/arch-omap/omap24xx.h
index 675b78f..e552ce8 100644
--- a/include/asm-arm/arch-omap/omap24xx.h
+++ b/include/asm-arm/arch-omap/omap24xx.h
@@ -77,6 +77,9 @@
 /* Mailbox */
 #define OMAP24XX_MAILBOX_BASE	(L4_24XX_BASE + 0x94000)
 
+/* Camera */
+#define OMAP24XX_CAMERA_BASE	(L4_24XX_BASE + 0x52000)
+
 #if defined(CONFIG_ARCH_OMAP2420)
 
 #define OMAP2_32KSYNCT_BASE	OMAP2420_32KSYNCT_BASE
-- 
1.5.0.6
