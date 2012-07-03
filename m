From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Subject: Re: v3.5-rc4 doesn't wake from dynamic idle on 3530ES3 Beagle
Date: Tue, 3 Jul 2012 17:10:40 +0530
Message-ID: <CANQgH-aFYnkyeVma6_XRfPZpsAcA55YASpCvpzvWHNymCQ00_A@mail.gmail.com>
References: <alpine.DEB.2.00.1206271101220.27496@utopia.booyaka.com>
	<alpine.DEB.2.00.1206271318070.27496@utopia.booyaka.com>
	<CAMQu2gztSV1qtgea9rL46orqTFR-vQkES5fen4GCqEfBh046-Q@mail.gmail.com>
	<4FF1766A.5060605@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:46176 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750766Ab2GCLkm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jul 2012 07:40:42 -0400
Received: by qcsu28 with SMTP id u28so4172947qcs.8
        for <linux-omap@vger.kernel.org>; Tue, 03 Jul 2012 04:40:41 -0700 (PDT)
In-Reply-To: <4FF1766A.5060605@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, khilman@ti.com, govindraj.raja@ti.com, Felipe Balbi <balbi@ti.com>

On Mon, Jul 2, 2012 at 3:52 PM, Shubhrajyoti <shubhrajyoti@ti.com> wrote:
>
> On Thursday 28 June 2012 11:45 AM, Shilimkar, Santosh wrote:
> > + Shubro, Felipe,
> >
> > On Thu, Jun 28, 2012 at 12:57 AM, Paul Walmsley <paul@pwsan.com> wrote:
> >> On Wed, 27 Jun 2012, Paul Walmsley wrote:
> >>
> >>> Looks like something broke between v3.5-rc3 and v3.5-rc4 with dynamic
> >>> idle on 3530ES3 Beagle.  37xx EVM doesn't seem to be affected.
> >>>
> >>> Taking a closer look now.
> >> Reverting commit 91930652a23de0873a157aa1d9962cb878d64451 ("OMAP2+: UART:
> >> Add mechanism to probe uart pins and configure rx wakeup") makes wakeup
> >> from dynamic retention idle work again.
> >>

Looks like the mux settings are not set in the board file.
So the boot-loader settings could play a role here.
Could you try the below patch. I gave a run on my 3630 beagle-xm



---
 arch/arm/mach-omap2/board-omap3beagle.c |   46 ++++++++++++++++++++++++++++++-
 1 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c
b/arch/arm/mach-omap2/board-omap3beagle.c
index 580fd17..163b23e 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -492,6 +492,50 @@ static void __init beagle_opp_init(void)
 	return;
 }

+#ifdef CONFIG_OMAP_MUX
+
+static struct omap_device_pad serial2_pads[] __initdata = {
+	{
+		.name	= "uart3_rx_irrx.uart3_rx_irrx",
+		.flags	= OMAP_DEVICE_PAD_REMUX,
+		.enable	= OMAP_INPUT_EN | OMAP_MUX_MODE0,
+		.idle	= OMAP_INPUT_EN | OMAP_WAKEUP_EN | OMAP_MUX_MODE0,
+	},
+	{
+		.name	= "uart3_cts_rctx.uart3_cts_rctx",
+		.enable	= OMAP_PIN_INPUT_PULLDOWN | OMAP_MUX_MODE0,
+	},
+	{
+		.name	= "uart3_rts_sd.uart3_rts_sd",
+		.enable	= OMAP_OFF_EN | OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
+	},
+	{
+		.name	= "uart3_tx_irtx.uart3_tx_irtx",
+		.enable	= OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
+	},
+};
+
+static inline void __init board_serial_init(void)
+{
+	struct omap_board_data bdata;
+
+	bdata.flags = 0;
+	bdata.id = 2;
+	bdata.pads = serial2_pads;
+	bdata.pads_cnt = ARRAY_SIZE(serial2_pads);
+	omap_serial_init_port(&bdata, NULL);
+
+}
+
+#else
+
+static inline void __init board_serial_init(void)
+{
+	omap_serial_init();
+}
+
+#endif
+
 static void __init omap3_beagle_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
@@ -511,7 +555,7 @@ static void __init omap3_beagle_init(void)
 	if (gpio_is_valid(beagle_config.dvi_pd_gpio))
 		omap_mux_init_gpio(beagle_config.dvi_pd_gpio, OMAP_PIN_OUTPUT);
 	omap_display_init(&beagle_dss_data);
-	omap_serial_init();
+	board_serial_init();
 	omap_sdrc_init(mt46h32m32lf6_sdrc_params,
 				  mt46h32m32lf6_sdrc_params);

-- 
1.7.5.4
