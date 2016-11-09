From: Axel Haslam <ahaslam@baylibre.com>
Subject: [PATCH v2 2/2] pinctrl: single: search for the bits property when parsing bits
Date: Wed,  9 Nov 2016 15:54:01 +0100
Message-ID: <20161109145401.25327-3-ahaslam@baylibre.com>
References: <20161109145401.25327-1-ahaslam@baylibre.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20161109145401.25327-1-ahaslam@baylibre.com>
Sender: linux-gpio-owner@vger.kernel.org
To: tony@atomide.com, haojian.zhuang@linaro.org, linus.walleij@linaro.org, khilman@baylibre.com, nsekhar@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Axel Haslam <ahaslam@baylibre.com>
List-Id: linux-omap@vger.kernel.org

The pcs_parse_bits_in_pinctrl_entry function should search
for the "pinctrl-single,bits" and not "pinctrl-single,pins"

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 drivers/pinctrl/pinctrl-single.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index f36a9f1..2b196e5 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1223,7 +1223,7 @@ static int pcs_parse_bits_in_pinctrl_entry(struct pcs_device *pcs,
 						unsigned *num_maps,
 						const char **pgnames)
 {
-	const char *name = "pinctrl-single,pins";
+	const char *name = "pinctrl-single,bits";
 	struct pcs_func_vals *vals;
 	int rows, *pins, found = 0, res = -ENOMEM, i;
 	int npins_in_row;
-- 
2.10.1

