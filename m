From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix section mismatch in board-palmz71.c
Date: Sat, 19 May 2007 17:17:50 +0200
Message-ID: <464F151E.9080203@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030903020907030602000005"
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
--------------030903020907030602000005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fix section mismatch in board-palmz71.c

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>


--------------030903020907030602000005
Content-Type: text/plain;
 name="fix_section_mismatch_board_palmz71.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="fix_section_mismatch_board_palmz71.txt"

Index: linux-osk/arch/arm/mach-omap1/board-palmz71.c
===================================================================
--- linux-osk.orig/arch/arm/mach-omap1/board-palmz71.c
+++ linux-osk/arch/arm/mach-omap1/board-palmz71.c
@@ -286,7 +286,7 @@ static struct omap_uart_config palmz71_u
 	.enabled_uarts = (1 << 0) | (1 << 1) | (0 << 2),
 };
 
-static struct omap_board_config_kernel palmz71_config[] = {
+static struct omap_board_config_kernel palmz71_config[] __initdata = {
 	{OMAP_TAG_USB,	&palmz71_usb_config},
 	{OMAP_TAG_MMC,	&palmz71_mmc_config},
 	{OMAP_TAG_LCD,	&palmz71_lcd_config},

--------------030903020907030602000005
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030903020907030602000005--
