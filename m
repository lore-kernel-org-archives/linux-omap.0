From: Suman Anna <s-anna@ti.com>
Subject: [PATCHv6 1/5] Documentation: dt: add common bindings for hwspinlock
Date: Fri, 12 Sep 2014 15:24:55 -0500
Message-ID: <1410553499-55951-2-git-send-email-s-anna@ti.com>
References: <1410553499-55951-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1410553499-55951-1-git-send-email-s-anna@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>
Cc: devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Josh Cartwright <joshc@codeaurora.org>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, Bjorn Andersson <bjorn@kryo.se>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This patch adds the generic common bindings used to represent
a hwlock device and use/request locks in a device-tree build.

All the platform-specific hwlock driver implementations need the
number of locks and associated base id for registering the locks
present within the device with the driver core. This base id
needs to be unique across multiple IP instances of a hwspinlock
device, so that each hwlock can be represented uniquely in a
system.

The number of locks is represented by 'hwlock-num-locks' property,
and the base id is represented by the 'hwlock-base-id' property.
The args specifier length is dependent on each vendor-specific
implementation and is represented through the '#hwlock-cells'
property. Client users need to use the property 'hwlocks' for
requesting specific lock(s).

Note that the document is named hwlock.txt deliberately to keep
it a bit more generic.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 .../devicetree/bindings/hwlock/hwlock.txt          | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwlock/hwlock.txt

diff --git a/Documentation/devicetree/bindings/hwlock/hwlock.txt b/Documentation/devicetree/bindings/hwlock/hwlock.txt
new file mode 100644
index 0000000..24993dd
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwlock/hwlock.txt
@@ -0,0 +1,55 @@
+Generic hwlock bindings
+=======================
+
+Generic bindings that are common to all the hwlock platform specific driver
+implementations.
+
+The validity and need of these common properties may vary from one platform
+implementation to another. The platform specific bindings should explicitly
+state if an optional property is used. Please also look through the individual
+platform specific hwlock binding documentations for identifying the applicable
+properties.
+
+Common properties:
+- #hwlock-cells:	Specifies the number of cells needed to represent a
+			specific lock. This property is mandatory for all
+			platform implementations.
+- hwlock-num-locks:	Number of locks present in a hwlock device. This
+			property is needed on hwlock devices, where the number
+			of supported locks within a hwlock device cannot be
+			read from a register.
+- hwlock-base-id:	An unique base Id for the locks for a particular hwlock
+			device. This property is mandatory if a SoC has several
+			hwlock devices.
+
+Hwlock Users:
+=============
+
+Nodes that require specific hwlock(s) should specify them using the property
+"hwlocks", each containing a phandle to the hwlock node and an args specifier
+value as indicated by #hwlock-cells. Multiple hwlocks can be requested using
+an array of the phandle and hwlock number specifier tuple.
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
2.0.4
