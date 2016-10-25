From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/4] pinctrl: single: Use generic parser and #pinctrl-cells for pinctrl-single,bits
Date: Tue, 25 Oct 2016 09:45:37 -0700
Message-ID: <20161025164538.453-4-tony@atomide.com>
References: <20161025164538.453-1-tony@atomide.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20161025164538.453-1-tony@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jon Hunter <jonathanh@nvidia.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

We can now use generic parser and keep things compatible with the
old binding.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/pinctrl/pinctrl-single.c | 50 +++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -35,7 +35,6 @@
 #include "pinconf.h"
 
 #define DRIVER_NAME			"pinctrl-single"
-#define PCS_MUX_BITS_NAME		"pinctrl-single,bits"
 #define PCS_OFF_DISABLED		~0U
 
 /**
@@ -1217,36 +1216,23 @@ static int pcs_parse_one_pinctrl_entry(struct pcs_device *pcs,
 	return res;
 }
 
-#define PARAMS_FOR_BITS_PER_MUX 3
-
 static int pcs_parse_bits_in_pinctrl_entry(struct pcs_device *pcs,
 						struct device_node *np,
 						struct pinctrl_map **map,
 						unsigned *num_maps,
 						const char **pgnames)
 {
+	const char *name = "pinctrl-single,pins";
+	const char *pinctrl_cells = "#pinctrl-cells";
 	struct pcs_func_vals *vals;
-	const __be32 *mux;
-	int size, rows, *pins, index = 0, found = 0, res = -ENOMEM;
+	int rows, *pins, found = 0, res = -ENOMEM, i;
 	int npins_in_row;
 	struct pcs_function *function;
 
-	mux = of_get_property(np, PCS_MUX_BITS_NAME, &size);
-
-	if (!mux) {
-		dev_err(pcs->dev, "no valid property for %s\n", np->name);
-		return -EINVAL;
-	}
-
-	if (size < (sizeof(*mux) * PARAMS_FOR_BITS_PER_MUX)) {
-		dev_err(pcs->dev, "bad data for %s\n", np->name);
-		return -EINVAL;
-	}
-
-	/* Number of elements in array */
-	size /= sizeof(*mux);
+	rows = pinctrl_count_index_with_args(np, name, pinctrl_cells);
+	if (rows == -EINVAL)
+		return rows;
 
-	rows = size / PARAMS_FOR_BITS_PER_MUX;
 	npins_in_row = pcs->width / pcs->bits_per_pin;
 
 	vals = devm_kzalloc(pcs->dev, sizeof(*vals) * rows * npins_in_row,
@@ -1259,15 +1245,31 @@ static int pcs_parse_bits_in_pinctrl_entry(struct pcs_device *pcs,
 	if (!pins)
 		goto free_vals;
 
-	while (index < size) {
+	for (i = 0; i < rows; i++) {
+		struct of_phandle_args pinctrl_spec;
 		unsigned offset, val;
 		unsigned mask, bit_pos, val_pos, mask_pos, submask;
 		unsigned pin_num_from_lsb;
 		int pin;
 
-		offset = be32_to_cpup(mux + index++);
-		val = be32_to_cpup(mux + index++);
-		mask = be32_to_cpup(mux + index++);
+		res = pinctrl_parse_index_with_args(np, name, pinctrl_cells,
+						    i, &pinctrl_spec);
+		if (res)
+			return res;
+
+		if (pinctrl_spec.args_count < 3) {
+			dev_err(pcs->dev, "invalid args_count for spec: %i\n",
+				pinctrl_spec.args_count);
+			break;
+		}
+
+		/* Index plus two value cells */
+		offset = pinctrl_spec.args[0];
+		val = pinctrl_spec.args[1];
+		mask = pinctrl_spec.args[2];
+
+		dev_dbg(pcs->dev, "%s index: 0x%x value: 0x%x mask: 0x%x\n",
+			pinctrl_spec.np->name, offset, val, mask);
 
 		/* Parse pins in each row from LSB */
 		while (mask) {
-- 
2.9.3
