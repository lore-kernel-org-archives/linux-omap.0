From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Set default OMAP2_CTRL_BASE for OMAP1
Date: Tue, 18 Sep 2007 19:32:36 +0200
Message-ID: <46F00BB4.40403@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090804010802070400070500"
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
To: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------090804010802070400070500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


In case no OMAP2_CTRL_BASE is set, set default one to fix compilation
errors e.g. for OMAP1.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>

--------------090804010802070400070500
Content-Type: text/plain;
 name="omap2_ctrl_base_fix_for_omap1.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="omap2_ctrl_base_fix_for_omap1.txt"

Index: linux-osk/include/asm-arm/arch-omap/omap24xx.h
===================================================================
--- linux-osk.orig/include/asm-arm/arch-omap/omap24xx.h
+++ linux-osk/include/asm-arm/arch-omap/omap24xx.h
@@ -103,6 +103,11 @@
 
 #endif
 
+#if !defined(OMAP2_CTRL_BASE)
+/* If no one of the above configs is selected, use default */
+#define OMAP2_CTRL_BASE		L4_24XX_BASE
+#endif
+
 /* Control module */
 #define OMAP2_CONTROL_DEVCONF0	(OMAP2_CTRL_BASE + 0x274)
 #define OMAP2_CONTROL_DEVCONF1	(OMAP2_CTRL_BASE + 0x2e8)


--------------090804010802070400070500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090804010802070400070500--
