From: Benoit Cousson <bcousson@baylibre.com>
Subject: [RFC 13/15] bindings: OMAP: add new schema files
Date: Tue, 24 Sep 2013 18:52:19 +0200
Message-ID: <1380041541-17529-14-git-send-email-bcousson@baylibre.com>
References: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:41988 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754378Ab3IXQxH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Sep 2013 12:53:07 -0400
Received: by mail-wg0-f49.google.com with SMTP id l18so4805424wgh.4
        for <linux-omap@vger.kernel.org>; Tue, 24 Sep 2013 09:53:06 -0700 (PDT)
In-Reply-To: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: olof@lixom.net, devicetree@vger.kernel.org, tomasz.figa@gmail.com, swarren@wwwdotorg.org, grant.likely@secretlab.ca, rob.herring@calxeda.com
Cc: khilman@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, fparent@baylibre.com, Benoit Cousson <bcousson@baylibre.com>

From: Fabien Parent <fparent@baylibre.com>

Introduce a couple of real schema for OMAP DTS files. For the moment validate
only: MPU, DSP, INTC, IVA, TIME and COUNTER.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
---
 bindings/arm/omap/counter.schema |  28 +++++++++
 bindings/arm/omap/dsp.schema     |  18 ++++++
 bindings/arm/omap/intc.schema    |  48 +++++++++++++++
 bindings/arm/omap/iva.schema     |  38 ++++++++++++
 bindings/arm/omap/l3-noc.schema  |  38 ++++++++++++
 bindings/arm/omap/mpu.schema     |  19 ++++++
 bindings/arm/omap/omap.schema    |  62 ++++++++++++++++++++
 bindings/arm/omap/timer.schema   | 124 +++++++++++++++++++++++++++++++++++++++
 8 files changed, 375 insertions(+)
 create mode 100644 bindings/arm/omap/counter.schema
 create mode 100644 bindings/arm/omap/dsp.schema
 create mode 100644 bindings/arm/omap/intc.schema
 create mode 100644 bindings/arm/omap/iva.schema
 create mode 100644 bindings/arm/omap/l3-noc.schema
 create mode 100644 bindings/arm/omap/mpu.schema
 create mode 100644 bindings/arm/omap/omap.schema
 create mode 100644 bindings/arm/omap/timer.schema

diff --git a/bindings/arm/omap/counter.schema b/bindings/arm/omap/counter.schema
new file mode 100644
index 0000000..63b0272
--- /dev/null
+++ b/bindings/arm/omap/counter.schema
@@ -0,0 +1,28 @@
+/**
+ * OMAP Counter-32K bindings
+ */
+
+/dts-v1/;
+
+/ {
+    compatible {
+        description = "Must be 'ti,omap-counter32k' for OMAP controllers.";
+        value = "ti,omap-counter32k";
+    };
+
+    reg {
+        description = "Contains timer register address range (base address
+                       and length).";
+        is-required;
+        type = "integer";
+        length = <2>;
+    };
+
+    ti,hwmods {
+        description = "Name of the hwmod associated to the counter,
+                       which is typically 'counter_32k'.";
+        is-required;
+        type = "string";
+        value = "counter_32k";
+    };
+};
diff --git a/bindings/arm/omap/dsp.schema b/bindings/arm/omap/dsp.schema
new file mode 100644
index 0000000..7087f60
--- /dev/null
+++ b/bindings/arm/omap/dsp.schema
@@ -0,0 +1,18 @@
+/**
+ * TI - DSP (Digital Signal Processor)
+ */
+
+/dts-v1/;
+
+/ {
+    compatible {
+        description = "Should be 'ti,omap3-c64' for OMAP3 & 4";
+        value = "ti,omap3-c64";
+    };
+
+    ti,hwmods {
+        is-required;
+        type = "string";
+        value = "dsp";
+    };
+};
diff --git a/bindings/arm/omap/intc.schema b/bindings/arm/omap/intc.schema
new file mode 100644
index 0000000..564c80e
--- /dev/null
+++ b/bindings/arm/omap/intc.schema
@@ -0,0 +1,48 @@
+/**
+ * OMAP Interrupt Controller
+ *
+ * OMAP2/3 are using a TI interrupt controller that can support several
+ * configurable number of interrupts.
+ */
+
+/dts-v1/;
+
+/ {
+    compatible {
+        description = "Must be 'ti,omap-counter32k' for OMAP controllers.";
+        value = "ti,omap2-intc";
+    };
+
+    interrupt-controller {
+        description = "Identifies the node as an interrupt controller";
+        is-required;
+        type = "bool";
+    };
+
+    #interrupt-cells {
+        description = "Specifies the number of cells needed to encode an
+                       interrupt source. The type shall be a <u32>
+                       and the value shall be 1.
+                       The cell contains the interrupt number
+                       in the range [0-128].";
+        is-required;
+        type = "integer";
+        value = <1>;
+    };
+
+    ti,intc-size {
+        description = "Number of interrupts handled
+                       by the interrupt controller";
+        is-required;
+        type = "integer";
+        length = <1>;
+    };
+
+    reg {
+        description = "physical base address and size of the intc
+                       registers map.";
+        is-required;
+        type = "integer";
+        length = <2>;
+    };
+};
diff --git a/bindings/arm/omap/iva.schema b/bindings/arm/omap/iva.schema
new file mode 100644
index 0000000..582c104
--- /dev/null
+++ b/bindings/arm/omap/iva.schema
@@ -0,0 +1,38 @@
+/**
+ * TI - IVA (Imaging and Video Accelerator) subsystem
+ *
+ * The IVA contain various audio, video or imaging HW accelerator
+ * depending of the version.
+ */
+
+/dts-v1/;
+
+/ {
+    compatible {
+        value@0 {
+            description = "for OMAP4";
+            value = "ti,ivahd";
+        };
+
+        value@1 {
+            description = "for OMAP3";
+            value = "ti,iva2.2";
+        };
+
+        value@2 {
+            description = "for OMAP2430";
+            value = "ti,iva2.1";
+        };
+
+        value@3 {
+            description = "for OMAP2420";
+            value = "ti,iva1";
+        };
+    };
+
+    ti,hwmods {
+        is-required;
+        type = "string";
+        value = "iva";
+    };
+};
diff --git a/bindings/arm/omap/l3-noc.schema b/bindings/arm/omap/l3-noc.schema
new file mode 100644
index 0000000..0611c4d
--- /dev/null
+++ b/bindings/arm/omap/l3-noc.schema
@@ -0,0 +1,38 @@
+/**
+ * TI - L3 Network On Chip (NoC)
+ *
+ * This version is an implementation of the generic NoC IP
+ * provided by Arteris.
+ */
+
+/dts-v1/;
+
+/ {
+    compatible {
+        description = "Must be 'ti,omap-counter32k' for OMAP controllers.";
+
+        value@0 {
+            description = "Should be 'ti,omap3-l3-smx' for OMAP3 family";
+            value = "ti,omap3-l3-smx";
+        };
+
+        value@1 {
+            description = "Should be 'ti,omap4-l3-noc' for OMAP4 family";
+            value = "ti,omap4-l3-noc";
+        };
+    };
+
+    reg {
+        description = "Contains L3 register address range
+                       for each noc domain.";
+        is-required;
+        type = "integer";
+    };
+
+    ti,hwmods {
+        description = "'l3_main_1', ... One hwmod for each noc domain.";
+        is-required;
+        type = "string";
+        value = "l3_main_[0-9]+";
+    };
+};
diff --git a/bindings/arm/omap/mpu.schema b/bindings/arm/omap/mpu.schema
new file mode 100644
index 0000000..abf3337
--- /dev/null
+++ b/bindings/arm/omap/mpu.schema
@@ -0,0 +1,19 @@
+/**
+ * TI - MPU (Main Processor Unit) subsystem
+ *
+ * The MPU subsystem contain one or several ARM cores
+ * depending of the version.
+ * The MPU contain CPUs, GIC, L2 cache and a local PRCM.
+ */
+
+/dts-v1/;
+
+/ {
+    compatible = "ti,omap3-mpu", "ti,omap4-mpu";
+
+    ti,hwmods {
+        is-required;
+        type = "string";
+        value = "mpu";
+    };
+};
diff --git a/bindings/arm/omap/omap.schema b/bindings/arm/omap/omap.schema
new file mode 100644
index 0000000..4ed0634
--- /dev/null
+++ b/bindings/arm/omap/omap.schema
@@ -0,0 +1,62 @@
+/**
+ * Texas Instruments OMAP
+ *
+ * OMAP is currently using a static file per SoC family to describe the
+ * IPs present in the SoC.
+ * On top of that an omap_device is created to extend the platform_device
+ * capabilities and to allow binding with one or several hwmods.
+ * The hwmods will contain all the information to build the device:
+ * address range, irq lines, dma lines, interconnect, PRCM register,
+ * clock domain, input clocks.
+ * For the moment just point to the existing hwmod, the next step will be
+ * to move data from hwmod to device-tree representation.
+ *
+ *
+ * Boards:
+ *
+ * - OMAP3 BeagleBoard : Low cost community board
+ *   compatible = "ti,omap3-beagle", "ti,omap3"
+ *
+ * - OMAP3 Tobi with Overo : Commercial expansion board with daughter board
+ *   compatible = "ti,omap3-tobi", "ti,omap3-overo", "ti,omap3"
+ *
+ * - OMAP4 SDP : Software Development Board
+ *   compatible = "ti,omap4-sdp", "ti,omap4430"
+ *
+ * - OMAP4 PandaBoard : Low cost community board
+ *   compatible = "ti,omap4-panda", "ti,omap4430"
+ *
+ * - OMAP3 EVM : Software Development Board for OMAP35x, AM/DM37x
+ *   compatible = "ti,omap3-evm", "ti,omap3"
+ *
+ * - AM335X EVM : Software Development Board for AM335x
+ *   compatible = "ti,am335x-evm", "ti,am33xx", "ti,omap3"
+ *
+ * - AM335X Bone : Low cost community board
+ *   compatible = "ti,am335x-bone", "ti,am33xx", "ti,omap3"
+ *
+ * - OMAP5 EVM : Evaluation Module
+ *   compatible = "ti,omap5-evm", "ti,omap5"
+ *
+ * - AM43x EPOS EVM
+ *   compatible = "ti,am43x-epos-evm", "ti,am4372", "ti,am43"
+ */
+
+/dts-v1/;
+
+/ {
+    compatible = "ti,omap.+";
+
+    ti,hwmods {
+        description = "list of hwmod names (ascii strings), that comes
+                       from the OMAP HW documentation, attached to a
+                       device. Must contain at least one hwmod.";
+        type = "string";
+    };
+
+    ti,no_idle_on_suspend {
+        description = "When present, it prevents the PM to idle the module
+                       during suspend.";
+        type = "bool";
+    };
+};
diff --git a/bindings/arm/omap/timer.schema b/bindings/arm/omap/timer.schema
new file mode 100644
index 0000000..b9ae19e
--- /dev/null
+++ b/bindings/arm/omap/timer.schema
@@ -0,0 +1,124 @@
+/**
+ * OMAP Timer bindings
+ */
+
+/dts-v1/;
+
+/ {
+    compatible {
+        description = "Should be set to one of the below. Please note that
+                       OMAP44xx devices have timer instances that are 100%
+                       register compatible with OMAP3xxx devices as well as
+                       newer timers that are not 100% register compatible.
+                       So for OMAP44xx devices timer instances may use
+                       different compatible strings.";
+
+        value@0 {
+            description = "Applicable to OMAP24xx devices";
+            value = "ti,omap2420-timer";
+            parents {
+                root {
+                    name = "";
+                    compatible = "ti,omap.+";
+                };
+            };
+        };
+
+        value@1 {
+            description = "Applicable to OMAP3xxx/44xx devices";
+            value = "ti,omap3430-timer";
+            parents {
+                root {
+                    name = "";
+                    compatible = "ti,omap.+";
+                };
+            };
+        };
+
+        value@2 {
+            description = "Applicable to OMAP44xx devices";
+            value = "ti,omap4430-timer";
+            parents {
+                root {
+                    name = "";
+                    compatible = "ti,omap.+";
+                };
+            };
+        };
+
+        value@3 {
+            description = "Applicable to OMAP543x devices";
+            value = "ti,omap5430-timer";
+            parents {
+                root {
+                    name = "";
+                    compatible = "ti,omap.+";
+                };
+            };
+        };
+
+        value@4 {
+            description = "Applicable to AM335x devices";
+            value = "ti,am335x-timer";
+            parents {
+                root {
+                    name = "";
+                    compatible = "ti,am.+";
+                };
+            };
+        };
+
+        value@5 {
+            description = "Applicable to AM335x devices";
+            value = "ti,am335x-timer-1ms";
+            parents {
+                root {
+                    name = "";
+                    compatible = "ti,am.+";
+                };
+            };
+        };
+    };
+
+    reg {
+        description = "Contains timer register address range (base address
+                       and length).";
+        is-required;
+        type = "integer";
+    };
+
+    interrupts {
+        description = "Contains the interrupt information for the timer.
+                       The format is being dependent on which interrupt
+                       controller the OMAP device uses.";
+        is-required;
+        type = "integer";
+    };
+
+    ti,hwmods {
+        description = "Name of the hwmod associated to the timer, 'timer<X>',
+                       where <X> is the instance number of the timer from the
+                       HW spec.";
+        is-required;
+        type = "string";
+        value = "timer[0-9]+";
+    };
+
+    ti,timer-alwon {
+        description = "Indicates the timer is in an alway-on power domain.";
+        type = "bool";
+    };
+
+    ti,timer-dsp {
+        description = "Indicates the timer can interrupt the on-chip DSP in
+                       addition to the ARM CPU.";
+        type = "bool";
+    };
+
+    ti,timer-secure {
+        description = "Indicates the timer is reserved on a secure
+                       OMAP device and therefore cannot be used
+                       by the kernel";
+        type = "bool";
+    };
+};
-- 
1.8.1.2

