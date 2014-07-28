From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 33/35] irq: intc: comment style cleanup
Date: Mon, 28 Jul 2014 16:16:21 -0500
Message-ID: <1406582183-696-34-git-send-email-balbi@ti.com>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1406582183-696-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, bcousson@baylibre.com, linux@arm.linux.org.uk, khilman@deeprootsystems.com, tglx@linutronix.de, jason@lakedaemon.net, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

no functional changes, just making sure comment
follows Coding Style.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/irqchip/irq-omap-intc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-omap-intc.c
index c9ba502..342e0ab 100644
--- a/drivers/irqchip/irq-omap-intc.c
+++ b/drivers/irqchip/irq-omap-intc.c
@@ -327,9 +327,11 @@ out:
 		}
 	} while (irqnr);
 
-	/* If an irq is masked or deasserted while active, we will
+	/*
+	 * If an irq is masked or deasserted while active, we will
 	 * keep ending up here with no irq handled. So remove it from
-	 * the INTC with an ack.*/
+	 * the INTC with an ack.
+	 */
 	if (!handled_irq)
 		omap_ack_irq(NULL);
 }
-- 
2.0.1.563.g66f467c
