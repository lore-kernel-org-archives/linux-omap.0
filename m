From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH 13/14] Documentation: dt: OMAP: crossbar: add description for interrupt consumer
Date: Tue, 3 Jun 2014 13:13:05 +0530
Message-ID: <1401781386-4982-14-git-send-email-r.sricharan@ti.com>
References: <1401781386-4982-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37113 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932130AbaFCHqj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Jun 2014 03:46:39 -0400
In-Reply-To: <1401781386-4982-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: tony@atomide.com, santosh.shilimkar@ti.com, nm@ti.com, rnayak@ti.com, tglx@linutronix.de, linux@arm.linux.org.uk, r.sricharan@ti.com

From: Nishanth Menon <nm@ti.com>

The current crossbar description does not include the description
required for the consumer of the crossbar, a.k.a devices whoes events
pass through the crossbar into the GIC interrupt controller.

So, provide documentation for the same.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 .../devicetree/bindings/arm/omap/crossbar.txt      |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/omap/crossbar.txt b/Documentation/devicetree/bindings/arm/omap/crossbar.txt
index 6d2e2f5..816d11b 100644
--- a/Documentation/devicetree/bindings/arm/omap/crossbar.txt
+++ b/Documentation/devicetree/bindings/arm/omap/crossbar.txt
@@ -27,3 +27,20 @@ Examples:
 			ti,reg-size = <2>;
 			ti,irqs-reserved = <0 1 2 3 5 6 131 132 139 140>;
 		};
+
+Consumer:
+========
+See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt and
+Documentation/devicetree/bindings/arm/gic.txt for further details.
+
+An interrupt consumer on an SoC using crossbar will use:
+	interrupts = <GIC_SPI request_number interrupt_level>
+request number shall be between 0 to that described by
+"ti,max-crossbar-sources"
+
+Example:
+	device_x@0x4a023000 {
+		/* Crossbar 8 used */
+		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+		...
+	};
-- 
1.7.9.5

