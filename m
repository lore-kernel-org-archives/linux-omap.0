From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix section mismatch in board-h3.c
Date: Sat, 19 May 2007 17:10:07 +0200
Message-ID: <464F134F.1090809@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080909060407050401010007"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------080909060407050401010007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fix section mismatch in board-h3.c

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>


--------------080909060407050401010007
Content-Type: text/plain;
 name="fix_section_mismatch_board_h3.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix_section_mismatch_board_h3.txt"

Index: linux-osk/arch/arm/mach-omap1/board-h3.c
===================================================================
--- linux-osk.orig/arch/arm/mach-omap1/board-h3.c
+++ linux-osk/arch/arm/mach-omap1/board-h3.c
@@ -533,7 +533,7 @@ static struct omap_lcd_config h3_lcd_con
 	.ctrl_name	= "internal",
 };
 
-static struct omap_board_config_kernel h3_config[] = {
+static struct omap_board_config_kernel h3_config[] __initdata = {
 	{ OMAP_TAG_USB,		&h3_usb_config },
 	{ OMAP_TAG_MMC,		&h3_mmc_config },
 	{ OMAP_TAG_UART,	&h3_uart_config },

--------------080909060407050401010007
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080909060407050401010007--
