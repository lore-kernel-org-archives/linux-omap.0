From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v6 10/18] MFD: twl6040: Change platform data
	for soc codec driver
Date: Tue, 21 Jun 2011 16:39:08 +0300
Message-ID: <1308663556-29120-11-git-send-email-peter.ujfalusi@ti.com>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Pass twl4030_codec_data instead of the twl4030_audio_data
for the ASoC codec driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mfd/twl6040-core.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/twl6040-core.c b/drivers/mfd/twl6040-core.c
index 195613c..b6e5338 100644
--- a/drivers/mfd/twl6040-core.c
+++ b/drivers/mfd/twl6040-core.c
@@ -507,9 +507,8 @@ static int __devinit twl6040_probe(struct platform_device *pdev)
 	if (pdata->codec) {
 		cell = &twl6040->cells[children];
 		cell->name = "twl6040-codec";
-		/* The codec expects the twl4030_audio_data as platform data */
-		cell->platform_data = pdata;
-		cell->pdata_size = sizeof(*pdata);
+		cell->platform_data = pdata->codec;
+		cell->pdata_size = sizeof(*pdata->codec);
 		children++;
 	}
 
-- 
1.7.5.3
