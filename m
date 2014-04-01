From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RESEND 2/3] mfd: twl6040: Move register patching earlier in probe
Date: Tue, 1 Apr 2014 16:45:00 +0300
Message-ID: <1396359901-32656-3-git-send-email-peter.ujfalusi@ti.com>
References: <1396359901-32656-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1396359901-32656-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, sameo@linux.intel.com, nm@ti.com
List-Id: linux-omap@vger.kernel.org

Make sure that we patch the ACCCTL register as the first thing when the
driver loads, thus configuring I2C fast mode and i2c access for dual access
registers.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mfd/twl6040.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index 2c308750f40f..dc5c05940e96 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -665,6 +665,9 @@ static int twl6040_probe(struct i2c_client *client,
 	mutex_init(&twl6040->mutex);
 	init_completion(&twl6040->ready);
 
+	regmap_register_patch(twl6040->regmap, twl6040_patch,
+			      ARRAY_SIZE(twl6040_patch));
+
 	twl6040->rev = twl6040_reg_read(twl6040, TWL6040_REG_ASICREV);
 	if (twl6040->rev < 0) {
 		dev_err(&client->dev, "Failed to read revision register: %d\n",
@@ -712,10 +715,6 @@ static int twl6040_probe(struct i2c_client *client,
 		goto readyirq_err;
 	}
 
-	/* dual-access registers controlled by I2C only */
-	regmap_register_patch(twl6040->regmap, twl6040_patch,
-			      ARRAY_SIZE(twl6040_patch));
-
 	/*
 	 * The main functionality of twl6040 to provide audio on OMAP4+ systems.
 	 * We can add the ASoC codec child whenever this driver has been loaded.
-- 
1.9.1
