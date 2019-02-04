From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 1/4] dt-binding: bus: ti-sysc: Add support for PRUSS SYSC type
Date: Mon, 4 Feb 2019 17:53:54 +0200
Message-ID: <1549295637-24890-2-git-send-email-rogerq@ti.com>
References: <1549295637-24890-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549295637-24890-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: s-anna@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, david@lechnology.com, woods.technical@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

The PRUSS module has a SYSCFG which is unique. Add
support for it.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 Documentation/devicetree/bindings/bus/ti-sysc.txt |  1 +
 include/dt-bindings/bus/ti-sysc.h                 | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/bus/ti-sysc.txt b/Documentation/devicetree/bindings/bus/ti-sysc.txt
index 85a23f5..fe1dfb1 100644
--- a/Documentation/devicetree/bindings/bus/ti-sysc.txt
+++ b/Documentation/devicetree/bindings/bus/ti-sysc.txt
@@ -38,6 +38,7 @@ Required standard properties:
 		"ti,sysc-dra7-mcasp"
 		"ti,sysc-usb-host-fs"
 		"ti,sysc-dra7-mcan"
+		"ti,sysc-pruss"
 
 - reg		shall have register areas implemented for the interconnect
 		target module in question such as revision, sysc and syss
diff --git a/include/dt-bindings/bus/ti-sysc.h b/include/dt-bindings/bus/ti-sysc.h
index 7138384..8ec78e8 100644
--- a/include/dt-bindings/bus/ti-sysc.h
+++ b/include/dt-bindings/bus/ti-sysc.h
@@ -17,6 +17,17 @@
 
 #define SYSC_DRA7_MCAN_ENAWAKEUP	(1 << 4)
 
+/* SYSCONFIG specific to PRUSS */
+#define SYSC_PRUSS_SUB_MWAIT		(1 << 5)
+#define SYSC_PRUSS_STANDBY_INIT		(1 << 4)
+
+#define SYSC_PRUSS_STANDBY_FORCE	(0 << 2)
+#define SYSC_PRUSS_STANDBY_NO		(1 << 2)
+#define SYSC_PRUSS_STANDBY_SMART	(2 << 2)
+#define SYSC_PRUSS_STANDBY_MASK		(3 << 2)
+
+#define SYSC_PRUSS_IDLE_MASK		3
+
 /* SYSCONFIG STANDBYMODE/MIDLEMODE/SIDLEMODE supported by hardware */
 #define SYSC_IDLE_FORCE			0
 #define SYSC_IDLE_NO			1
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
