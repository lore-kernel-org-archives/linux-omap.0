From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] pinctrl: single: Delete an error message for a failed
 memory allocation in pcs_probe()
Date: Mon, 25 Dec 2017 14:06:13 +0100
Message-ID: <bc8e7af9-6dcb-6f08-388a-31fc1b88cd00@users.sourceforge.net>
References: <6bc679d1-c1ee-52fe-9ece-b28095f653ec@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <6bc679d1-c1ee-52fe-9ece-b28095f653ec@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-gpio-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Haojian Zhuang <haojian.zhuang@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 25 Dec 2017 11:27:55 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/pinctrl/pinctrl-single.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index e6cd8de793e2..f5ff2111481d 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1646,10 +1646,9 @@ static int pcs_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	pcs = devm_kzalloc(&pdev->dev, sizeof(*pcs), GFP_KERNEL);
-	if (!pcs) {
-		dev_err(&pdev->dev, "could not allocate\n");
+	if (!pcs)
 		return -ENOMEM;
-	}
+
 	pcs->dev = &pdev->dev;
 	pcs->np = np;
 	raw_spin_lock_init(&pcs->lock);
-- 
2.15.1

