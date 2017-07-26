From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] clk: ti: check for null return in strrchr to avoid null dereferencing
Date: Thu, 27 Jul 2017 00:56:27 +0100
Message-ID: <20170726235627.9163-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

strrchr can potentially return a null so the following strlen on the
null pointer can cause a null dereference. Add a check to see if
the string postfix is not null before calling strlen.

Detected by CoverityScan, CID#1452039 ("Dereference null return")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/clk/ti/adpll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ti/adpll.c b/drivers/clk/ti/adpll.c
index 255cafb18336..bd7cb9a413c9 100644
--- a/drivers/clk/ti/adpll.c
+++ b/drivers/clk/ti/adpll.c
@@ -222,7 +222,7 @@ static int ti_adpll_setup_clock(struct ti_adpll_data *d, struct clk *clock,
 
 	/* Separate con_id in format "pll040dcoclkldo" to fit MAX_CON_ID */
 	postfix = strrchr(name, '.');
-	if (strlen(postfix) > 1) {
+	if (postfix && strlen(postfix) > 1) {
 		if (strlen(postfix) > ADPLL_MAX_CON_ID)
 			dev_warn(d->dev, "clock %s con_id lookup may fail\n",
 				 name);
-- 
2.11.0

