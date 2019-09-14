From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/7] hwrng: omap3-rom - Initialize default quality to get data
Date: Sat, 14 Sep 2019 14:02:57 -0700
Message-ID: <20190914210300.15836-5-tony@atomide.com>
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

Similar to commit 62f95ae805fa ("hwrng: omap - Set default quality")
we need to initialize the default quality for the RNG to be used.

The symptoms of this problem is that doing hd /dev/random does not
produce much data at all.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Adam Ford <aford173@gmail.com>
Cc: Pali Rohár <pali.rohar@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/char/hw_random/omap3-rom-rng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/hw_random/omap3-rom-rng.c b/drivers/char/hw_random/omap3-rom-rng.c
--- a/drivers/char/hw_random/omap3-rom-rng.c
+++ b/drivers/char/hw_random/omap3-rom-rng.c
@@ -88,6 +88,7 @@ static int omap3_rom_rng_read(struct hwrng *rng, void *data, size_t max, bool w)
 
 static struct hwrng omap3_rom_rng_ops = {
 	.name		= "omap3-rom",
+	.quality	= 900,
 };
 
 static int omap3_rom_rng_probe(struct platform_device *pdev)
-- 
2.23.0
