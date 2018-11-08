From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 7/8] ASoC: omap-mcbsp: Remove redundant
	check for mcbsp->pdata
Date: Thu, 8 Nov 2018 09:29:59 +0200
Message-ID: <20181108073000.21114-8-peter.ujfalusi@ti.com>
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

The driver will not probe if the pdata is not provided or created.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 sound/soc/omap/omap-mcbsp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index e48fad11a0cc..8cab1151d3bb 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -324,7 +324,7 @@ static int omap_mcbsp_request(struct omap_mcbsp *mcbsp)
 	mcbsp->reg_cache = reg_cache;
 	spin_unlock(&mcbsp->lock);
 
-	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->request)
+	if(mcbsp->pdata->ops && mcbsp->pdata->ops->request)
 		mcbsp->pdata->ops->request(mcbsp->id - 1);
 
 	/*
@@ -361,7 +361,7 @@ static int omap_mcbsp_request(struct omap_mcbsp *mcbsp)
 err_free_irq:
 	free_irq(mcbsp->tx_irq, (void *)mcbsp);
 err_clk_disable:
-	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->free)
+	if(mcbsp->pdata->ops && mcbsp->pdata->ops->free)
 		mcbsp->pdata->ops->free(mcbsp->id - 1);
 
 	/* Disable wakeup behavior */
@@ -382,7 +382,7 @@ static void omap_mcbsp_free(struct omap_mcbsp *mcbsp)
 {
 	void *reg_cache;
 
-	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->free)
+	if(mcbsp->pdata->ops && mcbsp->pdata->ops->free)
 		mcbsp->pdata->ops->free(mcbsp->id - 1);
 
 	/* Disable wakeup behavior */
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
