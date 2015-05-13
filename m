From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFT PATCH 1/8] clk: ti: dra7-atl-clock: Fix possible ERR_PTR
 dereference
Date: Wed, 13 May 2015 15:54:40 +0900
Message-ID: <1431500087-2275-2-git-send-email-k.kozlowski@samsung.com>
References: <1431500087-2275-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1431500087-2275-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

of_clk_get_from_provider() returns ERR_PTR on failure. The
dra7-atl-clock driver was not checking its return value and immediately
used it in __clk_get_hw().  __clk_get_hw() dereferences supplied clock,
if it is not NULL, so in that case it would dereference an ERR_PTR.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: <stable@vger.kernel.org>
Fixes: 9ac33b0ce81f ("CLK: TI: Driver for DRA7 ATL (Audio Tracking Logic)")
---
 drivers/clk/ti/clk-dra7-atl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/ti/clk-dra7-atl.c b/drivers/clk/ti/clk-dra7-atl.c
index d86bc46b93bd..0a1df821860f 100644
--- a/drivers/clk/ti/clk-dra7-atl.c
+++ b/drivers/clk/ti/clk-dra7-atl.c
@@ -252,6 +252,11 @@ static int of_dra7_atl_clk_probe(struct platform_device *pdev)
 		}
 
 		clk = of_clk_get_from_provider(&clkspec);
+		if (IS_ERR(clk)) {
+			pr_err("%s: failed to get atl clock %d from provider\n",
+			       __func__, i);
+			return PTR_ERR(clk);
+		}
 
 		cdesc = to_atl_desc(__clk_get_hw(clk));
 		cdesc->cinfo = cinfo;
-- 
1.9.1
