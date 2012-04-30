From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V3 2/2] of: selftest/dma: Add selftest for new DT DMA
Date: Mon, 30 Apr 2012 16:20:08 -0500
Message-ID: <1335820808-28806-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57070 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756967Ab2D3VU3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Apr 2012 17:20:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: device-tree <devicetree-discuss@lists.ozlabs.org>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@nvidia.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, Rob Herring <rob.herring@calxeda.com>, Arnd Bergmann <arnd@arndb.de>

From: Jon Hunter <jon-hunter@ti.com>

These selftests are covering the new DT DMA helpers for both legacy controllers
(not supporting DMA Engine) and controllers supporting DMA Engine. They will
test both error and normal cases.

A dummy DMA engine filter function is also provided to show how this is used
when registering a new DMA controller if the driver uses DMA engine.

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Stephen Warren <swarren@nvidia.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/boot/dts/at91sam9m10g45ek.dts     |    2 +
 arch/arm/boot/dts/omap4-panda.dts          |    2 +
 arch/arm/boot/dts/testcases/tests-dma.dtsi |   32 ++++++++
 arch/arm/boot/dts/testcases/tests.dtsi     |    1 +
 drivers/of/selftest.c                      |  118 ++++++++++++++++++++++++++++
 5 files changed, 155 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/testcases/tests-dma.dtsi

diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index a3633bd..4b3c942 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -154,3 +154,5 @@
 		};
 	};
 };
+
+/include/ "testcases/tests.dtsi"
diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index ea6f5bb..a79d637 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -74,3 +74,5 @@
 	ti,non-removable;
 	ti,bus-width = <4>;
 };
+
+/include/ "testcases/tests.dtsi"
diff --git a/arch/arm/boot/dts/testcases/tests-dma.dtsi b/arch/arm/boot/dts/testcases/tests-dma.dtsi
new file mode 100644
index 0000000..a75d155
--- /dev/null
+++ b/arch/arm/boot/dts/testcases/tests-dma.dtsi
@@ -0,0 +1,32 @@
+
+/ {
+	testcase-data {
+		dma-tests {
+			testdmac0: test-dma-controller0 {
+				#dma-cells = <2>;
+			};
+
+			testdmac1: test-dma-controller1 {
+				#dma-cells = <2>;
+			};
+
+			/* wrong number of cells */
+			testdmac2: test-dma-controller2 {
+				#dma-cells = <1>;
+			};
+
+			dma-slave-a {
+				dma = <&testdmac0 42 1>;
+			};
+
+			/* wrong number of values */
+			dma-slave-b {
+				dma = <&testdmac1 24>;
+			};
+
+			dma-slave-c {
+				dma = <&testdmac1 24 2>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/testcases/tests.dtsi b/arch/arm/boot/dts/testcases/tests.dtsi
index a7c5067..e3afb2b 100644
--- a/arch/arm/boot/dts/testcases/tests.dtsi
+++ b/arch/arm/boot/dts/testcases/tests.dtsi
@@ -1 +1,2 @@
 /include/ "tests-phandle.dtsi"
+/include/ "tests-dma.dtsi"
diff --git a/drivers/of/selftest.c b/drivers/of/selftest.c
index f24ffd7..65789691 100644
--- a/drivers/of/selftest.c
+++ b/drivers/of/selftest.c
@@ -9,10 +9,12 @@
 #include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_dma.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/device.h>
+#include <linux/dmaengine.h>
 
 static bool selftest_passed = true;
 #define selftest(result, fmt, ...) { \
@@ -148,6 +150,121 @@ static void __init of_selftest_property_match_string(void)
 	selftest(rc == -EILSEQ, "unterminated string; rc=%i", rc);
 }
 
+
+static bool selftest_dma_filter_fn(struct dma_chan *chan, void *param)
+{
+	return true;
+}
+
+static void __init of_selftest_dma(void)
+{
+	struct device_node *dma_controller_np;
+	struct device_node *dma_slave_np;
+	struct of_dma_channel_info info;
+	dma_cap_mask_t mask;
+	int rc;
+
+	pr_info("start\n");
+	dma_controller_np = of_find_node_by_path(
+		"/testcase-data/dma-tests/test-dma-controller0");
+	dma_slave_np = of_find_node_by_path(
+		"/testcase-data/dma-tests/dma-slave-a");
+	if (!dma_controller_np || !dma_slave_np) {
+		pr_err("No testcase data in device tree\n");
+		return;
+	}
+
+	/* wrong usage: DMA controller not registered yet! */
+	rc = of_get_dma_channel_info(dma_slave_np, DMA_MEM_TO_DEV, &info);
+	selftest(rc == -ENODEV,
+		"selftest DMA slave request expected:-ENODEV got:%i\n", rc);
+
+	/* test legacy DMA controller registration with no filter function */
+	rc = of_dma_controller_register(dma_controller_np, NULL, NULL);
+	selftest(rc == 0, "selftest DMA controller not found: got:%i\n", rc);
+
+	/* wrong usage and error code tests */
+	rc = of_get_dma_channel_info(dma_slave_np, DMA_MEM_TO_MEM, &info);
+	selftest(rc == -EINVAL,
+		"selftest DMA slave request expected:-EINVAL got:%i\n", rc);
+
+	rc = of_get_dma_channel_info(dma_slave_np, DMA_MEM_TO_DEV, NULL);
+	selftest(rc == -EINVAL,
+		"selftest DMA slave request expected:-EINVAL got:%i\n", rc);
+
+	/* proper use of the API */
+	rc = of_get_dma_channel_info(dma_slave_np, DMA_MEM_TO_DEV, &info);
+	selftest(rc == 0, "selftest DMA slave request error: got:%i\n", rc);
+	selftest(info.dma_channel == 42,
+		"selftest DMA slave request line expected:42 got:%i\n",
+		info.dma_channel);
+
+	of_dma_controller_free(dma_controller_np);
+
+	/* wrong usage: DMA controller not registered anymore! */
+	rc = of_get_dma_channel_info(dma_slave_np, DMA_MEM_TO_DEV, &info);
+	selftest(rc == -ENODEV,
+		"selftest DMA slave request expected:-ENODEV got:%i\n", rc);
+
+	/* use with a two values DMA request specification */
+	dma_controller_np = of_find_node_by_path(
+		"/testcase-data/dma-tests/test-dma-controller1");
+	dma_slave_np = of_find_node_by_path(
+		"/testcase-data/dma-tests/dma-slave-b");
+	if (!dma_controller_np || !dma_slave_np) {
+		pr_err("No testcase data in device tree\n");
+		return;
+	}
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	/* DMA controller registration using DMA Engine filter function */
+	rc = of_dma_controller_register(dma_controller_np, &mask,
+		selftest_dma_filter_fn);
+	selftest(rc == 0, "selftest DMA controller not found: got:%i\n", rc);
+
+	/* wrong number of cells */
+	rc = of_get_dma_channel_info(dma_slave_np, DMA_MEM_TO_MEM, &info);
+	selftest(rc == -EINVAL,
+		"selftest DMA slave request expected:-EINVAL got:%i\n", rc);
+
+	dma_slave_np = of_find_node_by_path(
+		"/testcase-data/dma-tests/dma-slave-c");
+	if (!dma_slave_np) {
+		pr_err("No dma-slave-c data in device tree\n");
+		return;
+	}
+
+	/* proper use of the API */
+	rc = of_get_dma_channel_info(dma_slave_np, DMA_DEV_TO_MEM, &info);
+	selftest(rc == 0, "selftest DMA slave request error: got:%i\n", rc);
+	selftest(info.dma_channel == 24,
+		"selftest DMA slave request line expected:24 got:%i\n",
+		info.dma_channel);
+	selftest(info.dma_filter_func == selftest_dma_filter_fn,
+		"selftest DMA slave filter function expected:0x%x got:0x%x\n",
+		(u32)selftest_dma_filter_fn, (u32)info.dma_filter_func);
+
+	of_dma_controller_free(dma_controller_np);
+
+	/* use with a two values DMA request specification */
+	dma_controller_np = of_find_node_by_path(
+		"/testcase-data/dma-tests/test-dma-controller2");
+	if (!dma_controller_np) {
+		pr_err("No testcase data in device tree\n");
+		return;
+	}
+
+	/* wrong number of cells */
+	rc = of_dma_controller_register(dma_controller_np, NULL,
+		selftest_dma_filter_fn);
+	selftest(rc == -EINVAL, "selftest DMA controller not found: got:%i\n",
+		rc);
+
+	pr_info("end - %s\n", selftest_passed ? "PASS" : "FAIL");
+}
+
 static int __init of_selftest(void)
 {
 	struct device_node *np;
@@ -162,6 +279,7 @@ static int __init of_selftest(void)
 	pr_info("start of selftest - you will see error messages\n");
 	of_selftest_parse_phandle_with_args();
 	of_selftest_property_match_string();
+	of_selftest_dma();
 	pr_info("end of selftest - %s\n", selftest_passed ? "PASS" : "FAIL");
 	return 0;
 }
-- 
1.7.5.4

