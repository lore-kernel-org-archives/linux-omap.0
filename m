From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 07/11] mfd: Drop unnecessary static
Date: Sat, 15 Jul 2017 22:07:42 +0200
Message-ID: <1500149266-32357-8-git-send-email-Julia.Lawall@lip6.fr>
References: <1500149266-32357-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500149266-32357-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: keescook@chromium.org, kernel-janitors@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Drop static on a local variable, when the variable is initialized before
any possible use.  Thus, the static has no benefit.

The semantic patch that fixes this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@bad exists@
position p;
identifier x;
type T;
@@
static T x@p;
...
x = <+...x...+>

@@
identifier x;
expression e;
type T;
position p != bad.p;
@@
-static
 T x@p;
 ... when != x
     when strict
?x = e;
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
These patches are all independent of each other.

 drivers/mfd/twl4030-irq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -u -p a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -685,7 +685,7 @@ int twl4030_sih_setup(struct device *dev
 
 int twl4030_init_irq(struct device *dev, int irq_num)
 {
-	static struct irq_chip	twl4030_irq_chip;
+	struct irq_chip		twl4030_irq_chip;
 	int			status, i;
 	int			irq_base, irq_end, nr_irqs;
 	struct			device_node *node = dev->of_node;
