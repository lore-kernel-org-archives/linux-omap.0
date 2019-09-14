From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/7] hwrng: omap3-rom - Call clk_disable_unprepare() on exit only if not idled
Date: Sat, 14 Sep 2019 14:02:56 -0700
Message-ID: <20190914210300.15836-4-tony@atomide.com>
References: <20190914210300.15836-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190914210300.15836-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Adam Ford <aford173@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

When unloading omap3-rom-rng, we'll get the following:

WARNING: CPU: 0 PID: 100 at drivers/clk/clk.c:948 clk_core_disable

This is because the clock may be already disabled by omap3_rom_rng_idle().
Let's fix the issue by checking for rng_idle on exit.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Adam Ford <aford173@gmail.com>
Cc: Pali Rohár <pali.rohar@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Tero Kristo <t-kristo@ti.com>
Fixes: 1c6b7c2108bd ("hwrng: OMAP3 ROM Random Number Generator support")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/char/hw_random/omap3-rom-rng.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/omap3-rom-rng.c b/drivers/char/hw_random/omap3-rom-rng.c
--- a/drivers/char/hw_random/omap3-rom-rng.c
+++ b/drivers/char/hw_random/omap3-rom-rng.c
@@ -127,7 +127,8 @@ static int omap3_rom_rng_remove(struct platform_device *pdev)
 {
 	cancel_delayed_work_sync(&idle_work);
 	hwrng_unregister(&omap3_rom_rng_ops);
-	clk_disable_unprepare(rng_clk);
+	if (!rng_idle)
+		clk_disable_unprepare(rng_clk);
 	return 0;
 }
 
-- 
2.23.0
