From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v7 2/4] Documentation: dt: add the omap hwspinlock bindings document
Date: Wed, 14 Jan 2015 14:58:19 -0600
Message-ID: <1421269101-51105-3-git-send-email-s-anna@ti.com>
References: <1421269101-51105-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1421269101-51105-1-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Bjorn Andersson <bjorn-UYDU3/A3LUY@public.gmane.org>, Josh Cartwright <joshc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

HwSpinlock IP is present only on OMAP4 and other newer SoCs,
which are all device-tree boot only. This patch adds the
DT bindings information for OMAP hwspinlock module.

Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
v7: Added information about hwlock-base-id and updated example to use it

 .../devicetree/bindings/hwlock/omap-hwspinlock.txt | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwlock/omap-hwspinlock.txt

diff --git a/Documentation/devicetree/bindings/hwlock/omap-hwspinlock.txt b/Documentation/devicetree/bindings/hwlock/omap-hwspinlock.txt
new file mode 100644
index 000000000000..935173ec6b58
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwlock/omap-hwspinlock.txt
@@ -0,0 +1,28 @@
+OMAP4+ HwSpinlock Driver
+========================
+
+Required properties:
+- compatible:		Should be "ti,omap4-hwspinlock" for
+			    OMAP44xx, OMAP54xx, AM33xx, AM43xx, DRA7xx SoCs
+- reg:			Contains the hwspinlock module register address space
+			(base address and length)
+- ti,hwmods:		Name of the hwmod associated with the hwspinlock device
+- hwlock-base-id:	Should be 0 for the first IP block instance, or a proper
+			positive value for any subsequent instance (if present)
+			of the IP block.
+- #hwlock-cells:	Should be 1. The OMAP hwspinlock users will use a
+			0-indexed relative hwlock number as the argument
+			specifier value for requesting a specific hwspinlock
+			within a hwspinlock bank.
+
+
+Example:
+
+/* OMAP4 */
+hwspinlock: spinlock@4a0f6000 {
+	compatible = "ti,omap4-hwspinlock";
+	reg = <0x4a0f6000 0x1000>;
+	ti,hwmods = "spinlock";
+	hwlock-base-id = <0>;
+	#hwlock-cells = <1>;
+};
-- 
2.2.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
