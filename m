From: lamikr <lamikr@cc.jyu.fi>
Subject: [PATCH] board-nokia-770.c: Add missing alsa platform driver code
Date: Thu, 06 Apr 2006 02:20:48 +0300
Message-ID: <443450D0.1020001@cc.jyu.fi>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080307030405050706050908"
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
--------------080307030405050706050908
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi it seems that 770 is also using aic23 alsa driver, original patches
added aic23 platform data driver code only to board-osk.c,
but this adds now a similar platform driver config also to board-nokia770.c.
I have only tested made a compile test for this one.Can somebody who is
building own kernels for 770 try to build, boot & "play it again sam"
with this?
The patch should apply on top of both to 2.6.16-omap2 branch and
linux-omap git head.

Signed off: Mika Laitio lamikr@cc.jyu.fi

Mika



--------------080307030405050706050908
Content-Type: text/x-patch;
	name="board-nokia-770.c-Add-missing-alsa-platform-driver-code.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="board-nokia-770.c-Add-missing-alsa-platform-driver-code.patch"

Subject: [PATCH] board-nokia-770.c: Add missing alsa platform driver code.
Signed-off-by: Mika Laitio <lamikr@cc.jyu.fi>

---

 arch/arm/mach-omap1/board-nokia770.c |   39 ++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

4b0bfc38bfa33f82155b339709131e6dc3dfa0ab
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 02b980d..924c5bd 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -31,6 +31,8 @@
 #include <asm/arch/dsp_common.h>
 #include <asm/arch/aic23.h>
 #include <asm/arch/gpio.h>
+#include <asm/arch/mcbsp.h>
+#include <asm/arch/omap-alsa.h>
 
 static void __init omap_nokia770_init_irq(void)
 {
@@ -86,8 +88,45 @@ static struct platform_device nokia770_k
 	.resource	= nokia770_kp_resources,
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
+	.name			= "n770 AIC23",
+	.mcbsp_regs_alsa	= &mcbsp_regs,
+	.codec_configure_dev	= NULL, // aic23_configure,
+	.codec_set_samplerate	= NULL, // aic23_set_samplerate,
+	.codec_clock_setup	= NULL, // aic23_clock_setup,
+	.codec_clock_on		= NULL, // aic23_clock_on,
+	.codec_clock_off	= NULL, // aic23_clock_off,
+	.get_default_samplerate	= NULL, // aic23_get_default_samplerate,	
+};
+
+static struct platform_device nokia770_mcbsp1_device = {
+	.name	= "omap_alsa_mcbsp",
+ 	.id	= 1,
+	.dev = {
+		.platform_data	= &alsa_config,
+	},
+};
+
 static struct platform_device *nokia770_devices[] __initdata = {
         &nokia770_kp_device,
+	&nokia770_mcbsp1_device,
 };
 
 static struct ads7846_platform_data nokia770_ads7846_platform_data __initdata = {
-- 
1.0.GIT

--------------080307030405050706050908
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080307030405050706050908--
