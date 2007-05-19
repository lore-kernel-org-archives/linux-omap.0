From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix section mismatch in board-sx1.c
Date: Sat, 19 May 2007 17:14:28 +0200
Message-ID: <464F1454.6040603@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000702040304010709080906"
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
--------------000702040304010709080906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fix section mismatch in board-sx1.c

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>



--------------000702040304010709080906
Content-Type: text/plain;
 name="fix_section_mismatch_board_sx1.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix_section_mismatch_board_sx1.txt"

Index: linux-osk/arch/arm/mach-omap1/board-sx1.c
===================================================================
--- linux-osk.orig/arch/arm/mach-omap1/board-sx1.c
+++ linux-osk/arch/arm/mach-omap1/board-sx1.c
@@ -280,21 +280,6 @@ static struct omap_mcbsp_reg_cfg mcbsp1_
 						/* PCR0 =0f0f */
 };
 
-/* TODO: PCM interface - McBSP2 */
-static struct omap_mcbsp_reg_cfg mcbsp2_regs = {
-	.spcr2	= FRST | GRST | XRST | XINTM(3),	/* SPCR2=F1 */
-	.spcr1	= RINTM(3) | RRST,	/* SPCR1=30 */
-	.rcr2	= 0,	/* RCR2 =00 */
-	.rcr1	= RFRLEN1(1) | RWDLEN1(OMAP_MCBSP_WORD_16), /* RCR1 = 140 */
-	.xcr2	= 0,	/* XCR2 = 0 */
-	.xcr1	= XFRLEN1(1) | XWDLEN1(OMAP_MCBSP_WORD_16), /* XCR1 = 140 */
-	.srgr1	= FWID(15) | CLKGDV(12),	/* SRGR1=0f0c */
-	.srgr2	= FSGM | FPER(31),	/* SRGR2=101f */
-	.pcr0	= FSXM | FSRM | CLKXM | CLKRM | FSXP | FSRP | CLKXP | CLKRP,
-						/* PCR0=0f0f */
-	/* mcbsp: slave */
-};
-
 static struct omap_alsa_codec_config sx1_alsa_config = {
 	.name			= "SX1 EGold",
 	.mcbsp_regs_alsa	= &mcbsp1_regs,
@@ -440,7 +425,7 @@ static struct omap_uart_config sx1_uart_
 	.enabled_uarts = ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
-static struct omap_board_config_kernel sx1_config[] = {
+static struct omap_board_config_kernel sx1_config[] __initdata = {
 	{ OMAP_TAG_USB,	&sx1_usb_config },
 	{ OMAP_TAG_MMC,	&sx1_mmc_config },
 	{ OMAP_TAG_LCD,	&sx1_lcd_config },

--------------000702040304010709080906
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000702040304010709080906--
