From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] pinctrl: single: Fix a couple error codes
Date: Wed, 16 Nov 2016 14:41:51 +0300
Message-ID: <20161116114151.GA31224@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

We should return -ENOMEM instead of success if pcs_add_function() fails.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 2b196e5..a5a0392 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1181,8 +1181,10 @@ static int pcs_parse_one_pinctrl_entry(struct pcs_device *pcs,
 
 	pgnames[0] = np->name;
 	function = pcs_add_function(pcs, np, np->name, vals, found, pgnames, 1);
-	if (!function)
+	if (!function) {
+		res = -ENOMEM;
 		goto free_pins;
+	}
 
 	res = pcs_add_pingroup(pcs, np, np->name, pins, found);
 	if (res < 0)
@@ -1313,8 +1315,10 @@ static int pcs_parse_bits_in_pinctrl_entry(struct pcs_device *pcs,
 
 	pgnames[0] = np->name;
 	function = pcs_add_function(pcs, np, np->name, vals, found, pgnames, 1);
-	if (!function)
+	if (!function) {
+		res = -ENOMEM;
 		goto free_pins;
+	}
 
 	res = pcs_add_pingroup(pcs, np, np->name, pins, found);
 	if (res < 0)
