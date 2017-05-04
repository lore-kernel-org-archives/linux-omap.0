From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] usb: musb: tusb6010_omap: Convert to DMAengine API
Date: Thu, 4 May 2017 14:05:30 -0700
Message-ID: <20170504210529.GB3489@atomide.com>
References: <20170503105645.26759-1-peter.ujfalusi@ti.com>
 <20170503105645.26759-5-peter.ujfalusi@ti.com>
 <20170504194034.GA3489@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170504194034.GA3489@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: b-liu@ti.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@kernel.org, linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [170504 12:43]:
> Hi,
> 
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [170503 04:00]:
> > With the port_window support in DMAengine and the sDMA driver we can
> > convert the driver to DMAengine.
> 
> Actually looks like this patch still has some issues.. Pinging
> the n8x0 with for example ping -s1 causes things to stop working.

Sorry it's actually ping -s2048, not -s1. Here's what happens
on n8x0 with first ping -s2048 with 4/4 applied:

musb-hdrc musb-hdrc.1.auto: Busy rx dma, not using: 00000010
g_ether gadget: invalid EEM CRC
g_ether gadget: invalid EEM CRC
musb-hdrc musb-hdrc.1.auto: ep1 rx dma: 0x86803842 len: 512(512) packet_sz: 512(512)
musb-hdrc musb-hdrc.1.auto: ep1 rx using 16-bit async dma from 0x02000620 to 0x86803842
musb-hdrc musb-hdrc.1.auto: ep1 rx dma callback
musb-hdrc musb-hdrc.1.auto: DMA remaining 448/512
musb-hdrc musb-hdrc.1.auto: Busy rx dma, not using: 000001c0
musb-hdrc musb-hdrc.1.auto: Busy rx dma, not using: 00000008
musb-hdrc musb-hdrc.1.auto: ep1 rx dma: 0x869fdc02 len: 512(512) packet_sz: 512(512)
musb-hdrc musb-hdrc.1.auto: ep1 rx using 16-bit async dma from 0x02000620 to 0x869fdc02
musb-hdrc musb-hdrc.1.auto: ep1 rx dma callback
musb-hdrc musb-hdrc.1.auto: DMA remaining 448/512
musb-hdrc musb-hdrc.1.auto: Busy rx dma, not using: 000001c0
musb-hdrc musb-hdrc.1.auto: Busy rx dma, not using: 00000008
musb-hdrc musb-hdrc.1.auto: ep1 rx dma: 0x869fc642 len: 512(512) packet_sz: 512(512)
musb-hdrc musb-hdrc.1.auto: ep1 rx using 16-bit async dma from 0x02000620 to 0x869fc642
musb-hdrc musb-hdrc.1.auto: ep1 rx dma callback
musb-hdrc musb-hdrc.1.auto: Corrupt rx XFR_SIZE: 0x7ffffec0
musb-hdrc musb-hdrc.1.auto: DMA remaining 0/512
musb-hdrc musb-hdrc.1.auto: Busy rx dma, not using: 7ffffec0
musb-hdrc musb-hdrc.1.auto: Busy rx dma, not using: 00000008
musb-hdrc musb-hdrc.1.auto: Busy rx dma, not using: 00000010
musb-hdrc musb-hdrc.1.auto: Busy rx dma, not using: 7ffffcf0

It seems the hardware dmareq line is not triggering anything
above?

Also with just ping with no size specified, it seems every other
packet is missed or DMA interrupts are not properly triggering
as I'm getting these:

g_ether gadget: invalid EEM CRC

> This is when using only with the async gpmc access as the sync
> gpmc access seems to have a regression not related to this series.
> I'll try to track down that sync gpmc issue as that most likely
> hints to something being wrong in the gpmc code in general.

And this sync gpmc issue seems to be timing related. Setting
DEBUG in tusb6010_omap.c makes it happen easily while without
it it's much harder to trigger. So probably some kind of issue
with GPMC sync timings.

I also found one other issue that might need fixing depending
on the bootloader version, see below.

Regards,

Tony

8< -----------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 4 May 2017 09:35:32 -0700
Subject: [PATCH] ARM: dts: Fix n8x0 tusb6010 dmareq pin muxing

Looks like I forgot to add the device tree pin multiplexing for
tusb6010 on n8x0 when removing legacy platform code. Although the
bootloader sets the pins on n8x0, this may be needed on some n8x0
depending on the bootloader version.

Fixes: 602105ed740d ("ARM: OMAP2+: Remove legacy muxing
for usb-tusb6010.c")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap2420-n8x0-common.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
--- a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
+++ b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
@@ -103,3 +103,19 @@
 		};
 	};
 };
+
+&omap2420_pmx {
+	pinctrl-0 = <&tusb6010_dmareq_pins>;
+	pinctrl-names = "default";
+
+	tusb6010_dmareq_pins: pinmux_tusb6010_dmareq_pins {
+	pinctrl-single,pins = <
+		OMAP2420_CORE_IOPAD(0x0071, PIN_INPUT | MUX_MODE2)	/* gpmc_10.sys_ndmareq5 */
+		OMAP2420_CORE_IOPAD(0x0072, PIN_INPUT | MUX_MODE2)	/* gpmc_9.sys_ndmareq4 */
+		OMAP2420_CORE_IOPAD(0x0073, PIN_INPUT | MUX_MODE2)	/* gpmc_8.sys_ndmareq3 */
+		OMAP2420_CORE_IOPAD(0x0074, PIN_INPUT | MUX_MODE2)	/* gpmc_7.sys_ndmareq1 */
+		OMAP2420_CORE_IOPAD(0x00e5, PIN_INPUT | MUX_MODE2)	/* vlynq_clk.sys_ndmareq0 */
+		OMAP2420_CORE_IOPAD(0x00e6, PIN_INPUT | MUX_MODE2)	/* vlynq_rx1.sys_ndmareq1 */
+		>;
+	};
+};
-- 
2.12.2
