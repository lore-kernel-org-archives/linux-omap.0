From: NeilBrown <neilb@suse.de>
Subject: [PATCH 2/4] twl4030-irq: use request_threaded_irq in place of
 irq_set_chained_handler.
Date: Sun, 27 Nov 2011 07:17:41 +1100
Message-ID: <20111126201741.16080.40954.stgit@notabene.brown>
References: <20111126201334.16080.85045.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111126201334.16080.85045.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, NeilBrown <neilb@suse.de>
List-Id: linux-omap@vger.kernel.org

irq_set_chained_handler sets 'desc->handle_irq'.
However this irq is called by handle_nested_irq from handle_twl4030_pih,
and that uses action->thread_fn.

So the handled set with irq_set_chained_handler is never called.

So change to use request_threaded_irq instead - that sets the correct field.

Tested on GTA04 Phoenux.

Signed-off-by: NeilBrown <neilb@suse.de>
---

 drivers/mfd/twl4030-irq.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index 3d3d6ed..29f11e0 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -432,6 +432,7 @@ struct sih_agent {
 	u32			edge_change;
 
 	struct mutex		irq_lock;
+	char			*irq_name;
 };
 
 /*----------------------------------------------------------------------*/
@@ -589,7 +590,7 @@ static inline int sih_read_isr(const struct sih *sih)
  * Generic handler for SIH interrupts ... we "know" this is called
  * in task context, with IRQs enabled.
  */
-static void handle_twl4030_sih(unsigned irq, struct irq_desc *desc)
+static irqreturn_t handle_twl4030_sih(int irq, void *data)
 {
 	struct sih_agent *agent = irq_get_handler_data(irq);
 	const struct sih *sih = agent->sih;
@@ -602,7 +603,7 @@ static void handle_twl4030_sih(unsigned irq, struct irq_desc *desc)
 		pr_err("twl4030: %s SIH, read ISR error %d\n",
 			sih->name, isr);
 		/* REVISIT:  recover; eventually mask it all, etc */
-		return;
+		return IRQ_HANDLED;
 	}
 
 	while (isr) {
@@ -616,6 +617,7 @@ static void handle_twl4030_sih(unsigned irq, struct irq_desc *desc)
 			pr_err("twl4030: %s SIH, invalid ISR bit %d\n",
 				sih->name, irq);
 	}
+	return IRQ_HANDLED;
 }
 
 static unsigned twl4030_irq_next;
@@ -668,18 +670,19 @@ int twl4030_sih_setup(int module)
 		activate_irq(irq);
 	}
 
-	status = irq_base;
 	twl4030_irq_next += i;
 
 	/* replace generic PIH handler (handle_simple_irq) */
 	irq = sih_mod + twl4030_irq_base;
 	irq_set_handler_data(irq, agent);
-	irq_set_chained_handler(irq, handle_twl4030_sih);
+	agent->irq_name = kasprintf(GFP_KERNEL, "twl4030_%s", sih->name);
+	status = request_threaded_irq(irq, NULL, handle_twl4030_sih, 0,
+				      agent->irq_name ?: sih->name, NULL);
 
 	pr_info("twl4030: %s (irq %d) chaining IRQs %d..%d\n", sih->name,
 			irq, irq_base, twl4030_irq_next - 1);
 
-	return status;
+	return status < 0 ? status : irq_base;
 }
 
 /* FIXME need a call to reverse twl4030_sih_setup() ... */
