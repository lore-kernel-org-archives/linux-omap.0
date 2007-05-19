From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix section mismatch in board-h4.c
Date: Sat, 19 May 2007 17:11:02 +0200
Message-ID: <464F1386.4010007@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010605040301010600080001"
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
--------------010605040301010600080001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fix section mismatch in board-h4.c

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>


--------------010605040301010600080001
Content-Type: text/plain;
 name="fix_section_mismatch_board_h4.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix_section_mismatch_board_h4.txt"

Index: linux-osk/arch/arm/mach-omap2/board-h4.c
===================================================================
--- linux-osk.orig/arch/arm/mach-omap2/board-h4.c
+++ linux-osk/arch/arm/mach-omap2/board-h4.c
@@ -418,7 +418,7 @@ static struct omap_usb_config h4_usb_con
 #endif
 };
 
-static struct omap_board_config_kernel h4_config[] = {
+static struct omap_board_config_kernel h4_config[] __initdata = {
 	{ OMAP_TAG_UART,	&h4_uart_config },
 	{ OMAP_TAG_MMC,		&h4_mmc_config },
 	{ OMAP_TAG_LCD,		&h4_lcd_config },

--------------010605040301010600080001
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------010605040301010600080001--
