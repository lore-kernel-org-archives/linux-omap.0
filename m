From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 2/2] mfd: twl6040: Remove duplicate register write
Date: Tue, 25 Feb 2014 14:28:20 +0100
Message-ID: <1393334900-29740-3-git-send-email-florian.vaussard@epfl.ch>
References: <1393334900-29740-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393334900-29740-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Florian Vaussard <florian.vaussard@epfl.ch>
List-Id: linux-omap@vger.kernel.org

When probing, regmap_register_patch() will bypass the cache and perform
i2c writes for the given patches. It is thus unnecessary to manually set
the TWL6040_REG_ACCCTL register just before, as it will be done when
registering the twl6040_patch.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 drivers/mfd/twl6040.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index 67e524e..0bd5a18 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -710,7 +710,6 @@ static int twl6040_probe(struct i2c_client *client,
 	}
 
 	/* dual-access registers controlled by I2C only */
-	twl6040_set_bits(twl6040, TWL6040_REG_ACCCTL, TWL6040_I2CSEL);
 	regmap_register_patch(twl6040->regmap, twl6040_patch,
 			      ARRAY_SIZE(twl6040_patch));
 
-- 
1.8.1.2
