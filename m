From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 6/8] MFD: twl6040: Change platform data for soc codec driver
Date: Wed, 1 Jun 2011 14:17:29 +0300
Message-ID: <1306927051-8937-7-git-send-email-peter.ujfalusi@ti.com>
References: <1306927051-8937-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1306927051-8937-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@>
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

Pass twl4030_codec_data instead of the twl4030_audio_data
for the ASoC codec driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mfd/twl6040-core.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/twl6040-core.c b/drivers/mfd/twl6040-core.c
index bb36862..bc0ee41 100644
--- a/drivers/mfd/twl6040-core.c
+++ b/drivers/mfd/twl6040-core.c
@@ -494,9 +494,8 @@ static int __devinit twl6040_probe(struct platform_device *pdev)
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
