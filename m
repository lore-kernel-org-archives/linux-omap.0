From: Colin King <colin.king@canonical.com>
Subject: [PATCH] pinctrl: single: fix spelling mistakes on "Ivalid"
Date: Fri, 23 Dec 2016 00:47:14 +0000
Message-ID: <20161223004714.7491-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fixe to spelling mistake "Ivalid" to "Invalid" in
dev_err  error message.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pinctrl/pinctrl-single.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index a5a0392..25edadf 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1134,7 +1134,7 @@ static int pcs_parse_one_pinctrl_entry(struct pcs_device *pcs,
 
 	rows = pinctrl_count_index_with_args(np, name);
 	if (rows <= 0) {
-		dev_err(pcs->dev, "Ivalid number of rows: %d\n", rows);
+		dev_err(pcs->dev, "Invalid number of rows: %d\n", rows);
 		return -EINVAL;
 	}
 
-- 
2.10.2

