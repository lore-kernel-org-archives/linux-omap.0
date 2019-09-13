From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/6] hwrng: omap3-rom - Call clk_prepare() on init and exit only
Date: Fri, 13 Sep 2019 15:09:19 -0700
Message-ID: <20190913220922.29501-4-tony@atomide.com>
References: <20190913220922.29501-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190913220922.29501-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Adam Ford <aford173@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

When unloading omap3-rom-rng, we'll get the following:

WARNING: CPU: 0 PID: 100 at drivers/clk/clk.c:948 clk_core_disable

This is because the clock is already disabled by omap3_rom_rng_idle().

Also, we should not call prepare and unprepare except during init, and
only call enable and disable during use.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Adam Ford <aford173@gmail.com>
Cc: Pali Rohár <pali.rohar@gmail.com>
Cc: Tero Kristo <t-kristo@ti.com>
Fixes: 1c6b7c2108bd ("hwrng: OMAP3 ROM Random Number Generator support")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/char/hw_random/omap3-rom-rng.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/char/hw_random/omap3-rom-rng.c b/drivers/char/hw_random/omap3-rom-rng.c
--- a/drivers/char/hw_random/omap3-rom-rng.c
+++ b/drivers/char/hw_random/omap3-rom-rng.c
@@ -44,7 +44,7 @@ static void omap3_rom_rng_idle(struct work_struct *work)
 		pr_err("reset failed: %d\n", r);
 		return;
 	}
-	clk_disable_unprepare(rng_clk);
+	clk_disable(rng_clk);
 	rng_idle = 1;
 }
 
@@ -55,13 +55,13 @@ static int omap3_rom_rng_get_random(void *buf, unsigned int count)
 
 	cancel_delayed_work_sync(&idle_work);
 	if (rng_idle) {
-		r = clk_prepare_enable(rng_clk);
+		r = clk_enable(rng_clk);
 		if (r)
 			return r;
 
 		r = omap3_rom_rng_call(0, 0, RNG_GEN_PRNG_HW_INIT);
 		if (r != 0) {
-			clk_disable_unprepare(rng_clk);
+			clk_disable(rng_clk);
 			pr_err("HW init failed: %d\n", r);
 			return -EIO;
 		}
@@ -114,20 +114,32 @@ static int omap3_rom_rng_probe(struct platform_device *pdev)
 		return PTR_ERR(rng_clk);
 	}
 
+	ret = clk_prepare(rng_clk);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "clk_prepare failed: %i\n", ret);
+		return ret;
+	}
+
 	/* Leave the RNG in reset state. */
-	ret = clk_prepare_enable(rng_clk);
+	ret = clk_enable(rng_clk);
 	if (ret)
-		return ret;
+		goto err_unprepare;
 	omap3_rom_rng_idle(0);
 
 	return hwrng_register(&omap3_rom_rng_ops);
+
+err_unprepare:
+	clk_unprepare(rng_clk);
+
+	return ret;
 }
 
 static int omap3_rom_rng_remove(struct platform_device *pdev)
 {
 	cancel_delayed_work_sync(&idle_work);
 	hwrng_unregister(&omap3_rom_rng_ops);
-	clk_disable_unprepare(rng_clk);
+	clk_unprepare(rng_clk);
+
 	return 0;
 }
 
-- 
2.23.0
