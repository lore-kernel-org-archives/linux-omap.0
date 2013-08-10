From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 1/5] drivers/gpio/gpio-omap.c: convert comma to semicolon
Date: Sat, 10 Aug 2013 17:40:21 +0200
Message-ID: <1376149225-3997-2-git-send-email-Julia.Lawall@lip6.fr>
References: <1376149225-3997-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1376149225-3997-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: kernel-janitors@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Replace a comma between expression statements by a semicolon.

A simplified version of the semantic patch that performs this
transformation is as follows: (http://coccinelle.lip6.fr/)

// <smpl>
@r@
expression e1,e2,e;
type T;
identifier i;
@@

 e1
-,
+;
 e2;
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
I can't tell if the assignment to ct->regs.mask is really intended to be
under the if.  The proposed patch preserves the current semantics, but not
the current indentation.

 drivers/gpio/gpio-omap.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index dfeb3a3..db80880 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1029,10 +1029,10 @@ omap_mpuio_alloc_gc(struct gpio_bank *bank, unsigned int irq_start,
 	ct->chip.irq_unmask = irq_gc_mask_clr_bit;
 	ct->chip.irq_set_type = gpio_irq_type;
 
-	if (bank->regs->wkup_en)
-		ct->chip.irq_set_wake = gpio_wake_enable,
-
-	ct->regs.mask = OMAP_MPUIO_GPIO_INT / bank->stride;
+	if (bank->regs->wkup_en) {
+		ct->chip.irq_set_wake = gpio_wake_enable;
+		ct->regs.mask = OMAP_MPUIO_GPIO_INT / bank->stride;
+	}
 	irq_setup_generic_chip(gc, IRQ_MSK(num), IRQ_GC_INIT_MASK_CACHE,
 			       IRQ_NOREQUEST | IRQ_NOPROBE, 0);
 }

