From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2]  pinctrl: pinctrl-single: Fix pcs_parse_bits_in_pinctrl_entry to use __ffs than ffs
Date: Thu, 14 Apr 2016 10:29:16 +0530
Message-ID: <1460609956-26539-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: tony@atomide.com
Cc: linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, j-keerthy@ti.com, t-kristo@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

pcs_parse_bits_in_pinctrl_entry uses ffs which gives bit indices
ranging from 1 to MAX. This leads to a corner case where we try to request
the pin number = MAX and fails.

bit_pos value is being calculted using ffs. pin_num_from_lsb uses
bit_pos value. pins array is populated with:

pin + pin_num_from_lsb.

The above is 1 more than usual bit indices as bit_pos uses ffs to compute
first set bit. Hence the last of the pins array is populated with the MAX
value and not MAX - 1 which causes error when we call pin_request.

mask_pos is rightly calculated as ((pcs->fmask) << (bit_pos - 1))
Consequently val_pos and submask are correct.

Hence use __ffs which gives (ffs(x) - 1) as the first bit set.

fixes: 4e7e8017a8 ("pinctrl: pinctrl-single: enhance to configure multiple pins of different modules")
Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v2:

  * Changed pcs->fshift to use __ffs instead of ffs to be consistent.

Boot tesed on da850-evm and checked the pinctrl sysfs nodes.

 drivers/pinctrl/pinctrl-single.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index fb126d5..cf9bafa 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1280,9 +1280,9 @@ static int pcs_parse_bits_in_pinctrl_entry(struct pcs_device *pcs,
 
 		/* Parse pins in each row from LSB */
 		while (mask) {
-			bit_pos = ffs(mask);
+			bit_pos = __ffs(mask);
 			pin_num_from_lsb = bit_pos / pcs->bits_per_pin;
-			mask_pos = ((pcs->fmask) << (bit_pos - 1));
+			mask_pos = ((pcs->fmask) << bit_pos);
 			val_pos = val & mask_pos;
 			submask = mask & mask_pos;
 
@@ -1852,7 +1852,7 @@ static int pcs_probe(struct platform_device *pdev)
 	ret = of_property_read_u32(np, "pinctrl-single,function-mask",
 				   &pcs->fmask);
 	if (!ret) {
-		pcs->fshift = ffs(pcs->fmask) - 1;
+		pcs->fshift = __ffs(pcs->fmask);
 		pcs->fmax = pcs->fmask >> pcs->fshift;
 	} else {
 		/* If mask property doesn't exist, function mux is invalid. */
-- 
1.9.1

