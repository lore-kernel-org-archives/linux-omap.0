From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 1/1] ASoC: AIC23: Fixing writes to non-existing
	registers in resume function
Date: Fri, 29 Jan 2010 13:58:55 +0530
Message-ID: <1264753735-7190-1-git-send-email-anuj.aggarwal@ti.com>
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

Commit e9ff5eb2 (Fixing infinite loop in resume path) uses wrong AIC23
register in resume function because of which register writes happen
on some non-existing registers.

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 sound/soc/codecs/tlv320aic23.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index a9dc5fb..da589d8 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -627,7 +627,7 @@ static int tlv320aic23_resume(struct platform_device *pdev)
 	u16 reg;
 
 	/* Sync reg_cache with the hardware */
-	for (reg = 0; reg < TLV320AIC23_RESET; reg++) {
+	for (reg = 0; reg <= TLV320AIC23_ACTIVE; reg++) {
 		u16 val = tlv320aic23_read_reg_cache(codec, reg);
 		tlv320aic23_write(codec, reg, val);
 	}
-- 
1.6.2.4
