From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 5/9] mfd: Drop unnecessary static
Date: Thu,  4 May 2017 22:10:50 +0200
Message-ID: <1493928654-18768-6-git-send-email-Julia.Lawall@lip6.fr>
References: <1493928654-18768-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1493928654-18768-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: keescook@chromium.org, kernel-janitors@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Drop static on a local variable, when the variable is initialized before
any use, on every possible execution path through the function.

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

The change increases the code size but decreases the size of the bss segment.

before:
   text    data     bss     dec     hex filename
   3369     272     300    3941     f65 drivers/mfd/twl4030-irq.o

after:
   text    data     bss     dec     hex filename
   3401     272      28    3701     e75 drivers/mfd/twl4030-irq.o

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/mfd/twl4030-irq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index b46c0cf..c775f27 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -683,7 +683,7 @@ int twl4030_sih_setup(struct device *dev, int module, int irq_base)
 
 int twl4030_init_irq(struct device *dev, int irq_num)
 {
-	static struct irq_chip	twl4030_irq_chip;
+	struct irq_chip	twl4030_irq_chip;
 	int			status, i;
 	int			irq_base, irq_end, nr_irqs;
 	struct			device_node *node = dev->of_node;
