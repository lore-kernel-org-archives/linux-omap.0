From: Ilkka Koskinen <ilkka.koskinen@nokia.com>
Subject: [PATCH 1/2] omap: Remove unnecessary
	twl4030_codec_audio settings from board files
Date: Wed,  2 Mar 2011 15:24:05 +0200
Message-ID: <1299072246-26402-2-git-send-email-ilkka.koskinen@nokia.com>
References: <1299072246-26402-1-git-send-email-ilkka.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1299072246-26402-1-git-send-email-ilkka.koskinen@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: peter.ujfalusi@nokia.com, tony@atomide.com, sameo@linux.intel.com, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

twl4030_codec_audio and twl4030_codec_vibra_data has unused field.
In order to remove it, corresponding settings needs to be removed
from board files.

Signed-off-by: Ilkka Koskinen <ilkka.koskinen@nokia.com>
---
 arch/arm/mach-omap2/board-3430sdp.c          |    4 +---
 arch/arm/mach-omap2/board-devkit8000.c       |    4 +---
 arch/arm/mach-omap2/board-igep0020.c         |    4 +---
 arch/arm/mach-omap2/board-omap3beagle.c      |    4 +---
 arch/arm/mach-omap2/board-omap3evm.c         |    4 +---
 arch/arm/mach-omap2/board-omap3pandora.c     |    4 +---
 arch/arm/mach-omap2/board-omap3stalker.c     |    4 +---
 arch/arm/mach-omap2/board-omap3touchbook.c   |    4 +---
 arch/arm/mach-omap2/board-overo.c            |    4 +---
 arch/arm/mach-omap2/board-zoom-peripherals.c |    4 +---
 10 files changed, 10 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index d4e41ef..4722ffa 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -567,9 +567,7 @@ static struct regulator_init_data sdp3430_vpll2 = {
 	.consumer_supplies	= sdp3430_vpll2_supplies,
 };
 
-static struct twl4030_codec_audio_data sdp3430_audio = {
-	.audio_mclk = 26000000,
-};
+static struct twl4030_codec_audio_data sdp3430_audio;
 
 static struct twl4030_codec_data sdp3430_codec = {
 	.audio_mclk = 26000000,
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 00bb1fc..755f63a 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -346,9 +346,7 @@ static struct twl4030_usb_data devkit8000_usb_data = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
 
-static struct twl4030_codec_audio_data devkit8000_audio_data = {
-	.audio_mclk = 26000000,
-};
+static struct twl4030_codec_audio_data devkit8000_audio_data;
 
 static struct twl4030_codec_data devkit8000_codec_data = {
 	.audio_mclk = 26000000,
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 3be85a1..6022990 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -533,9 +533,7 @@ static void __init igep2_init_irq(void)
 	omap_init_irq();
 }
 
-static struct twl4030_codec_audio_data igep2_audio_data = {
-	.audio_mclk = 26000000,
-};
+static struct twl4030_codec_audio_data igep2_audio_data;
 
 static struct twl4030_codec_data igep2_codec_data = {
 	.audio_mclk = 26000000,
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 46d814a..164b4c3 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -435,9 +435,7 @@ static struct twl4030_usb_data beagle_usb_data = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
 
-static struct twl4030_codec_audio_data beagle_audio_data = {
-	.audio_mclk = 26000000,
-};
+static struct twl4030_codec_audio_data beagle_audio_data;
 
 static struct twl4030_codec_data beagle_codec_data = {
 	.audio_mclk = 26000000,
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 323c380..db147d7 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -491,9 +491,7 @@ static struct twl4030_madc_platform_data omap3evm_madc_data = {
 	.irq_line	= 1,
 };
 
-static struct twl4030_codec_audio_data omap3evm_audio_data = {
-	.audio_mclk = 26000000,
-};
+static struct twl4030_codec_audio_data omap3evm_audio_data;
 
 static struct twl4030_codec_data omap3evm_codec_data = {
 	.audio_mclk = 26000000,
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 0b34bed..51e8c20 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -524,9 +524,7 @@ static struct twl4030_usb_data omap3pandora_usb_data = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
 
-static struct twl4030_codec_audio_data omap3pandora_audio_data = {
-	.audio_mclk = 26000000,
-};
+static struct twl4030_codec_audio_data omap3pandora_audio_data;
 
 static struct twl4030_codec_data omap3pandora_codec_data = {
 	.audio_mclk = 26000000,
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 2a2dad4..2572f71 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -439,9 +439,7 @@ static struct twl4030_madc_platform_data omap3stalker_madc_data = {
 	.irq_line	= 1,
 };
 
-static struct twl4030_codec_audio_data omap3stalker_audio_data = {
-	.audio_mclk	= 26000000,
-};
+static struct twl4030_codec_audio_data omap3stalker_audio_data;
 
 static struct twl4030_codec_data omap3stalker_codec_data = {
 	.audio_mclk	= 26000000,
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index db1f74f..25eb470 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -252,9 +252,7 @@ static struct twl4030_usb_data touchbook_usb_data = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
 
-static struct twl4030_codec_audio_data touchbook_audio_data = {
-	.audio_mclk = 26000000,
-};
+static struct twl4030_codec_audio_data touchbook_audio_data;
 
 static struct twl4030_codec_data touchbook_codec_data = {
 	.audio_mclk = 26000000,
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index cb26e5d..faf6288 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -358,9 +358,7 @@ static struct regulator_init_data overo_vmmc1 = {
 	.consumer_supplies	= &overo_vmmc1_supply,
 };
 
-static struct twl4030_codec_audio_data overo_audio_data = {
-	.audio_mclk = 26000000,
-};
+static struct twl4030_codec_audio_data overo_audio_data;
 
 static struct twl4030_codec_data overo_codec_data = {
 	.audio_mclk = 26000000,
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index e0e040f..1ac9d35 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -322,9 +322,7 @@ static struct twl4030_madc_platform_data zoom_madc_data = {
 	.irq_line	= 1,
 };
 
-static struct twl4030_codec_audio_data zoom_audio_data = {
-	.audio_mclk = 26000000,
-};
+static struct twl4030_codec_audio_data zoom_audio_data;
 
 static struct twl4030_codec_data zoom_codec_data = {
 	.audio_mclk = 26000000,
-- 
1.7.0.4
