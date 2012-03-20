From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH 2/2] of: selftest/dma: Add selftest for new DT DMA request helpers
Date: Tue, 20 Mar 2012 11:13:32 +0100
Message-ID: <066e4deaddca8ac368c2c355c3a77daa9e9057cf.1332237596.git.nicolas.ferre@atmel.com>
References: <1331800690-21518-1-git-send-email-nicolas.ferre@atmel.com>
 <6b5dc1fadfd03a48093338b6981c0a7ae7662212.1332237596.git.nicolas.ferre@atmel.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:19483 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756038Ab2CTKOZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Mar 2012 06:14:25 -0400
In-Reply-To: <6b5dc1fadfd03a48093338b6981c0a7ae7662212.1332237596.git.nicolas.ferre@atmel.com>
In-Reply-To: <6b5dc1fadfd03a48093338b6981c0a7ae7662212.1332237596.git.nicolas.ferre@atmel.com>
References: <6b5dc1fadfd03a48093338b6981c0a7ae7662212.1332237596.git.nicolas.ferre@atmel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, plagnioj@jcrosoft.com, vinod.koul@linux.intel.com, Nicolas Ferre <nicolas.ferre@atmel.com>, Stephen Warren <swarren@nvidia.com>, Russell King <linux@arm.linux.org.uk>, Rob Herring <rob.herring@calxeda.com>, Arnd Bergmann <arnd@arndb.de>

Those selftests are covering the new DT DMA helpers. They will test both
error and normal cases.
A custom .xlate() function is also provided to show the use of this API in case
of a different need than the single cell argument.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Stephen Warren <swarren@nvidia.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/dts/at91sam9m10g45ek.dts     |    2 +
 arch/arm/boot/dts/testcases/tests-dma.dtsi |   24 +++++++
 arch/arm/boot/dts/testcases/tests.dtsi     |    1 +
 drivers/of/selftest.c                      |  100 ++++++++++++++++++++++++++++
 4 files changed, 127 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/testcases/tests-dma.dtsi

diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index a387e77..18a8f3c 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -38,3 +38,5 @@
 		};
 	};
 };
+
+/include/ "testcases/tests.dtsi"
diff --git a/arch/arm/boot/dts/testcases/tests-dma.dtsi b/arch/arm/boot/dts/testcases/tests-dma.dtsi
new file mode 100644
index 0000000..5f0ba93
--- /dev/null
+++ b/arch/arm/boot/dts/testcases/tests-dma.dtsi
@@ -0,0 +1,24 @@
+
+/ {
+	testcase-data {
+		dma-tests {
+			testdmac0: test-dma-controller0 {
+				#dma-cells = <1>;
+			};
+
+			testdmac1: test-dma-controller1 {
+				#dma-cells = <2>;
+			};
+
+			dma-slave-a {
+				dma-request = <&testdmac0 42>;
+			};
+			dma-slave-b {
+				dma-request = <&testdmac1 24>; /* wrong number of values */
+			};
+			dma-slave-c {
+				dma-request = <&testdmac1 24 25>;
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
index f24ffd7..3281bfd 100644
--- a/drivers/of/selftest.c
+++ b/drivers/of/selftest.c
@@ -9,6 +9,7 @@
 #include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_dma.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
@@ -148,6 +149,104 @@ static void __init of_selftest_property_match_string(void)
 	selftest(rc == -EILSEQ, "unterminated string; rc=%i", rc);
 }
 
+struct two_cells {
+	int cell1;
+	int cell2;
+};
+
+static int of_dma_xlate_twonumbercell(struct of_phandle_args *dma_spec, void *cells)
+{
+	struct two_cells *tc;
+
+	if (!dma_spec)
+		return -EINVAL;
+	if (!cells)
+		return -ENOBUFS;
+	if (WARN_ON(dma_spec->args_count != 2))
+		return -EINVAL;
+
+	tc = (struct two_cells *)cells;
+
+	tc->cell1 = dma_spec->args[0];
+	tc->cell2 = dma_spec->args[1];
+	return 0;
+}
+
+static void __init of_selftest_dma(void)
+{
+	struct device_node *dma_controller0_np;
+	struct device_node *dma_controller1_np;
+	struct device_node *dma_slave_np;
+	int rc;
+	int dma_req;
+	struct two_cells tc;
+
+	pr_info("start\n");
+	dma_controller0_np = of_find_node_by_path("/testcase-data/dma-tests/test-dma-controller0");
+	dma_slave_np = of_find_node_by_path("/testcase-data/dma-tests/dma-slave-a");
+	if (!dma_controller0_np || !dma_slave_np) {
+		pr_err("No testcase data in device tree\n");
+		return;
+	}
+
+	/* wrong usage: DMA controller not registered yet! */
+	rc = of_get_dma_request(dma_slave_np, 0, &dma_req);
+	selftest(rc == -ENODEV, "selftest DMA slave request expected:-ENODEV got:%i\n", rc);
+
+	/* test DMA controller registration */
+	rc = of_dma_controller_register(dma_controller0_np, of_dma_xlate_onenumbercell);
+	selftest(rc == 0, "selftest DMA controller not found: got:%i\n", rc);
+
+	/* wrong usage and error code tests */
+	rc = of_get_dma_request(dma_slave_np, 1, &dma_req);
+	selftest(rc == -EINVAL, "selftest DMA slave request expected:-EINVAL got:%i\n", rc);
+
+	rc = of_get_dma_request(dma_slave_np, 0, NULL);
+	selftest(rc == -ENOBUFS, "selftest DMA slave request expected:-ENOBUFS got:%i\n", rc);
+
+	/* proper use of the API */
+	rc = of_get_dma_request(dma_slave_np, 0, &dma_req);
+	selftest(rc == 0, "selftest DMA slave request error: got:%i\n", rc);
+	selftest(dma_req == 42, "selftest DMA slave request line expected:42 got:%i\n", dma_req);
+
+	of_dma_controller_free(dma_controller0_np);
+
+	/* wrong usage: DMA controller not registered anymore! */
+	rc = of_get_dma_request(dma_slave_np, 0, &dma_req);
+	selftest(rc == -ENODEV, "selftest DMA slave request expected:-ENODEV got:%i\n", rc);
+
+	/* use with a two values DMA request specification */
+	dma_controller1_np = of_find_node_by_path("/testcase-data/dma-tests/test-dma-controller1");
+	dma_slave_np = of_find_node_by_path("/testcase-data/dma-tests/dma-slave-b");
+	if (!dma_controller1_np || !dma_slave_np) {
+		pr_err("No testcase data in device tree\n");
+		return;
+	}
+
+	/* DMA controller registration with custom .xlate() function */
+	rc = of_dma_controller_register(dma_controller1_np, of_dma_xlate_twonumbercell);
+	selftest(rc == 0, "selftest DMA controller not found: got:%i\n", rc);
+
+	/* wrong number of cells */
+	rc = of_get_dma_request(dma_slave_np, 0, &tc);
+	selftest(rc == -EINVAL, "selftest DMA slave request expected:-EINVAL got:%i\n", rc);
+
+	dma_slave_np = of_find_node_by_path("/testcase-data/dma-tests/dma-slave-c");
+	if (!dma_slave_np) {
+		pr_err("No dma-slave-c data in device tree\n");
+		return;
+	}
+
+	/* proper use of the API */
+	rc = of_get_dma_request(dma_slave_np, 0, &tc);
+	selftest(rc == 0, "selftest DMA slave request error: got:%i\n", rc);
+	selftest(tc.cell1 == 24, "selftest DMA slave request line expected:24 got:%i\n", tc.cell1);
+	selftest(tc.cell2 == 25, "selftest DMA slave request line expected:25 got:%i\n", tc.cell2);
+
+	of_dma_controller_free(dma_controller1_np);
+	pr_info("end - %s\n", selftest_passed ? "PASS" : "FAIL");
+}
+
 static int __init of_selftest(void)
 {
 	struct device_node *np;
@@ -162,6 +261,7 @@ static int __init of_selftest(void)
 	pr_info("start of selftest - you will see error messages\n");
 	of_selftest_parse_phandle_with_args();
 	of_selftest_property_match_string();
+	of_selftest_dma();
 	pr_info("end of selftest - %s\n", selftest_passed ? "PASS" : "FAIL");
 	return 0;
 }
-- 
1.7.9

