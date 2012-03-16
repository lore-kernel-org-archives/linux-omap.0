From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] of: Add generic device tree DMA helpers
Date: Fri, 16 Mar 2012 09:56:59 +0000
Message-ID: <201203160956.59674.arnd@arndb.de>
References: <4F22DEF2.5000807@ti.com> <4F626180.2010902@ti.com> <20120315215537.GB2842@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:62563 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030799Ab2CPJ5T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Mar 2012 05:57:19 -0400
In-Reply-To: <20120315215537.GB2842@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, grant.likely@secretlab.ca, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, Stephen Warren <swarren@nvidia.com>, linux-omap@vger.kernel.org, Thierry Reding <thierry.reding@avionic-design.de>

On Thursday 15 March 2012, Russell King - ARM Linux wrote:
> Thank you both for missing my point.
> 
> #define OMAP24XX_DMA_SHA1MD5_RX         13      /* S_DMA_12 */
> #define OMAP34XX_DMA_SHA2MD5_RX         13      /* S_DMA_12 */
> 
> #define OMAP242X_DMA_EXT_DMAREQ2        14      /* S_DMA_13 */
> #define OMAP243X_DMA_EXT_DMAREQ3        14      /* S_DMA_13 */
> 
> #define OMAP242X_DMA_EXT_DMAREQ3        15      /* S_DMA_14 */
> #define OMAP24XX_DMA_SPI3_TX0           15      /* S_DMA_14 */
> 
> #define OMAP242X_DMA_EXT_DMAREQ4        16      /* S_DMA_15 */
> #define OMAP24XX_DMA_SPI3_RX0           16      /* S_DMA_15 */
> 
> #define OMAP242X_DMA_EAC_BT_DL_RD       25      /* S_DMA_24 */
> #define OMAP243X_DMA_EXT_DMAREQ4        25      /* S_DMA_24 */
> #define OMAP34XX_DMA_I2C3_TX            25      /* S_DMA_24 */
> 
> Notice the overlap between the different SoCs for the same number on the
> same DMA controller.
> 
> This shouldn't cause problems when all users are within the SoC specific
> file, but those EXT ones would probably be platform specific, and so you
> immediately have a dependence between the platform and the SoC there.
> 
> That dependence can be completely eliminated by other matching schemes
> which are supportable via the DMA engine API.

Ok, so I guess you are worried about the case where you have one .dtsi
include file for the soc and another .dtsi file for the platform, and
you want to generically encode e.g. DMA_EXT_DMAREQ3 in the platform file
so you don't need to write a new .dts file for each combination of that
platform wiht a different soc. Does that describe where you see the
issue?

If so, I would recommend not using a flat numbering scheme for omap,
but have something slightly more complex like a lot of the other
dmagenine drivers do. This binding does not make any assumption about
the meaning of the values, so you can do e.g. three cells for
each channel with a definition like this:

Cell 1: channel class
 Possible values are:
 0 -- raw channel number
 1 -- external channel
 2 -- spi
 3 -- i2c
 4 -- mmc
 to be extended when necessary

Cell 2: instance of this channel
 When Cell 1 is zero, this is just the channel number local to the controller,
 for other values it defines the instance, e.g. ext0, ext1, ext2, ...

Cell 3: DMA direction
 The following values are defined:
 0 -- invalid
 1 -- read
 2 -- write
 3 -- read/write

This specific binding for the omap dma would let you put either a simple channel
into the device tree, or have a high-level description in there. On an OMAP243X,
these two would have the same meaning and a user could put either one in there:

	dma-request = <&dmaengine 0 14 1     /* physical channels 14 (read) */
			&dmaengine 0 15 2>;  /*   and 15 (write)  */

	dma-request = <&dmaengine 1 3 1	     /* external DMA 3 (read) and 4 (write) */
			&dmaengine 1 4 2>;


The cell layout above is just a made-up example, you can basically put everything 
in there that you would put into the arguments to the dma match function. I believe
this is not limited to numbers but can also include phandles and strings. The mapping
from dma classes to physical channels could either be hardcoded in the source for
the dmaengine driver, or get passed in properties of the dmaengine's device_node.

A completely different way to get around the same problem is to define a tree
of virtual dmaengine device nodes, still within the same binding:


	dmaengine-phys: dmaengine {
		compatible = "ti,omap2430-dmaengine", "ti,omap2-dmaengine";
		reg = <0x4a056000 0x1000>;
		#address-cells = <1>; /* physical dma channel number space */		
		#size-cells = <0>;
		#dma-cells = 1;

		dmaengine-ext: dmaengine@2 {
			ranges = <0 2>, <1 3>, <2 7>, <3 14>, <4 25>,
				<5 25> <6 64>;
			#dma-cells = 1;
		};
	};

This way, a device driver could either refer to the physical dmaengine device
and pass
a physical number like

	dma-requests = <&dmaengine-phys 14>;

or to the same effect refer to a child of node of that engine passing a
local number like

	dma-requests = <&dmaengine-ext 3>;

The dmaengine driver in this case can simply use of_translate_address() to
get from channel 3 to 14 using the ranges in the child dmaengine device node.

	Arnd
