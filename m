From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix section mismatch in board-palmte.c
Date: Sat, 19 May 2007 17:15:34 +0200
Message-ID: <464F1496.5050900@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060108020708020907050702"
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
--------------060108020708020907050702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fix section mismatch in board-palmte.c

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>


--------------060108020708020907050702
Content-Type: text/plain;
 name="fix_section_mismatch_board_palmte.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="fix_section_mismatch_board_palmte.txt"

Index: linux-osk/arch/arm/mach-omap1/board-palmte.c
===================================================================
--- linux-osk.orig/arch/arm/mach-omap1/board-palmte.c
+++ linux-osk/arch/arm/mach-omap1/board-palmte.c
@@ -324,7 +324,7 @@ static struct tsc2102_config palmte_tsc2
 	.alsa_config	= &palmte_alsa_config,
 };
 
-static struct omap_board_config_kernel palmte_config[] = {
+static struct omap_board_config_kernel palmte_config[] __initdata = {
 	{ OMAP_TAG_USB,		&palmte_usb_config },
 	{ OMAP_TAG_MMC,		&palmte_mmc_config },
 	{ OMAP_TAG_LCD,		&palmte_lcd_config },

--------------060108020708020907050702
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------060108020708020907050702--
