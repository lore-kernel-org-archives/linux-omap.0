From: Axel Haslam <ahaslam@baylibre.com>
Subject: [PATCH v2 1/2] pinctrl: single: check for any error when getting rows
Date: Wed,  9 Nov 2016 15:54:00 +0100
Message-ID: <20161109145401.25327-2-ahaslam@baylibre.com>
References: <20161109145401.25327-1-ahaslam@baylibre.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20161109145401.25327-1-ahaslam@baylibre.com>
Sender: linux-gpio-owner@vger.kernel.org
To: tony@atomide.com, haojian.zhuang@linaro.org, linus.walleij@linaro.org, khilman@baylibre.com, nsekhar@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Axel Haslam <ahaslam@baylibre.com>
List-Id: linux-omap@vger.kernel.org

pinctrl_count_index_with_args returns -ENOENT not
-EINVAL. The return check would pass, and we would
try to kzalloc with a negative error size throwing
a warning.

Instead of checking for -EINVAL specifically, lets
check for any error and avoid negative size allocations.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 drivers/pinctrl/pinctrl-single.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 539f31c..f36a9f1 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1133,8 +1133,10 @@ static int pcs_parse_one_pinctrl_entry(struct pcs_device *pcs,
 	struct pcs_function *function;
 
 	rows = pinctrl_count_index_with_args(np, name);
-	if (rows == -EINVAL)
-		return rows;
+	if (rows <= 0) {
+		dev_err(pcs->dev, "Ivalid number of rows: %d\n", rows);
+		return -EINVAL;
+	}
 
 	vals = devm_kzalloc(pcs->dev, sizeof(*vals) * rows, GFP_KERNEL);
 	if (!vals)
@@ -1228,8 +1230,10 @@ static int pcs_parse_bits_in_pinctrl_entry(struct pcs_device *pcs,
 	struct pcs_function *function;
 
 	rows = pinctrl_count_index_with_args(np, name);
-	if (rows == -EINVAL)
-		return rows;
+	if (rows <= 0) {
+		dev_err(pcs->dev, "Invalid number of rows: %d\n", rows);
+		return -EINVAL;
+	}
 
 	npins_in_row = pcs->width / pcs->bits_per_pin;
 
-- 
2.10.1

