From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/8] ARM: dts: Add basic support for TMDSEVM3730
 (Mistral AM/DM37x EVM)
Date: Tue, 15 Oct 2013 11:43:32 -0700
Message-ID: <20131015184306.GC11234@atomide.com>
References: <20131010221833.9063.49904.stgit@localhost>
 <20131010222053.9063.81702.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56837 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759361Ab3JOSne (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Oct 2013 14:43:34 -0400
Content-Disposition: inline
In-Reply-To: <20131010222053.9063.81702.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [131010 15:29]:
> I've tested the serial, MMC, smsc911x, wl12xx, and off-idle support
> with the pinctrl patches, so it probably works better than the
> board-*.c files ever did. Also the board-omap3evm.c file is broken
> for the DSS, and has been for a while. Patches are welcome to fix
> it in this .dts file, let's just drop the board-*.c file for this.

Oops, the NAND I did not test and the copied partition map is
different from the board file. Here's the updated partition map.
I've tested the NAND using ubifs on the last partition.

I'm folding in the following fix as I did not push it out yet.

Regards,

Tony


--- a/arch/arm/boot/dts/omap3-evm-37xx.dts
+++ b/arch/arm/boot/dts/omap3-evm-37xx.dts
@@ -94,7 +94,7 @@
 		 <5 0 0x2c000000 0x01000000>;
 
 	nand@0,0 {
-		linux,mtd-name= "micron,mt29c4g96maz";
+		linux,mtd-name= "hynix,h8kds0un0mer-4em";
 		reg = <0 0 0>;
 		nand-bus-width = <16>;
 		ti,nand-ecc-opt = "bch8";
@@ -118,24 +118,24 @@
 		#size-cells = <1>;
 
 		partition@0 {
-			label = "SPL";
-			reg = <0 0x100000>;
+			label = "X-Loader";
+			reg = <0 0x80000>;
 		};
 		partition@0x80000 {
 			label = "U-Boot";
-			reg = <0x100000 0x180000>;
+			reg = <0x80000 0x1c0000>;
 		};
 		partition@0x1c0000 {
 			label = "Environment";
-			reg = <0x280000 0x100000>;
+			reg = <0x240000 0x40000>;
 		};
 		partition@0x280000 {
 			label = "Kernel";
-			reg = <0x380000 0x300000>;
+			reg = <0x280000 0x500000>;
 		};
 		partition@0x780000 {
 			label = "Filesystem";
-			reg = <0x680000 0x1f980000>;
+			reg = <0x780000 0x1f880000>;
 		};
 	};
 
