From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/3] ASoC: omap-mcbsp: Fix latency value
	calculation for pm_qos
Date: Wed, 14 Nov 2018 13:06:21 +0200
Message-ID: <20181114110623.30932-2-peter.ujfalusi@ti.com>
References: <20181114110623.30932-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181114110623.30932-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, jarkko.nikula@bitmer.com, tony@atomide.com
Cc: kernel@pyra-handheld.com, hns@goldelico.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, matt@ranostay.consulting
List-Id: linux-omap@vger.kernel.org

The latency number is in usec for the pm_qos. Correct the calculation to
give us the time in usec

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-mcbsp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index e0ef4774c710..a395598f1f20 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -999,9 +999,9 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 			pkt_size = channels;
 		}
 
-		latency = ((((buffer_size - pkt_size) / channels) * 1000)
-				 / (params->rate_num / params->rate_den));
-
+		latency = (buffer_size - pkt_size) / channels;
+		latency = latency * USEC_PER_SEC /
+			  (params->rate_num / params->rate_den);
 		mcbsp->latency[substream->stream] = latency;
 
 		omap_mcbsp_set_threshold(substream, pkt_size);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
