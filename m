From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix section mismatch in OMAP2 board-generic.c
Date: Sun, 20 May 2007 09:51:09 +0200
Message-ID: <464FFDED.9000204@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090506020007000709070302"
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
--------------090506020007000709070302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fix section mismatch in OMAP2 board-generic.c

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>


--------------090506020007000709070302
Content-Type: text/plain; name="fix_section_mismatch_omap2_board_generic.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="fix_section_mismatch_omap2_board_generic.txt"

Index: linux-osk/arch/arm/mach-omap2/board-generic.c
===================================================================
--- linux-osk.orig/arch/arm/mach-omap2/board-generic.c
+++ linux-osk/arch/arm/mach-omap2/board-generic.c
@@ -51,7 +51,7 @@ static struct omap_mmc_config generic_mm
 	},
 };
 
-static struct omap_board_config_kernel generic_config[] = {
+static struct omap_board_config_kernel generic_config[] __initdata = {
 	{ OMAP_TAG_UART,	&generic_uart_config },
 	{ OMAP_TAG_MMC,		&generic_mmc_config },
 };


--------------090506020007000709070302
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090506020007000709070302--
