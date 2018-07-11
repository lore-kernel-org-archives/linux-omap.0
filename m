From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] pinctrl: single: Fix missing unlock on error path
Date: Wed, 11 Jul 2018 12:33:31 +0000
Message-ID: <1531312411-134133-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-omap@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add the missing unlock before return from function
in the error handling case.

Fixes: 0f5972033509 ("pinctrl: single: Fix group and function selector use")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/pinctrl/pinctrl-single.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 7dc680e..7ec72ff 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1071,8 +1071,8 @@ static int pcs_parse_one_pinctrl_entry(struct pcs_device *pcs,
 	*num_maps = 1;
 free_function:
 	pinmux_generic_remove_function(pcs->pctl, fsel);
-	mutex_unlock(&pcs->mutex);
 free_pins:
+	mutex_unlock(&pcs->mutex);
 	devm_kfree(pcs->dev, pins);
 
 free_vals:
@@ -1211,8 +1211,8 @@ static int pcs_parse_bits_in_pinctrl_entry(struct pcs_device *pcs,
 	*num_maps = 1;
 free_function:
 	pinmux_generic_remove_function(pcs->pctl, fsel);
-	mutex_unlock(&pcs->mutex);
 free_pins:
+	mutex_unlock(&pcs->mutex);
 	devm_kfree(pcs->dev, pins);
 
 free_vals:
