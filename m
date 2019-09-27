From: Stephen Kitt <steve@sk2.org>
Subject: [PATCH v2] clk/ti/adpll: allocate room for terminating null
Date: Fri, 27 Sep 2019 20:05:59 +0200
Message-ID: <20190927180559.18162-1-steve@sk2.org>
References: <cec235b3e2e4e3b206fa9444b643fa56@sk2.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cec235b3e2e4e3b206fa9444b643fa56@sk2.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
List-Id: linux-omap@vger.kernel.org

The buffer allocated in ti_adpll_clk_get_name doesn't account for the
terminating null. This patch switches to ka_sprintf to avoid
overflowing.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 drivers/clk/ti/adpll.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/ti/adpll.c b/drivers/clk/ti/adpll.c
index fdfb90058504..021cf9e2b4db 100644
--- a/drivers/clk/ti/adpll.c
+++ b/drivers/clk/ti/adpll.c
@@ -195,14 +195,8 @@ static const char *ti_adpll_clk_get_name(struct ti_adpll_data *d,
 			return NULL;
 	} else {
 		const char *base_name = "adpll";
-		char *buf;
-
-		buf = devm_kzalloc(d->dev, 8 + 1 + strlen(base_name) + 1 +
-				    strlen(postfix), GFP_KERNEL);
-		if (!buf)
-			return NULL;
-		sprintf(buf, "%08lx.%s.%s", d->pa, base_name, postfix);
-		name = buf;
+		name = devm_kasprintf(d->dev, GFP_KERNEL, "%08lx.%s.%s",
+				      d->pa, base_name, postfix);
 	}
 
 	return name;
-- 
2.20.1
