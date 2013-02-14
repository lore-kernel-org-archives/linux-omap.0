From: Mark Jackson <mpfj-list@mimc.co.uk>
Subject: AM335x : placing NAND @ address 0x0
Date: Thu, 14 Feb 2013 11:59:44 +0000
Message-ID: <511CD1B0.7020609@mimc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mercuryimc.plus.com ([80.229.200.144]:46393 "EHLO
	centos1.newflow.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758994Ab3BNL7p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Feb 2013 06:59:45 -0500
Received: from [10.0.0.102] (unknown [10.0.0.102])
	by centos1.newflow.co.uk (Postfix) with ESMTP id 86EAA26B8035
	for <linux-omap@vger.kernel.org>; Thu, 14 Feb 2013 11:59:44 +0000 (GMT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I'm hitting an issue where I want to register my GPMC connected NAND on CS0 at address 0x0.

Here's the relevant error from the boot messages:-

[    0.293834] omap-gpmc gpmc.3: GPMC revision 6.0
[    0.294175] omap-gpmc gpmc.3: failed to reserve memory
[    0.294267] omap-gpmc: probe of gpmc.3 failed with error -16

The chip select and base address have already been setup under U-Boot and it appears to work fine
(i.e. U-Boot can see the device).

Am I not allowed to place the NAND at address 0x0 ?  If not, why not ?

The GPMC section of my .dts file is shown below.

Cheers
Mark J.

---
		gpmc: gpmc@50000000 {
			compatible = "ti,am3352-gpmc", "simple-bus";
			ti,hwmods = "gpmc";
			status = "okay";
			#address-cells = <2>;
			#size-cells = <1>;
			ranges = <0 0 0x01000000 0x10000000>;	/* CS0: NAND 256M */

			nand@0,0 {
				reg = <0 0 0x10000000>; /* CS0, offset 0 */
				nand-bus-width = <8>;
				ti,nand-ecc-opt = "bch8";

				gpmc,sync-clk = <0>;
				gpmc,cs-on = <0>;
				gpmc,cs-rd-off = <44>;
				gpmc,cs-wr-off = <44>;
				gpmc,adv-on = <6>;
				gpmc,adv-rd-off = <34>;
				gpmc,adv-wr-off = <44>;
				gpmc,we-off = <40>;
				gpmc,oe-off = <54>;
				gpmc,access = <64>;
				gpmc,rd-cycle = <82>;
				gpmc,wr-cycle = <82>;
				gpmc,wr-access = <40>;
				gpmc,wr-data-mux-bus = <0>;

				#address-cells = <1>;
				#size-cells = <1>;
				elm_id = <&elm>;

				/* MTD partition table */
				partition@1 {
					label = "boot";
					reg = <0x00000000 0x00100000>; /* 1MB */
				};

				partition@2 {
					label = "rootfs";
					reg = <0x00100000 0x04000000>; /* 64MB */
				};

				partition@3 {
					label = "data";
					reg = <0x04100000 0x0bf00000>; /* 191MB */
				};
			};
		};
