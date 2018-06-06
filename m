From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] pinctrl: pinctrl-single: add allocation failure checking of saved_vals
Date: Wed,  6 Jun 2018 14:43:38 +0100
Message-ID: <20180606134338.4645-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently saved_vals is being allocated and there is no check for
failed allocation (which is more likely than normal when using
GFP_ATOMIC).  Fix this by checking for a failed allocation and
propagating this error return down the the caller chain.

Detected by CoverityScan, CID#1469841 ("Dereference null return value")

Fixes: 88a1dbdec682 ("pinctrl: pinctrl-single: Add functions to save and restore pinctrl context")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pinctrl/pinctrl-single.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 9c3c00515aa0..0905ee002041 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1588,8 +1588,11 @@ static int pcs_save_context(struct pcs_device *pcs)
 
 	mux_bytes = pcs->width / BITS_PER_BYTE;
 
-	if (!pcs->saved_vals)
+	if (!pcs->saved_vals) {
 		pcs->saved_vals = devm_kzalloc(pcs->dev, pcs->size, GFP_ATOMIC);
+		if (!pcs->saved_vals)
+			return -ENOMEM;
+	}
 
 	switch (pcs->width) {
 	case 64:
@@ -1649,8 +1652,13 @@ static int pinctrl_single_suspend(struct platform_device *pdev,
 	if (!pcs)
 		return -EINVAL;
 
-	if (pcs->flags & PCS_CONTEXT_LOSS_OFF)
-		pcs_save_context(pcs);
+	if (pcs->flags & PCS_CONTEXT_LOSS_OFF) {
+		int ret;
+
+		ret = pcs_save_context(pcs);
+		if (ret < 0)
+			return ret;
+	}
 
 	return pinctrl_force_sleep(pcs->pctl);
 }
-- 
2.17.0
