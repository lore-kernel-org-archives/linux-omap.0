From: Suman Anna <s-anna@ti.com>
Subject: [PATCH v8 3/4] Documentation: dt: add the omap hwspinlock bindings document
Date: Wed, 4 Mar 2015 20:01:15 -0600
Message-ID: <1425520876-37826-4-git-send-email-s-anna@ti.com>
References: <1425520876-37826-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43713 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753935AbbCECBw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Mar 2015 21:01:52 -0500
In-Reply-To: <1425520876-37826-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>, Rob Herring <robh+dt@kernel.org>

HwSpinlock IP is present only on OMAP4 and other newer SoCs,
which are all device-tree boot only. This patch adds the
DT bindings information for OMAP hwspinlock module.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
v8: Removed the previous information about hwlock-base-id, and added
    a reference to the base binding document.

 .../devicetree/bindings/hwlock/omap-hwspinlock.txt | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwlock/omap-hwspinlock.txt

diff --git a/Documentation/devicetree/bindings/hwlock/omap-hwspinlock.txt b/Documentation/devicetree/bindings/hwlock/omap-hwspinlock.txt
new file mode 100644
index 000000000000..2c9804f4f4ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwlock/omap-hwspinlock.txt
@@ -0,0 +1,26 @@
+OMAP4+ HwSpinlock Driver
+========================
+
+Required properties:
+- compatible:		Should be "ti,omap4-hwspinlock" for
+			    OMAP44xx, OMAP54xx, AM33xx, AM43xx, DRA7xx SoCs
+- reg:			Contains the hwspinlock module register address space
+			(base address and length)
+- ti,hwmods:		Name of the hwmod associated with the hwspinlock device
+- #hwlock-cells:	Should be 1. The OMAP hwspinlock users will use a
+			0-indexed relative hwlock number as the argument
+			specifier value for requesting a specific hwspinlock
+			within a hwspinlock bank.
+
+Please look at the generic hwlock binding for usage information for consumers,
+"Documentation/devicetree/bindings/hwlock/hwlock.txt"
+
+Example:
+
+/* OMAP4 */
+hwspinlock: spinlock@4a0f6000 {
+	compatible = "ti,omap4-hwspinlock";
+	reg = <0x4a0f6000 0x1000>;
+	ti,hwmods = "spinlock";
+	#hwlock-cells = <1>;
+};
-- 
2.3.0

