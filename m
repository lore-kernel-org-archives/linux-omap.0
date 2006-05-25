From: lamikr <lamikr@cc.jyu.fi>
Subject: [PATCH 3/3] aic23: aic23 alsa platform driver code for
	board-innovator.
Date: Thu, 25 May 2006 23:53:49 +0300
Message-ID: <4476195D.8090102@cc.jyu.fi>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010208000008080703080202"
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

This is a multi-part message in MIME format.
--------------010208000008080703080202
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Add platform driver init-code required by the aic23-alsa driver to
omap-innovator.

Signed-off-by: Mika Laitio <lamikr@cc.jyu.fi>

--------------010208000008080703080202
Content-Type: text/plain;
	name="0003-aic23-alsa-platform-driver-code-for-board-innovator.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="0003-aic23-alsa-platform-driver-code-for-board-innovator.txt"

>From nobody Mon Sep 17 00:00:00 2001
From: Mika Laitio <lamikr@cc.jyu.fi>
Date: Thu May 25 23:25:37 2006 +0300
Subject: [PATCH 3/3] aic23: aic23 alsa platform driver code for board-innovator.

Signed-off-by: Mika Laitio <lamikr@cc.jyu.fi>


---

 arch/arm/mach-omap1/board-innovator.c |   39 +++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

d8e3fb253d5bf73d041cc8825da1eec1f2df4e9e
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index e90c137..43260aa 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -37,6 +37,8 @@
 #include <asm/arch/usb.h>
 #include <asm/arch/keypad.h>
 #include <asm/arch/common.h>
+#include <asm/arch/mcbsp.h>
+#include <asm/arch/omap-alsa.h>
 
 static int innovator_keymap[] = {
 	KEY(0, 0, KEY_F1),
@@ -112,6 +114,42 @@ static struct platform_device innovator_
 	.resource	= &innovator_flash_resource,
 };
 
+#define DEFAULT_BITPERSAMPLE 16
+
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
+	.name			= "OMAP Innovator AIC23",
+	.mcbsp_regs_alsa	= &mcbsp_regs,
+	.codec_configure_dev	= NULL, // aic23_configure,
+	.codec_set_samplerate	= NULL, // aic23_set_samplerate,
+	.codec_clock_setup	= NULL, // aic23_clock_setup,
+	.codec_clock_on		= NULL, // aic23_clock_on,
+	.codec_clock_off	= NULL, // aic23_clock_off,
+	.get_default_samplerate	= NULL, // aic23_get_default_samplerate,
+};
+
+static struct platform_device innovator_mcbsp1_device = {
+	.name	= "omap_alsa_mcbsp",
+ 	.id	= 1,
+	.dev = {
+		.platform_data	= &alsa_config,
+	},
+};
+
 static struct resource innovator_kp_resources[] = {
 	[0] = {
 		.start	= INT_KEYBOARD,
@@ -177,6 +215,7 @@ static struct platform_device innovator1
 static struct platform_device *innovator1510_devices[] __initdata = {
 	&innovator_flash_device,
 	&innovator1510_smc91x_device,
+	&innovator_mcbsp1_device,
 	&innovator_kp_device,
 	&innovator1510_lcd_device,
 };
-- 
1.2.2


--------------010208000008080703080202
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------010208000008080703080202--
