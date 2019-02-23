From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 19/72] clk: ti: Fix error handling in ti_clk_parse_divider_data()
Date: Sat, 23 Feb 2019 16:03:29 -0500
Message-ID: <20190223210422.199966-19-sashal@kernel.org>
References: <20190223210422.199966-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190223210422.199966-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Stephen Boyd <sboyd@kernel.org>, Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 303aef8b84272d73999a3207dd05bbe10ed89dc5 ]

The ti_clk_parse_divider_data() function is only called from
_get_div_table_from_setup().  That function doesn't look at the return
value but instead looks at the "*table" pointer.  In this case, if the
kcalloc() fails then *table is NULL (which means success).  It should
instead be an error pointer.

The ti_clk_parse_divider_data() function has two callers.  One checks
for errors and the other doesn't.  I have fixed it so now both handle
errors.

Fixes: 4f6be5655dc9 ("clk: ti: divider: add driver internal API for parsing divider data")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/ti/divider.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ti/divider.c b/drivers/clk/ti/divider.c
index 8d77090ad94ae..0241450f3eb3c 100644
--- a/drivers/clk/ti/divider.c
+++ b/drivers/clk/ti/divider.c
@@ -403,8 +403,10 @@ int ti_clk_parse_divider_data(int *div_table, int num_dividers, int max_div,
 	num_dividers = i;
 
 	tmp = kcalloc(valid_div + 1, sizeof(*tmp), GFP_KERNEL);
-	if (!tmp)
+	if (!tmp) {
+		*table = ERR_PTR(-ENOMEM);
 		return -ENOMEM;
+	}
 
 	valid_div = 0;
 	*width = 0;
@@ -439,6 +441,7 @@ struct clk_hw *ti_clk_build_component_div(struct ti_clk_divider *setup)
 {
 	struct clk_omap_divider *div;
 	struct clk_omap_reg *reg;
+	int ret;
 
 	if (!setup)
 		return NULL;
@@ -458,6 +461,12 @@ struct clk_hw *ti_clk_build_component_div(struct ti_clk_divider *setup)
 		div->flags |= CLK_DIVIDER_POWER_OF_TWO;
 
 	div->table = _get_div_table_from_setup(setup, &div->width);
+	if (IS_ERR(div->table)) {
+		ret = PTR_ERR(div->table);
+		kfree(div);
+		return ERR_PTR(ret);
+	}
+
 
 	div->shift = setup->bit_shift;
 	div->latch = -EINVAL;
-- 
2.19.1
