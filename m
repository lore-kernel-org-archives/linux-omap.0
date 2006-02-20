From: "Daniel Petrini" <d.pensator@gmail.com>
Subject: [PATCH] Alsa modularisations and support for tsc2101 4/7
Date: Mon, 20 Feb 2006 13:53:09 -0400
Message-ID: <9268368b0602200953q181b7a4em1944ece745d5acd3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_286_24543845.1140457989848"
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
To: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

------=_Part_286_24543845.1140457989848
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

ALSA Omap Patch

This patch includes the platform device support for the new proposed
approach. For OSK and H2.

signed-off by Daniel Petrini <d.pensator@gmail.com>
signed-off by Mika Laitio <lamikr@cc.jyu.fi>


Daniel Petrini
--
INdT - Manaus - Brazil

------=_Part_286_24543845.1140457989848
Content-Type: text/x-patch; name=alsa4-20060214.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ejx2pglf
Content-Disposition: attachment; filename="alsa4-20060214.patch"

ALSA Omap Patch

This patch includes the platform device support for the new proposed approach. For OSK and H2.

signed-off by Daniel Petrini <d.pensator@gmail.com>
signed-off by Mika Laitio <lamikr@cc.jyu.fi>

Index: linux-omap-2.6.git-q/arch/arm/mach-omap1/board-osk.c
===================================================================
--- linux-omap-2.6.git-q.orig/arch/arm/mach-omap1/board-osk.c	2006-02-15 13:08:00.000000000 -0400
+++ linux-omap-2.6.git-q/arch/arm/mach-omap1/board-osk.c	2006-02-15 14:56:53.000000000 -0400
@@ -47,6 +47,8 @@
 #include <asm/arch/tc.h>
 #include <asm/arch/keypad.h>
 #include <asm/arch/common.h>
+#include <asm/arch/mcbsp.h>
+#include <asm/arch/omap-alsa.h>
 
 static int osk_keymap[] = {
 	KEY(0, 0, KEY_F1),
@@ -149,9 +151,39 @@ static struct platform_device osk5912_cf
 	.resource	= osk5912_cf_resources,
 };
 
+#define DEFAULT_BITPERSAMPLE          16
+static struct omap_mcbsp_reg_cfg mcbsp_regs = { 
+	.spcr2 = FREE | FRST | GRST | XRST | XINTM(3),
+	.spcr1 = RINTM(3) | RRST,
+	.rcr2 = RPHASE | RFRLEN2(OMAP_MCBSP_WORD_8) |
+	    RWDLEN2(OMAP_MCBSP_WORD_16) | RDATDLY(0),
+	.rcr1 = RFRLEN1(OMAP_MCBSP_WORD_8) | RWDLEN1(OMAP_MCBSP_WORD_16),
+	.xcr2 = XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) |
+	    XWDLEN2(OMAP_MCBSP_WORD_16) | XDATDLY(0) | XFIG,
+	.xcr1 = XFRLEN1(OMAP_MCBSP_WORD_8) | XWDLEN1(OMAP_MCBSP_WORD_16),
+	.srgr1 = FWID(DEFAULT_BITPERSAMPLE - 1),
+	.srgr2 = GSYNC | CLKSP | FSGM | FPER(DEFAULT_BITPERSAMPLE * 2 - 1),
+	/*.pcr0 = FSXM | FSRM | CLKXM | CLKRM | CLKXP | CLKRP,*/ /* mcbsp: master */
+	.pcr0 = CLKXP | CLKRP,  /* mcbsp: slave */
+};
+
+static struct omap_alsa_codec_config alsa_config = {
+	.name			= "OSK AIC23",
+	.mcbsp_regs_alsa	= &mcbsp_regs,
+	.codec_configure_dev	= aic23_configure,
+	.codec_set_samplerate	= aic23_set_samplerate,
+	.codec_clock_setup	= aic23_clock_setup,
+	.codec_clock_on		= aic23_clock_on,
+	.codec_clock_off	= aic23_clock_off,
+	.get_default_samplerate	= aic23_get_default_samplerate,	
+};
+
 static struct platform_device osk5912_mcbsp1_device = {
-	.name		= "omap_mcbsp",
+	.name 		= "omap_alsa_mcbsp",
 	.id		= 1,
+	.dev = {
+		.platform_data = &alsa_config,
+	},
 };
 
 static struct resource osk5912_kp_resources[] = {
Index: linux-omap-2.6.git-q/arch/arm/mach-omap1/board-h2.c
===================================================================
--- linux-omap-2.6.git-q.orig/arch/arm/mach-omap1/board-h2.c	2006-02-15 13:07:59.000000000 -0400
+++ linux-omap-2.6.git-q/arch/arm/mach-omap1/board-h2.c	2006-02-15 15:00:26.000000000 -0400
@@ -41,6 +41,8 @@
 #include <asm/arch/usb.h>
 #include <asm/arch/keypad.h>
 #include <asm/arch/common.h>
+#include <asm/arch/mcbsp.h>
+#include <asm/arch/omap-alsa.h>
 
 extern int omap_gpio_init(void);
 
@@ -276,6 +278,41 @@ static struct platform_device h2_lcd_dev
 	.id		= -1,
 };
 
+static struct omap_mcbsp_reg_cfg mcbsp_regs = { 
+       .spcr2 = FREE | FRST | GRST | XRST | XINTM(3),
+       .spcr1 = RINTM(3) | RRST,
+       .rcr2  = RPHASE | RFRLEN2(OMAP_MCBSP_WORD_8) |
+                RWDLEN2(OMAP_MCBSP_WORD_16) | RDATDLY(1),
+       .rcr1  = RFRLEN1(OMAP_MCBSP_WORD_8) | RWDLEN1(OMAP_MCBSP_WORD_16),
+       .xcr2  = XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) | 
+                XWDLEN2(OMAP_MCBSP_WORD_16) | XDATDLY(1) | XFIG,
+       .xcr1  = XFRLEN1(OMAP_MCBSP_WORD_8) | XWDLEN1(OMAP_MCBSP_WORD_16),
+       .srgr1 = FWID(15),
+       .srgr2 = GSYNC | CLKSP | FSGM | FPER(31),
+
+       .pcr0  = CLKXM | CLKRM | FSXP | FSRP | CLKXP | CLKRP,
+       //.pcr0 = CLKXP | CLKRP,        /* mcbsp: slave */
+ };
+ 
+ static struct omap_alsa_codec_config alsa_config = {
+       .name                   = "H2 TSC2101",
+       .mcbsp_regs_alsa        = &mcbsp_regs,
+       .codec_configure_dev    = tsc2101_configure,
+       .codec_set_samplerate   = tsc2101_set_samplerate,
+       .codec_clock_setup      = tsc2101_clock_setup,
+       .codec_clock_on         = tsc2101_clock_on,
+       .codec_clock_off        = tsc2101_clock_off,
+       .get_default_samplerate = tsc2101_get_default_samplerate,
+};    
+
+static struct platform_device h2_mcbsp1_device = {
+       .name           = "omap_alsa_mcbsp",
+       .id             = 1,
+       .dev = {
+               .platform_data = &alsa_config,
+       }, 
+ };    
+
 static struct platform_device *h2_devices[] __initdata = {
 	&h2_nor_device,
 	&h2_nand_device,
@@ -283,6 +320,7 @@ static struct platform_device *h2_device
 	&h2_irda_device,
 	&h2_kp_device,
 	&h2_lcd_device,
+	&h2_mcbsp1_device,
 };
 
 static void __init h2_init_smc91x(void)

------=_Part_286_24543845.1140457989848
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_286_24543845.1140457989848--
