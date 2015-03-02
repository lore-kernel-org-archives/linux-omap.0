From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 07/10] clk: s2mps11: use clkdev_create()
Date: Mon, 02 Mar 2015 17:06:37 +0000
Message-ID: <E1YSTnh-0001Jt-6G@rmk-PC.arm.linux.org.uk>
References: <20150302170538.GQ8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20150302170538.GQ8656@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-media-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

clkdev_create() is a shorter way to write clkdev_alloc() followed by
clkdev_add().  Use this instead.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/clk/clk-s2mps11.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/clk-s2mps11.c b/drivers/clk/clk-s2mps11.c
index bfa1e64e267d..9b13a303d3f8 100644
--- a/drivers/clk/clk-s2mps11.c
+++ b/drivers/clk/clk-s2mps11.c
@@ -242,14 +242,12 @@ static int s2mps11_clk_probe(struct platform_device *pdev)
 			goto err_reg;
 		}
 
-		s2mps11_clk->lookup = clkdev_alloc(s2mps11_clk->clk,
+		s2mps11_clk->lookup = clkdev_create(s2mps11_clk->clk,
 					s2mps11_name(s2mps11_clk), NULL);
 		if (!s2mps11_clk->lookup) {
 			ret = -ENOMEM;
 			goto err_lup;
 		}
-
-		clkdev_add(s2mps11_clk->lookup);
 	}
 
 	for (i = 0; i < S2MPS11_CLKS_NUM; i++) {
-- 
1.8.3.1
