From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 09/12] i2c: ocores: enable atomic xfers
Date: Wed,  3 Apr 2019 14:40:16 +0200
Message-ID: <20190403124019.8947-10-wsa+renesas@sang-engineering.com>
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Rosin <peda@axentia.se>, Stefan Lengfeld <contact@stefanchrist.eu>, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Andrew Lunn <andrew@lunn.ch>
List-Id: linux-omap@vger.kernel.org

The driver already has the routine in place, tie it to the new callback.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andrew Lunn <andrew@lunn.ch>
---
 drivers/i2c/busses/i2c-ocores.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 1b99f467aae0..c3dabee0aa35 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -442,6 +442,7 @@ static u32 ocores_func(struct i2c_adapter *adap)
 
 static struct i2c_algorithm ocores_algorithm = {
 	.master_xfer = ocores_xfer,
+	.master_xfer_atomic = ocores_xfer_polling,
 	.functionality = ocores_func,
 };
 
-- 
2.11.0
