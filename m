From: =?UTF-8?q?Andr=C3=A9=20Hentschel?= <nerv@dawncrow.de>
Subject: [PATCH v3 1/2] ARM: dts: Add dtsi files for AM3703, AM3715 and DM3725
Date: Thu,  2 Jan 2020 22:43:03 +0100
Message-ID: <20200102214304.8225-1-nerv@dawncrow.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@arm.linux.org.uk, robh+dt@kernel.org, mark.rutland@arm.com, bcousson@baylibre.com, tony@atomide.com, linux-omap@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

DM3730 is considered as omap36xx.dtsi, while the rest has:
     DM3730 | DM3725 | AM3715 | AM3703
IVA    X    |   X    |        |       
SGX    X    |        |   X    |       
Where X is "supported"

Signed-off-by: André Hentschel <nerv@dawncrow.de>
---
 arch/arm/boot/dts/am3703.dtsi | 14 ++++++++++++++
 arch/arm/boot/dts/am3715.dtsi | 10 ++++++++++
 arch/arm/boot/dts/dm3725.dtsi | 10 ++++++++++
 3 files changed, 34 insertions(+)
 create mode 100644 arch/arm/boot/dts/am3703.dtsi
 create mode 100644 arch/arm/boot/dts/am3715.dtsi
 create mode 100644 arch/arm/boot/dts/dm3725.dtsi

diff --git a/arch/arm/boot/dts/am3703.dtsi b/arch/arm/boot/dts/am3703.dtsi
new file mode 100644
index 000000000000..2b994ae790c9
--- /dev/null
+++ b/arch/arm/boot/dts/am3703.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 André Hentschel <nerv@dawncrow.de>
+ */
+
+#include "omap36xx.dtsi"
+
+&iva {
+	status = "disabled";
+};
+
+&sgx_module {
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/am3715.dtsi b/arch/arm/boot/dts/am3715.dtsi
new file mode 100644
index 000000000000..ab328e8c0bd8
--- /dev/null
+++ b/arch/arm/boot/dts/am3715.dtsi
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 André Hentschel <nerv@dawncrow.de>
+ */
+
+#include "omap36xx.dtsi"
+
+&iva {
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/dm3725.dtsi b/arch/arm/boot/dts/dm3725.dtsi
new file mode 100644
index 000000000000..d24e906a14b1
--- /dev/null
+++ b/arch/arm/boot/dts/dm3725.dtsi
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 André Hentschel <nerv@dawncrow.de>
+ */
+
+#include "omap36xx.dtsi"
+
+&sgx_module {
+	status = "disabled";
+};
-- 
2.17.1
