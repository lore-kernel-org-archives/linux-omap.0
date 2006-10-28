From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP1: Fix CONFIG_DEBUG_LL
Date: Sat, 28 Oct 2006 08:15:33 +0200
Message-ID: <4542F585.1070604@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080208090106050109040502"
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

This is a multi-part message in MIME format.
--------------080208090106050109040502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fix broken CONFIG_DEBUG_LL. In case of low level debugging
reconfigure some clocks early.

See

http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commitdiff;h=3bfb289ccc6c4624fd5ff0381546935e105f4093

too.

   Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>



--------------080208090106050109040502
Content-Type: text/plain;
 name="omap1_CONFIG_DEBUG_LL_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="omap1_CONFIG_DEBUG_LL_patch.txt"

Index: linux-osk/arch/arm/mach-omap1/clock.c
===================================================================
--- linux-osk.orig/arch/arm/mach-omap1/clock.c
+++ linux-osk/arch/arm/mach-omap1/clock.c
@@ -649,6 +649,13 @@ int __init omap1_clk_init(void)
 	int crystal_type = 0; /* Default 12 MHz */
 	u32 reg;
 
+#ifdef CONFIG_DEBUG_LL
+	/* Resets some clocks that may be left on from bootloader,
+ 	 * but leaves serial clocks on.
+ 	 */
+	omap_writel(0x3 << 29, MOD_CONF_CTRL_0);
+#endif
+
 	/* USB_REQ_EN will be disabled later if necessary (usb_dc_ck) */
 	reg = omap_readw(SOFT_REQ_REG) & (1 << 4);
 	omap_writew(reg, SOFT_REQ_REG);


--------------080208090106050109040502
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080208090106050109040502--
