From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v8 1/4] Documentation: dt: add common bindings for hwspinlock
Date: Wed, 4 Mar 2015 20:01:13 -0600
Message-ID: <1425520876-37826-2-git-send-email-s-anna@ti.com>
References: <1425520876-37826-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425520876-37826-1-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This patch adds the generic common bindings used to represent
a hwlock device and use/request locks in a device-tree build.

Each hwspinlock provider should have the '#hwlock-cells' property,
which represents the number of cells to be used for representing
a specific hwspinlock. Client users shall use the property
'hwlocks' for requesting specific lock(s).

Note that the document is named hwlock.txt deliberately to keep
it a bit more generic.

Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
v8: Revised the binding completely, removed hwlock-num-locks and
    hwlock-base-id properties. Added hwlock-names as optional
    property. Revised patch description as well. 

 .../devicetree/bindings/hwlock/hwlock.txt          | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwlock/hwlock.txt

diff --git a/Documentation/devicetree/bindings/hwlock/hwlock.txt b/Documentation/devicetree/bindings/hwlock/hwlock.txt
new file mode 100644
index 000000000000..085d1f5c916a
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwlock/hwlock.txt
@@ -0,0 +1,59 @@
+Generic hwlock bindings
+=======================
+
+Generic bindings that are common to all the hwlock platform specific driver
+implementations.
+
+Please also look through the individual platform specific hwlock binding
+documentations for identifying any additional properties specific to that
+platform.
+
+hwlock providers:
+=================
+
+Required properties:
+- #hwlock-cells:        Specifies the number of cells needed to represent a
+                        specific lock.
+
+hwlock users:
+=============
+
+Consumers that require specific hwlock(s) should specify them using the
+property "hwlocks", and an optional "hwlock-names" property.
+
+Required properties:
+- hwlocks:              List of phandle to a hwlock provider node and an
+                        associated hwlock args specifier as indicated by
+                        #hwlock-cells. The list can have just a single hwlock
+                        or multiple hwlocks, with each hwlock represented by
+                        a phandle and a corresponding args specifier.
+
+Optional properties:
+- hwlock-names:         List of hwlock name strings defined in the same order
+                        as the hwlocks, with one name per hwlock. Consumers can
+                        use the hwlock-names to match and get a specific hwlock.
+
+
+1. Example of a node using a single specific hwlock:
+
+The following example has a node requesting a hwlock in the bank defined by
+the node hwlock1. hwlock1 is a hwlock provider with an argument specifier
+of length 1.
+
+	node {
+		...
+		hwlocks = <&hwlock1 2>;
+		...
+	};
+
+2. Example of a node using multiple specific hwlocks:
+
+The following example has a node requesting two hwlocks, a hwlock within
+the hwlock device node 'hwlock1' with #hwlock-cells value of 1, and another
+hwlock within the hwlock device node 'hwlock2' with #hwlock-cells value of 2.
+
+	node {
+		...
+		hwlocks = <&hwlock1 2>, <&hwlock2 0 3>;
+		...
+	};
-- 
2.3.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
