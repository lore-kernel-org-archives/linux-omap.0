From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 3/3] arm: more fallout from i2c conversions in board-omap4panda.c
Date: Mon,  5 Mar 2012 17:41:50 -0500
Message-ID: <1330987310-8108-4-git-send-email-paul.gortmaker@windriver.com>
References: <1330987310-8108-1-git-send-email-paul.gortmaker@windriver.com>
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <1330987310-8108-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-next-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-next@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@opensource.wolfsonicro.com>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

Commit ded0df8510778a03a2f182a0cbfe3c25788e8852 (linux-next)

   "mfd: Convert twl6040 to an i2c driver, and separate it from twl core"

appears to have done an incomplete conversion on the board-omap4panda.c
file, leaving it with more build failures.  Comparing the changes that
were done for board-4430sdp.c it is possible for me to whack it with a
stick until it stops twitching, but someone who really understands this
code needs to take a look at the conversion, and check it is done
completely and in a way that will actually work on hardware.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
CC: Peter Ujfalusi <peter.ujfalusi@ti.com>
CC: Mark Brown <broonie@opensource.wolfsonicro.com>
CC: Samuel Ortiz <sameo@linux.intel.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index e919153..16a1814 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -287,16 +287,15 @@ static struct twl6040_codec_data twl6040_codec = {
 	.hf_right_step	= 0x1d,
 };
 
-static struct twl4030_audio_data twl6040_audio = {
+static struct twl6040_platform_data twl6040_data = {
 	.codec		= &twl6040_codec,
 	.audpwron_gpio	= 127,
-	.naudint_irq	= OMAP44XX_IRQ_SYS_2N,
 	.irq_base	= TWL6040_CODEC_IRQ_BASE,
 };
 
 /* Panda board uses the common PMIC configuration */
 static struct twl4030_platform_data omap4_panda_twldata = {
-	.audio		= &twl6040_audio,
+   /*	.audio		= &twl6040_audio,	*/
 };
 
 /*
-- 
1.7.9.1
