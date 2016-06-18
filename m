From: Sebastian Reichel <sre@kernel.org>
Subject: [RFC 06/19] HSI: omap_ssi: convert cawake irq handler to thread
Date: Sat, 18 Jun 2016 18:26:56 +0200
Message-ID: <1466267229-25012-7-git-send-email-sre@kernel.org>
References: <1466267229-25012-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466267229-25012-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

Convert cawake interrupt handler from tasklet to
threaded interrupt handler in preparation of
blocking runtime_pm calls.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/hsi/controllers/omap_ssi.h      |  2 --
 drivers/hsi/controllers/omap_ssi_core.c |  4 ++--
 drivers/hsi/controllers/omap_ssi_port.c | 21 ++++++---------------
 3 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/hsi/controllers/omap_ssi.h b/drivers/hsi/controllers/omap_ssi.h
index ba2f92722c09..88a523902a8f 100644
--- a/drivers/hsi/controllers/omap_ssi.h
+++ b/drivers/hsi/controllers/omap_ssi.h
@@ -75,7 +75,6 @@ struct omap_ssm_ctx {
  * @wake_irq: IRQ number for incoming wake line (-1 if none)
  * @wake_gpio: GPIO number for incoming wake line (-1 if none)
  * @pio_tasklet: Bottom half for PIO transfers and events
- * @wake_tasklet: Bottom half for incoming wake events
  * @wkin_cken: Keep track of clock references due to the incoming wake line
  * @wk_refcount: Reference count for output wake line
  * @sys_mpu_enable: Context for the interrupt enable register for irq 0
@@ -99,7 +98,6 @@ struct omap_ssi_port {
 	int			wake_irq;
 	struct gpio_desc	*wake_gpio;
 	struct tasklet_struct	pio_tasklet;
-	struct tasklet_struct	wake_tasklet;
 	bool			wktest:1; /* FIXME: HACK to be removed */
 	bool			wkin_cken:1; /* Workaround */
 	unsigned int		wk_refcount;
diff --git a/drivers/hsi/controllers/omap_ssi_core.c b/drivers/hsi/controllers/omap_ssi_core.c
index 54943e439488..a463420a0810 100644
--- a/drivers/hsi/controllers/omap_ssi_core.c
+++ b/drivers/hsi/controllers/omap_ssi_core.c
@@ -312,7 +312,7 @@ static int ssi_clk_event(struct notifier_block *nb, unsigned long event,
 				continue;
 
 			/* Workaround for SWBREAK + CAwake down race in CMT */
-			tasklet_disable(&omap_port->wake_tasklet);
+			disable_irq(omap_port->wake_irq);
 
 			/* stop all ssi communication */
 			pinctrl_pm_select_idle_state(omap_port->pdev);
@@ -338,7 +338,7 @@ static int ssi_clk_event(struct notifier_block *nb, unsigned long event,
 
 			/* resume ssi communication */
 			pinctrl_pm_select_default_state(omap_port->pdev);
-			tasklet_enable(&omap_port->wake_tasklet);
+			enable_irq(omap_port->wake_irq);
 		}
 
 		break;
diff --git a/drivers/hsi/controllers/omap_ssi_port.c b/drivers/hsi/controllers/omap_ssi_port.c
index 38388442e310..9001b06312c3 100644
--- a/drivers/hsi/controllers/omap_ssi_port.c
+++ b/drivers/hsi/controllers/omap_ssi_port.c
@@ -966,7 +966,7 @@ static irqreturn_t ssi_pio_isr(int irq, void *port)
 	return IRQ_HANDLED;
 }
 
-static void ssi_wake_tasklet(unsigned long ssi_port)
+static irqreturn_t ssi_wake_thread(int irq __maybe_unused, void *ssi_port)
 {
 	struct hsi_port *port = (struct hsi_port *)ssi_port;
 	struct hsi_controller *ssi = to_hsi_controller(port->device.parent);
@@ -1007,13 +1007,6 @@ static void ssi_wake_tasklet(unsigned long ssi_port)
 		}
 		spin_unlock(&omap_port->lock);
 	}
-}
-
-static irqreturn_t ssi_wake_isr(int irq __maybe_unused, void *ssi_port)
-{
-	struct omap_ssi_port *omap_port = hsi_port_drvdata(ssi_port);
-
-	tasklet_hi_schedule(&omap_port->wake_tasklet);
 
 	return IRQ_HANDLED;
 }
@@ -1051,13 +1044,12 @@ static int ssi_wake_irq(struct hsi_port *port, struct platform_device *pd)
 	}
 
 	cawake_irq = gpiod_to_irq(omap_port->wake_gpio);
-
 	omap_port->wake_irq = cawake_irq;
-	tasklet_init(&omap_port->wake_tasklet, ssi_wake_tasklet,
-							(unsigned long)port);
-	err = devm_request_irq(&port->device, cawake_irq, ssi_wake_isr,
-		IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-							"cawake", port);
+
+	err = devm_request_threaded_irq(&port->device, cawake_irq, NULL,
+		ssi_wake_thread,
+		IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+		"SSI cawake", port);
 	if (err < 0)
 		dev_err(&port->device, "Request Wake in IRQ %d failed %d\n",
 						cawake_irq, err);
@@ -1234,7 +1226,6 @@ static int ssi_port_remove(struct platform_device *pd)
 
 	hsi_port_unregister_clients(port);
 
-	tasklet_kill(&omap_port->wake_tasklet);
 	tasklet_kill(&omap_port->pio_tasklet);
 
 	port->async	= hsi_dummy_msg;
-- 
2.8.1
