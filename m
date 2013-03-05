From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 11/14] ARM: OMAP2+: Add device-tree support for NOR flash
Date: Tue, 5 Mar 2013 15:34:36 -0600
Message-ID: <513664EC.2050508@ti.com>
References: <1361899842-30303-1-git-send-email-jon-hunter@ti.com> <1361899842-30303-12-git-send-email-jon-hunter@ti.com> <51360271.1030302@mimc.co.uk> <51360562.20309@ti.com> <51361B46.507@mimc.co.uk> <51362BAB.10403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52140 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099Ab3CEVer (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Mar 2013 16:34:47 -0500
In-Reply-To: <51362BAB.10403@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Jackson <mpfj-list@mimc.co.uk>
Cc: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Daniel Mack <zonque@gmail.com>


On 03/05/2013 11:30 AM, Jon Hunter wrote:
> On 03/05/2013 10:20 AM, Mark Jackson wrote:

[snip]

>> But I can see in physmap_of.c that the device gets registered without any call to
>> devm_pinctrl_get_select_default() and hence no probe deferring takes place is the
>> pinctrl device hasn't yet been started (which it hasn't).
>>
>> Does probe deferral need adding to physmap_of.c, or should the pinctrl device really
>> be registered sooner ?
> 
> I see, so the pinctrl driver is not getting probed until later.

Can you give this version of the patch a go? I have re-worked the patch
so the NOR device will only be registered after the GPMC probe completes.

By the way, with this version you should remove "simple-bus" from your
gpmc node compatible strings. I now call of_platform_device_create() to
create the child device during the GPMC probe. I think that this is a
safer approach.

Cheers
Jon

>From 278ef0ac538da720fc15896ad6c3666e0f518633 Mon Sep 17 00:00:00 2001
From: Jon Hunter <jon-hunter@ti.com>
Date: Fri, 8 Feb 2013 16:46:13 -0600
Subject: [PATCH] ARM: OMAP2+: Add device-tree support for NOR flash

NOR flash is not currently supported when booting with device-tree
on OMAP2+ devices. Add support to detect and configure NOR devices
when booting with device-tree.

Add documentation for the TI GPMC NOR binding.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 Documentation/devicetree/bindings/mtd/gpmc-nor.txt |   98 +++++++++++++++++
 arch/arm/mach-omap2/gpmc.c                         |  113 ++++++++++++++++++++
 2 files changed, 211 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/gpmc-nor.txt

diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nor.txt b/Documentation/devicetree/bindings/mtd/gpmc-nor.txt
new file mode 100644
index 0000000..8c638fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/gpmc-nor.txt
@@ -0,0 +1,98 @@
+Device tree bindings for NOR flash connect to TI GPMC
+
+NOR flash connected to the TI GPMC (found on OMAP boards) are represented as
+child nodes of the GPMC controller with a name of "nor".
+
+All timing relevant properties as well as generic GPMC child properties are
+explained in a separate documents. Please refer to
+Documentation/devicetree/bindings/bus/ti-gpmc.txt
+
+Required properties:
+- bank-width: 		Width of NOR flash in bytes. GPMC supports 8-bit and
+			16-bit devices and so must be either 1 or 2 bytes.
+- compatible:		Documentation/devicetree/bindings/mtd/mtd-physmap.txt
+- gpmc,cs-on:		Chip-select assertion time
+- gpmc,cs-rd-off:	Chip-select de-assertion time for reads
+- gpmc,cs-wr-off:	Chip-select de-assertion time for writes
+- gpmc,oe-on:		Output-enable assertion time
+- gpmc,oe-off		Output-enable de-assertion time
+- gpmc,we-on:		Write-enable assertion time
+- gpmc,we-off:		Write-enable de-assertion time
+- gpmc,access:		Start cycle to first data capture (read access)
+- gpmc,rd-cycle:	Total read cycle time
+- gpmc,wr-cycle:	Total write cycle time
+- linux,mtd-name:	Documentation/devicetree/bindings/mtd/mtd-physmap.txt
+- reg:			Chip-select, base address (relative to chip-select)
+			and size of NOR flash. Note that base address will be
+			typically 0 as this is the start of the chip-select.
+
+Optional properties:
+- gpmc,XXX		Additional GPMC timings and settings parameters. See
+			Documentation/devicetree/bindings/bus/ti-gpmc.txt
+
+Optional properties for partiton table parsing:
+- #address-cells: should be set to 1
+- #size-cells: should be set to 1
+
+Example:
+
+gpmc: gpmc@6e000000 {
+	compatible = "ti,omap3430-gpmc", "simple-bus";
+	ti,hwmods = "gpmc";
+	reg = <0x6e000000 0x1000>;
+	interrupts = <20>;
+	gpmc,num-cs = <8>;
+	gpmc,num-waitpins = <4>;
+	#address-cells = <2>;
+	#size-cells = <1>;
+
+	ranges = <0 0 0x10000000 0x08000000>;
+
+	nor@0,0 {
+		compatible = "cfi-flash";
+		linux,mtd-name= "intel,pf48f6000m0y1be";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0 0 0x08000000>;
+		bank-width = <2>;
+
+		gpmc,mux-add-data;
+		gpmc,cs-on = <0>;
+		gpmc,cs-rd-off = <186>;
+		gpmc,cs-wr-off = <186>;
+		gpmc,adv-on = <12>;
+		gpmc,adv-rd-off = <48>;
+		gpmc,adv-wr-off = <48>;
+		gpmc,oe-on = <54>;
+		gpmc,oe-off = <168>;
+		gpmc,we-on = <54>;
+		gpmc,we-off = <168>;
+		gpmc,rd-cycle = <186>;
+		gpmc,wr-cycle = <186>;
+		gpmc,access = <114>;
+		gpmc,page-burst-access = <6>;
+		gpmc,bus-turnaround = <12>;
+		gpmc,cycle2cycle-delay = <18>;
+		gpmc,wr-data-mux-bus = <90>;
+		gpmc,wr-access = <186>;
+		gpmc,cycle2cycle-samecsen;
+		gpmc,cycle2cycle-diffcsen;
+
+		partition@0 {
+			label = "bootloader-nor";
+			reg = <0 0x40000>;
+		};
+		partition@0x40000 {
+			label = "params-nor";
+			reg = <0x40000 0x40000>;
+		};
+		partition@0x80000 {
+			label = "kernel-nor";
+			reg = <0x80000 0x200000>;
+		};
+		partition@0x280000 {
+			label = "filesystem-nor";
+			reg = <0x240000 0x7d80000>;
+		};
+	};
+};
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index e822d2b..c217a38 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -26,6 +26,7 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_mtd.h>
 #include <linux/of_device.h>
 #include <linux/mtd/nand.h>
@@ -513,6 +514,37 @@ static int gpmc_cs_delete_mem(int cs)
 	return r;
 }
 
+/**
+ * gpmc_cs_remap - remaps a chip-select physical base address
+ * @cs:		chip-select to remap
+ * @base:	physical base address to re-map chip-select to
+ *
+ * Re-maps a chip-select to a new physical base address specified by
+ * "base". Returns 0 on success and appropriate negative error code
+ * on failure.
+ */
+static int gpmc_cs_remap(int cs, u32 base)
+{
+	int ret;
+	u32 old_base, size;
+
+	if (cs > GPMC_CS_NUM)
+		return -ENODEV;
+	gpmc_cs_get_memconf(cs, &old_base, &size);
+	if (base == old_base)
+		return 0;
+	gpmc_cs_disable_mem(cs);
+	ret = gpmc_cs_delete_mem(cs);
+	if (IS_ERR_VALUE(ret))
+		return ret;
+	ret = gpmc_cs_insert_mem(cs, base, size);
+	if (IS_ERR_VALUE(ret))
+		return ret;
+	gpmc_cs_enable_mem(cs, base, size);
+
+	return 0;
+}
+
 int gpmc_cs_request(int cs, unsigned long size, unsigned long *base)
 {
 	struct resource *res = &gpmc_cs_mem[cs];
@@ -1391,6 +1423,78 @@ static int gpmc_probe_onenand_child(struct platform_device *pdev,
 }
 #endif
 
+/**
+ * gpmc_probe_nor_child - configures the gpmc for a nor device
+ * @pdev:	pointer to gpmc platform device
+ * @child:	pointer to device-tree node for nor device
+ *
+ * Allocates and configures a GPMC chip-select for a NOR flash device.
+ * Returns 0 on success and appropriate negative error code on failure.
+ */
+static int gpmc_probe_nor_child(struct platform_device *pdev,
+				struct device_node *child)
+{
+	struct gpmc_settings gpmc_s;
+	struct gpmc_timings gpmc_t;
+	struct resource res;
+	unsigned long base;
+	int ret, cs;
+
+	if (of_property_read_u32(child, "reg", &cs) < 0) {
+		dev_err(&pdev->dev, "%s has no 'reg' property\n",
+			child->full_name);
+		return -ENODEV;
+	}
+
+	if (of_address_to_resource(child, 0, &res)) {
+		dev_err(&pdev->dev, "%s has malformed 'reg' property\n",
+			child->full_name);
+		return -ENODEV;
+	}
+
+	ret = gpmc_cs_request(cs, res.end - res.start, &base);
+	if (IS_ERR_VALUE(ret)) {
+		dev_err(&pdev->dev, "cannot request GPMC CS %d\n", cs);
+		return ret;
+	}
+
+	/*
+	 * FIXME: gpmc_cs_request() will map the CS to an arbitary
+	 * location in the gpmc address space. When booting with
+	 * device-tree we want the NOR flash to be mapped to the
+	 * location specified in the device-tree blob. So remap the
+	 * CS to this location. Once DT migration is complete should
+	 * just make gpmc_cs_request() map a specific address.
+	 */
+	ret = gpmc_cs_remap(cs, res.start);
+	if (IS_ERR_VALUE(ret)) {
+		dev_err(&pdev->dev, "cannot remap GPMC CS %d to 0x%x\n",
+			cs, res.start);
+		goto err1;
+	}
+
+	gpmc_read_settings_dt(child, &gpmc_s);
+
+	ret = of_property_read_u32(child, "bank-width", &gpmc_s.device_width);
+	if (IS_ERR_VALUE(ret))
+		goto err1;
+
+	ret = gpmc_cs_program_settings(cs, &gpmc_s);
+	if (IS_ERR_VALUE(ret))
+		goto err1;
+
+	gpmc_read_timings_dt(child, &gpmc_t);
+	gpmc_cs_set_timings(cs, &gpmc_t);
+
+	of_platform_device_create(child, NULL, &pdev->dev);
+
+	return 0;
+err1:
+	gpmc_cs_free(cs);
+
+	return ret;
+}
+
 static int gpmc_probe_dt(struct platform_device *pdev)
 {
 	int ret;
@@ -1424,6 +1528,15 @@ static int gpmc_probe_dt(struct platform_device *pdev)
 			return ret;
 		}
 	}
+
+	for_each_node_by_name(child, "nor") {
+		ret = gpmc_probe_nor_child(pdev, child);
+		if (ret < 0) {
+			of_node_put(child);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 #else
-- 
1.7.10.4

