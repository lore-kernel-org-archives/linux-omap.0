From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 28/69] ASoC: omap-mcbsp: Fix latency value calculation for pm_qos
Date: Wed,  5 Dec 2018 04:42:06 -0500
Message-ID: <20181205094247.6556-28-sashal@kernel.org>
References: <20181205094247.6556-1-sashal@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181205094247.6556-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

[ Upstream commit dd2f52d8991af9fe0928d59ec502ba52be7bc38d ]

The latency number is in usec for the pm_qos. Correct the calculation to
give us the time in usec

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/omap/omap-mcbsp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 6b40bdbef336..47c2ed5ca492 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -308,9 +308,9 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
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
2.17.1
