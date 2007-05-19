From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix section mismatch in board-nokia770.c
Date: Sat, 19 May 2007 17:11:57 +0200
Message-ID: <464F13BD.7020006@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010103050001020202040101"
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
--------------010103050001020202040101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fix section mismatch in board-nokia770.c

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>



--------------010103050001020202040101
Content-Type: text/plain;
 name="fix_section_mismatch_board_nokia770.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="fix_section_mismatch_board_nokia770.txt"

Index: linux-osk/arch/arm/mach-omap1/board-nokia770.c
===================================================================
--- linux-osk.orig/arch/arm/mach-omap1/board-nokia770.c
+++ linux-osk/arch/arm/mach-omap1/board-nokia770.c
@@ -234,7 +234,7 @@ static struct omap_mmc_config nokia770_m
 	},
 };
 
-static struct omap_board_config_kernel nokia770_config[] = {
+static struct omap_board_config_kernel nokia770_config[] __initdata = {
 	{ OMAP_TAG_USB,		NULL },
 	{ OMAP_TAG_MMC,		&nokia770_mmc_config },
 };

--------------010103050001020202040101
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------010103050001020202040101--
