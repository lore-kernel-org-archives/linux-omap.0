From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] clk/ti: Delete an error message for a failed memory
 allocation in two functions
Date: Wed, 27 Sep 2017 19:22:47 +0200
Message-ID: <120d01e4-5e58-e740-f6c7-c6835752aed3@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Tero Kristo <t-kristo@ti.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 27 Sep 2017 19:14:01 +0200

Omit extra messages for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/clk/ti/divider.c | 4 +---
 drivers/clk/ti/mux.c     | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/ti/divider.c b/drivers/clk/ti/divider.c
index 88f04a4cb890..77f93f6d2806 100644
--- a/drivers/clk/ti/divider.c
+++ b/drivers/clk/ti/divider.c
@@ -292,10 +292,8 @@ static struct clk *_register_divider(struct device *dev, const char *name,
 
 	/* allocate the divider */
 	div = kzalloc(sizeof(*div), GFP_KERNEL);
-	if (!div) {
-		pr_err("%s: could not allocate divider clk\n", __func__);
+	if (!div)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	init.name = name;
 	init.ops = &ti_clk_divider_ops;
diff --git a/drivers/clk/ti/mux.c b/drivers/clk/ti/mux.c
index 18c267b38461..d4705803f3d3 100644
--- a/drivers/clk/ti/mux.c
+++ b/drivers/clk/ti/mux.c
@@ -108,10 +108,8 @@ static struct clk *_register_mux(struct device *dev, const char *name,
 
 	/* allocate the mux */
 	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
-	if (!mux) {
-		pr_err("%s: could not allocate mux clk\n", __func__);
+	if (!mux)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	init.name = name;
 	init.ops = &ti_clk_mux_ops;
-- 
2.14.2
