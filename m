From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv4 04/13] HSI: method to unregister clients from an hsi port
Date: Fri, 25 Apr 2014 21:06:07 +0200
Message-ID: <1398452776-28638-5-git-send-email-sre@kernel.org>
References: <1398452776-28638-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398452776-28638-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Linus Walleij <linus.walleij@linaro.org>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, Carlos Chinea <cch.devel@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, =?UTF-8?q?=D0=98=D0=B2=D0=B0=D0=B9=D0=BB=D0=BE=20=D0=94=D0=B8=D0=BC=D0=B8=D1=82=D1=80=D0=BE=D0=B2?= <freemangordon@abv.bg>, Joni Lapilainen <joni.lapilainen@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

This exports a method to unregister all clients from
an hsi port.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
Reviewed-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/hsi/hsi.c       | 10 ++++++++++
 include/linux/hsi/hsi.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/hsi/hsi.c b/drivers/hsi/hsi.c
index 749f7b5..e96a987 100644
--- a/drivers/hsi/hsi.c
+++ b/drivers/hsi/hsi.c
@@ -130,6 +130,16 @@ static void hsi_port_release(struct device *dev)
 }
 
 /**
+ * hsi_unregister_port - Unregister an HSI port
+ * @port: The HSI port to unregister
+ */
+void hsi_port_unregister_clients(struct hsi_port *port)
+{
+	device_for_each_child(&port->device, NULL, hsi_remove_client);
+}
+EXPORT_SYMBOL_GPL(hsi_port_unregister_clients);
+
+/**
  * hsi_unregister_controller - Unregister an HSI controller
  * @hsi: The HSI controller to register
  */
diff --git a/include/linux/hsi/hsi.h b/include/linux/hsi/hsi.h
index 39bfd5b..5a9f121 100644
--- a/include/linux/hsi/hsi.h
+++ b/include/linux/hsi/hsi.h
@@ -282,6 +282,7 @@ struct hsi_controller *hsi_alloc_controller(unsigned int n_ports, gfp_t flags);
 void hsi_put_controller(struct hsi_controller *hsi);
 int hsi_register_controller(struct hsi_controller *hsi);
 void hsi_unregister_controller(struct hsi_controller *hsi);
+void hsi_port_unregister_clients(struct hsi_port *port);
 
 static inline void hsi_controller_set_drvdata(struct hsi_controller *hsi,
 								void *data)
-- 
1.9.2
