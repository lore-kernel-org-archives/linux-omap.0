From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 8/8] ASoC: omap-mcbsp: No need to initialize
	max_xx_thres when it is not used
Date: Thu, 8 Nov 2018 09:30:00 +0200
Message-ID: <20181108073000.21114-9-peter.ujfalusi@ti.com>
References: <20181108073000.21114-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181108073000.21114-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, jarkko.nikula@bitmer.com
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Initializing to -EINVAL is not correct as the variables are unsigned and
if buffer_size is 0 then they are not used anyway.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 sound/soc/omap/omap-mcbsp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 8cab1151d3bb..e0ef4774c710 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -727,9 +727,6 @@ static int omap_mcbsp_init(struct platform_device *pdev)
 				"Unable to create additional controls\n");
 			goto err_thres;
 		}
-	} else {
-		mcbsp->max_tx_thres = -EINVAL;
-		mcbsp->max_rx_thres = -EINVAL;
 	}
 
 	ret = omap_mcbsp_st_init(pdev);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
