From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v6 18/18] OMAP4: SDP4430: Add twl6040 codec
	platform support
Date: Wed, 22 Jun 2011 14:25:21 +0300
Message-ID: <1308741921-32556-1-git-send-email-peter.ujfalusi@ti.com>
References: <1308663556-29120-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1308663556-29120-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-input@vger.kernel.org, Misael Lopez Cruz <misael.lopez@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Misael Lopez Cruz <misael.lopez@ti.com>

Configure, and enable the twl6040 codec on SDP4430.

Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 266d146..369250b 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -432,6 +432,14 @@ static struct regulator_init_data sdp4430_vusim = {
 	},
 };
 
+static struct twl4030_codec_data twl6040_codec = {
+	/* single-step ramp for headset and handsfree */
+	.hs_left_step	= 0x0f,
+	.hs_right_step	= 0x0f,
+	.hf_left_step	= 0x1d,
+	.hf_right_step	= 0x1d,
+};
+
 static struct twl4030_vibra_data twl6040_vibra = {
 	.vibldrv_res = 8,
 	.vibrdrv_res = 3,
@@ -442,7 +450,7 @@ static struct twl4030_vibra_data twl6040_vibra = {
 };
 
 static struct twl4030_audio_data twl6040_audio = {
-	.codec		= NULL,
+	.codec		= &twl6040_codec,
 	.vibra		= &twl6040_vibra,
 	.audpwron_gpio	= 127,
 	.naudint_irq	= OMAP44XX_IRQ_SYS_2N,
-- 
1.7.5.3
