From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 2/3] pinctrl: single: remove misuse of IRQF_NO_SUSPEND flag
Date: Mon,  1 Feb 2016 18:28:18 +0000
Message-ID: <1454351299-27440-3-git-send-email-sudeep.holla@arm.com>
References: <1454351299-27440-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1454351299-27440-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Haojian Zhuang <haojian.zhuang@linaro.org>
List-Id: linux-omap@vger.kernel.org

From: Sudeep Holla <Sudeep.Holla@arm.com>

The IRQF_NO_SUSPEND flag is used to identify the interrupts that should
be left enabled so as to allow them to work as expected during the
suspend-resume cycle, but doesn't guarantee that it will wake the system
from a suspended state, enable_irq_wake is recommended to be used for
the wakeup.

This patch removes the use of IRQF_NO_SUSPEND flags replacing it with
irq_set_irq_wake instead.

Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/pinctrl/pinctrl-single.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index fb126d56ad40..03977a75a9e2 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1619,12 +1619,14 @@ static void pcs_irq_unmask(struct irq_data *d)
  */
 static int pcs_irq_set_wake(struct irq_data *d, unsigned int state)
 {
+	struct pcs_soc_data *pcs_soc = irq_data_get_irq_chip_data(d);
+
 	if (state)
 		pcs_irq_unmask(d);
 	else
 		pcs_irq_mask(d);
 
-	return 0;
+	return irq_set_irq_wake(pcs_soc->irq, state);
 }
 
 /**
@@ -1760,8 +1762,7 @@ static int pcs_irq_init_chained_handler(struct pcs_device *pcs,
 		int res;
 
 		res = request_irq(pcs_soc->irq, pcs_irq_handler,
-				  IRQF_SHARED | IRQF_NO_SUSPEND |
-				  IRQF_NO_THREAD,
+				  IRQF_SHARED | IRQF_NO_THREAD,
 				  name, pcs_soc);
 		if (res) {
 			pcs_soc->irq = -1;
-- 
1.9.1

