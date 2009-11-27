From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH] ASoC: AIC23: Fixing infinite loop in resume
	path
Date: Fri, 27 Nov 2009 17:40:58 +0530
Message-ID: <1259323858-32203-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: Anuj Aggarwal <anuj.aggarwal@ti.com>, broonie@opensource.wolfsonmicro.com
List-Id: linux-omap@vger.kernel.org

This patch fixes two issues:
a) Infinite loop in resume function
b) Writes to non-existing registers in resume function

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 sound/soc/codecs/tlv320aic23.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index 6b24d8b..90a0264 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -625,11 +625,10 @@ static int tlv320aic23_resume(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_codec *codec = socdev->card->codec;
-	int i;
 	u16 reg;
 
 	/* Sync reg_cache with the hardware */
-	for (reg = 0; reg < ARRAY_SIZE(tlv320aic23_reg); i++) {
+	for (reg = 0; reg < TLV320AIC23_RESET; reg++) {
 		u16 val = tlv320aic23_read_reg_cache(codec, reg);
 		tlv320aic23_write(codec, reg, val);
 	}
-- 
1.6.2.4
