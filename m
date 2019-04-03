From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 04/12] i2c: mux: populate the new *_atomic callbacks
Date: Wed,  3 Apr 2019 14:40:11 +0200
Message-ID: <20190403124019.8947-5-wsa+renesas@sang-engineering.com>
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-tegra@vger.kernel.org, Stefan Lengfeld <contact@stefanchrist.eu>, linux-omap@vger.kernel.org, Peter Rosin <peda@axentia.se>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

If the parent adapter has atomic_xfer callbacks, populate them for the
mux adapter as well. We can use the same translation function as for the
non-atomic xfer callback.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-mux.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index f330690b4125..603252fa1284 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -310,12 +310,18 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 		else
 			priv->algo.master_xfer = __i2c_mux_master_xfer;
 	}
+	if (parent->algo->master_xfer_atomic)
+		priv->algo.master_xfer_atomic = priv->algo.master_xfer;
+
 	if (parent->algo->smbus_xfer) {
 		if (muxc->mux_locked)
 			priv->algo.smbus_xfer = i2c_mux_smbus_xfer;
 		else
 			priv->algo.smbus_xfer = __i2c_mux_smbus_xfer;
 	}
+	if (parent->algo->smbus_xfer_atomic)
+		priv->algo.smbus_xfer_atomic = priv->algo.smbus_xfer;
+
 	priv->algo.functionality = i2c_mux_functionality;
 
 	/* Now fill out new adapter structure */
-- 
2.11.0
