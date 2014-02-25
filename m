From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 1/2] mfd: twl6040: Check for error when reading revision register
Date: Tue, 25 Feb 2014 14:28:19 +0100
Message-ID: <1393334900-29740-2-git-send-email-florian.vaussard@epfl.ch>
References: <1393334900-29740-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393334900-29740-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Florian Vaussard <florian.vaussard@epfl.ch>
List-Id: linux-omap@vger.kernel.org

We may have an error when reading the revision register, so check for
the returned value.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 drivers/mfd/twl6040.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index 32ce1ae..67e524e 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -661,6 +661,11 @@ static int twl6040_probe(struct i2c_client *client,
 	init_completion(&twl6040->ready);
 
 	twl6040->rev = twl6040_reg_read(twl6040, TWL6040_REG_ASICREV);
+	if (twl6040->rev < 0) {
+		dev_err(&client->dev, "Failed to read revision register: %d\n",
+			twl6040->rev);
+		goto gpio_err;
+	}
 
 	/* ERRATA: Automatic power-up is not possible in ES1.0 */
 	if (twl6040_get_revid(twl6040) > TWL6040_REV_ES1_0)
-- 
1.8.1.2
