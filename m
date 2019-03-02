From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH v2 4/7] i2c: demux: WIP: handle the new atomic callbacks
Date: Sat,  2 Mar 2019 14:47:32 +0100
Message-ID: <20190302134735.4393-5-wsa+renesas@sang-engineering.com>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
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
Cc: Tero Kristo <t-kristo@ti.com>, Phil Reid <preid@electromag.com.au>, Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org, Stefan Lengfeld <contact@stefanchrist.eu>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Peter Rosin <peda@axentia.se>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

If the parent has an atomic callback, we need to translate it the same
way as the non-atomic callback.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/muxes/i2c-demux-pinctrl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
index 035032e20327..5d00adfbe578 100644
--- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -99,6 +99,9 @@ static int i2c_demux_activate_master(struct i2c_demux_pinctrl_priv *priv, u32 ne
 
 	/* Now fill out current adapter structure. cur_chan must be up to date */
 	priv->algo.master_xfer = i2c_demux_master_xfer;
+	/* FIXME: regular muxes need proper handling, too! */
+	if (adap->algo->master_xfer_atomic)
+		priv->algo.master_xfer_atomic = i2c_demux_master_xfer;
 	priv->algo.functionality = i2c_demux_functionality;
 
 	snprintf(priv->cur_adap.name, sizeof(priv->cur_adap.name),
-- 
2.11.0
