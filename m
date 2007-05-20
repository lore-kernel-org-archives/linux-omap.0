From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix section mismatch in OMAP1 board-generic.c
Date: Sun, 20 May 2007 09:50:49 +0200
Message-ID: <464FFDD9.7000603@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030404010307050608090809"
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
--------------030404010307050608090809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fix section mismatch in OMAP1 board-generic.c

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>


--------------030404010307050608090809
Content-Type: text/plain; name="fix_section_mismatch_omap1_board_generic.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="fix_section_mismatch_omap1_board_generic.txt"

Index: linux-osk/arch/arm/mach-omap1/board-generic.c
===================================================================
--- linux-osk.orig/arch/arm/mach-omap1/board-generic.c
+++ linux-osk/arch/arm/mach-omap1/board-generic.c
@@ -79,7 +79,7 @@ static struct omap_uart_config generic_u
 	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
-static struct omap_board_config_kernel generic_config[] = {
+static struct omap_board_config_kernel generic_config[] __initdata = {
 	{ OMAP_TAG_USB,           NULL },
 	{ OMAP_TAG_MMC,           &generic_mmc_config },
 	{ OMAP_TAG_UART,	&generic_uart_config },


--------------030404010307050608090809
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030404010307050608090809--
