From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFT PATCH 4/8] clk: ti: clk-33xx: Prevent possible ERR_PTR dereference
Date: Wed, 13 May 2015 15:54:43 +0900
Message-ID: <1431500087-2275-5-git-send-email-k.kozlowski@samsung.com>
References: <1431500087-2275-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:43146 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753781AbbEMGzI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 May 2015 02:55:08 -0400
In-reply-to: <1431500087-2275-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>

The return value of clk_get_sys() was immediately used in
clk_set_parent(). The first one may return ERR_PTR and the latter only
checks if supplied argument is non-NULL.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/ti/clk-33xx.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/ti/clk-33xx.c b/drivers/clk/ti/clk-33xx.c
index 028b33783d38..c08db8944fb8 100644
--- a/drivers/clk/ti/clk-33xx.c
+++ b/drivers/clk/ti/clk-33xx.c
@@ -141,10 +141,12 @@ int __init am33xx_dt_clk_init(void)
 
 	clk1 = clk_get_sys(NULL, "sys_clkin_ck");
 	clk2 = clk_get_sys(NULL, "timer3_fck");
-	clk_set_parent(clk2, clk1);
+	if (!IS_ERR(clk1) && !IS_ERR(clk2))
+		clk_set_parent(clk2, clk1);
 
 	clk2 = clk_get_sys(NULL, "timer6_fck");
-	clk_set_parent(clk2, clk1);
+	if (!IS_ERR(clk1) && !IS_ERR(clk2))
+		clk_set_parent(clk2, clk1);
 	/*
 	 * The On-Chip 32K RC Osc clock is not an accurate clock-source as per
 	 * the design/spec, so as a result, for example, timer which supposed
@@ -154,7 +156,8 @@ int __init am33xx_dt_clk_init(void)
 	 */
 	clk1 = clk_get_sys(NULL, "wdt1_fck");
 	clk2 = clk_get_sys(NULL, "clkdiv32k_ick");
-	clk_set_parent(clk1, clk2);
+	if (!IS_ERR(clk1) && !IS_ERR(clk2))
+		clk_set_parent(clk1, clk2);
 
 	return 0;
 }
-- 
1.9.1

