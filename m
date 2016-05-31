From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] pinctrl: single: Fix missing flush of posted write for a wakeirq
Date: Tue, 31 May 2016 14:17:06 -0700
Message-ID: <1464729426-11187-1-git-send-email-tony@atomide.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

With many repeated suspend resume cycles, the pin specific wakeirq
may not always work on omaps. This is because the write to enable the
pin interrupt may not have reached the device over the interconnect
before suspend happens.

Let's fix the issue with a flush of posted write with a readback.

Reported-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/pinctrl/pinctrl-single.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index cf9bafa..bfdf720 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1580,6 +1580,9 @@ static inline void pcs_irq_set(struct pcs_soc_data *pcs_soc,
 		else
 			mask &= ~soc_mask;
 		pcs->write(mask, pcswi->reg);
+
+		/* flush posted write */
+		mask = pcs->read(pcswi->reg);
 		raw_spin_unlock(&pcs->lock);
 	}
 
-- 
2.8.1

