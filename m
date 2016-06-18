From: Sebastian Reichel <sre@kernel.org>
Subject: [RFC 08/19] HSI: core: switch port event notifier from atomic to blocking
Date: Sat, 18 Jun 2016 18:26:58 +0200
Message-ID: <1466267229-25012-9-git-send-email-sre@kernel.org>
References: <1466267229-25012-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466267229-25012-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

port events should be sent from process context after
irq_safe runtime pm flag is removed in omap-ssi.
---
 drivers/hsi/hsi_core.c  | 8 ++++----
 include/linux/hsi/hsi.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hsi/hsi_core.c b/drivers/hsi/hsi_core.c
index d7ce07ad67f3..c2a2a9795b0b 100644
--- a/drivers/hsi/hsi_core.c
+++ b/drivers/hsi/hsi_core.c
@@ -507,7 +507,7 @@ struct hsi_controller *hsi_alloc_controller(unsigned int n_ports, gfp_t flags)
 		port[i]->stop_tx = hsi_dummy_cl;
 		port[i]->release = hsi_dummy_cl;
 		mutex_init(&port[i]->lock);
-		ATOMIC_INIT_NOTIFIER_HEAD(&port[i]->n_head);
+		BLOCKING_INIT_NOTIFIER_HEAD(&port[i]->n_head);
 		dev_set_name(&port[i]->device, "port%d", i);
 		hsi->port[i]->device.release = hsi_port_release;
 		device_initialize(&hsi->port[i]->device);
@@ -689,7 +689,7 @@ int hsi_register_port_event(struct hsi_client *cl,
 	cl->ehandler = handler;
 	cl->nb.notifier_call = hsi_event_notifier_call;
 
-	return atomic_notifier_chain_register(&port->n_head, &cl->nb);
+	return blocking_notifier_chain_register(&port->n_head, &cl->nb);
 }
 EXPORT_SYMBOL_GPL(hsi_register_port_event);
 
@@ -709,7 +709,7 @@ int hsi_unregister_port_event(struct hsi_client *cl)
 
 	WARN_ON(!hsi_port_claimed(cl));
 
-	err = atomic_notifier_chain_unregister(&port->n_head, &cl->nb);
+	err = blocking_notifier_chain_unregister(&port->n_head, &cl->nb);
 	if (!err)
 		cl->ehandler = NULL;
 
@@ -734,7 +734,7 @@ EXPORT_SYMBOL_GPL(hsi_unregister_port_event);
  */
 int hsi_event(struct hsi_port *port, unsigned long event)
 {
-	return atomic_notifier_call_chain(&port->n_head, event, NULL);
+	return blocking_notifier_call_chain(&port->n_head, event, NULL);
 }
 EXPORT_SYMBOL_GPL(hsi_event);
 
diff --git a/include/linux/hsi/hsi.h b/include/linux/hsi/hsi.h
index 2790591c77cf..57402544b53f 100644
--- a/include/linux/hsi/hsi.h
+++ b/include/linux/hsi/hsi.h
@@ -246,7 +246,7 @@ struct hsi_port {
 	int				(*stop_tx)(struct hsi_client *cl);
 	int				(*release)(struct hsi_client *cl);
 	/* private */
-	struct atomic_notifier_head	n_head;
+	struct blocking_notifier_head	n_head;
 };
 
 #define to_hsi_port(dev) container_of(dev, struct hsi_port, device)
-- 
2.8.1
