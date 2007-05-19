From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix section mismatch in board-palmtt.c
Date: Sat, 19 May 2007 17:17:03 +0200
Message-ID: <464F14EF.3080203@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010209040901010801020703"
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
--------------010209040901010801020703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fix section mismatch in board-palmtt.c

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>


--------------010209040901010801020703
Content-Type: text/plain;
 name="fix_section_mismatch_board_palmtt.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="fix_section_mismatch_board_palmtt.txt"

Index: linux-osk/arch/arm/mach-omap1/board-palmtt.c
===================================================================
--- linux-osk.orig/arch/arm/mach-omap1/board-palmtt.c
+++ linux-osk/arch/arm/mach-omap1/board-palmtt.c
@@ -313,7 +313,7 @@ static struct omap_uart_config palmtt_ua
 	.enabled_uarts = (1 << 0) | (1 << 1) | (0 << 2),
 };
 
-static struct omap_board_config_kernel palmtt_config[] = {
+static struct omap_board_config_kernel palmtt_config[] __initdata = {
 	{ OMAP_TAG_USB,		&palmtt_usb_config	},
 	{ OMAP_TAG_LCD,		&palmtt_lcd_config	},
 	{ OMAP_TAG_UART,	&palmtt_uart_config	},

--------------010209040901010801020703
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------010209040901010801020703--
