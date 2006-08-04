From: Jonathan McDowell <noodles@earth.li>
Subject: [PATCH] ARM: OMAP: Add some extra #defines for Amstrad Delta.
Date: Fri, 4 Aug 2006 23:55:56 +0100
Message-ID: <20060804225555.GT17406@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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

This patch adds some further #defines regarding GPIOs and latch bits for
the Amstrad Delta; the drivers that use them will be submitted at a
later date but there's no reason not to have the information already
there and available for use.

Signed-Off-By: Jonathan McDowell <noodles@earth.li>

-----
diff -ruNp linux-2.6.17-e3-02/include/asm-arm/arch-omap/board-ams-delta.h linux-2.6.17-e3-03/include/asm-arm/arch-omap/board-ams-delta.h
--- linux-2.6.17-e3-02/include/asm-arm/arch-omap/board-ams-delta.h	2006-06-18 02:49:35.000000000 +0100
+++ linux-2.6.17-e3-03/include/asm-arm/arch-omap/board-ams-delta.h	2006-07-08 12:35:03.850233000 +0100
@@ -50,9 +50,20 @@
 #define AMS_DELTA_LATCH2_NAND_NWE	0x0020
 #define AMS_DELTA_LATCH2_NAND_ALE	0x0040
 #define AMS_DELTA_LATCH2_NAND_CLE	0x0080
+#define AMD_DELTA_LATCH2_KEYBRD_PWR	0x0100
+#define AMD_DELTA_LATCH2_KEYBRD_DATA	0x0200
+#define AMD_DELTA_LATCH2_SCARD_RSTIN	0x0400
+#define AMD_DELTA_LATCH2_SCARD_CMDVCC	0x0800
 #define AMS_DELTA_LATCH2_MODEM_NRESET	0x1000
 #define AMS_DELTA_LATCH2_MODEM_CODEC	0x2000
 
+#define AMS_DELTA_GPIO_PIN_KEYBRD_DATA	0
+#define AMS_DELTA_GPIO_PIN_KEYBRD_CLK	1
+#define AMS_DELTA_GPIO_PIN_MODEM_IRQ	2
+#define AMS_DELTA_GPIO_PIN_HOOK_SWITCH	4
+#define AMS_DELTA_GPIO_PIN_SCARD_NOFF	6
+#define AMS_DELTA_GPIO_PIN_SCARD_IO	7
+#define AMS_DELTA_GPIO_PIN_CONFIG	11
 #define AMS_DELTA_GPIO_PIN_NAND_RB	12
 
 #ifndef __ASSEMBLY__
-----

J.

-- 
Just 'cause I remembered one thing doesn't make me smart!
