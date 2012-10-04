From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: ttyO2 broken on IGEPv2 on 3.3, 3.4-rc5 or arm-soc/for-next,
 working on 3.2
Date: Thu, 4 Oct 2012 18:07:47 +0200
Message-ID: <20121004180747.3b342904@skate>
References: <20120504155255.140b4e3f@skate>
	<87397fewso.fsf@ti.com>
	<20120504175124.GI5613@atomide.com>
	<878vh78q7b.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:43877 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757016Ab2JDQIF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 12:08:05 -0400
In-Reply-To: <878vh78q7b.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Enric Balletbo i Serra <eballetbo@iseebcn.com>, Gregory =?UTF-8?B?Q2zDqW1lbnQ=?= <gregory.clement@free-electrons.com>, Michael Opdenacker <michael.opdenacker@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>

Kevin,

Reviving an old thread.

On Fri, 04 May 2012 16:46:32 -0700, Kevin Hilman wrote:

> >> Thomas Petazzoni <thomas.petazzoni@free-electrons.com> writes:
> >> 
> >> > I have an IGEPv2 revision 6 board, which uses the DM3730 OMAP3.
> >> > With 3.2 omap2plus_defconfig, the system boots fine and have a
> >> > working shell on ttyO2. On either 3.3, 3.4-rc5 or
> >> > arm-soc/for-next from Arnd, the system boots all the way up to
> >> > showing the shell prompt, but I can't type any character, as if
> >> > UART RX was broken.
> >> 
> >> On v3.4-rc, can you see if reverting
> >> bce492c04ba8fc66a4ea0a52b181ba255daaaf54 has any effect?
> >> 
> >> That patch had some unfortunate side effects, but I haven't seen
> >> the problem you see, so I'm not sure if it's related.
> >
> > Reverting bce492c04ba8fc66a4ea0a52b181ba255daaaf54 is a broken
> > solution like you mentioned. But if it helps, then the proper fix
> > is to add muxing to board-*.c files for the uart pins and use
> > omap_serial_init_port for each uart instead of omap_serial_init.
> > That should fix the wake-up issues too.
> 
> I agree on the final solution, but just wanted to see if the missing
> mux (and thus disabled runtime PM) is what's causing the problem.

FWIW, I tried the recently released 3.6 kernel on this platform
(IGEPv2, OMAP3-based), and I still see the same problem. Upon Tony's
suggestion, I tried to add some code in board-igep0020.c similar to the
one in board-n8x0.c to do the appropriate UART2 muxing, but it doesn't
seem to improve the situation. I did the following change (note that I
tried with both .name = "uart2_rx_irrx.uart2_rx_irrx" and .name =
"uart3_rx_irrx.uart3_rx_irrx"). On this board, the console is on ttyO2.
This is with the plain omap2plus_defconfig, so CONFIG_OMAP_MUX is
enabled.

Any idea of things to try? This board has been broken since 3.2, so I'd
like to get it fixed at some point :-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 2821448..568f13e 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -558,6 +558,43 @@ static struct omap_board_mux board_mux[] __initdata = {
 	OMAP3_MUX(MCSPI1_CS2, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
+
+static struct omap_device_pad serial2_pads[] __initdata = {
+	{
+		.name	= "uart2_rx_irrx.uart2_rx_irrx",
+		.flags	= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
+		.enable	= OMAP_MUX_MODE0,
+		.idle	= OMAP_MUX_MODE3	/* Mux as GPIO for idle */
+	},
+};
+
+static inline void board_serial_init(void)
+{
+	struct omap_board_data bdata;
+
+	bdata.flags = 0;
+	bdata.pads = NULL;
+	bdata.pads_cnt = 0;
+
+	bdata.id = 0;
+	omap_serial_init_port(&bdata, NULL);
+
+	bdata.id = 1;
+	omap_serial_init_port(&bdata, NULL);
+
+	bdata.id = 2;
+	bdata.pads = serial2_pads;
+	bdata.pads_cnt = ARRAY_SIZE(serial2_pads);
+	omap_serial_init_port(&bdata, NULL);
+}
+
+#else
+
+static inline void board_serial_init(void)
+{
+	omap_serial_init();
+}
+
 #endif
 
 #if defined(CONFIG_LIBERTAS_SDIO) || defined(CONFIG_LIBERTAS_SDIO_MODULE)
@@ -621,7 +658,7 @@ static void __init igep_init(void)
 	/* Register I2C busses and drivers */
 	igep_i2c_init();
 	platform_add_devices(igep_devices, ARRAY_SIZE(igep_devices));
-	omap_serial_init();
+	board_serial_init();
 	omap_sdrc_init(m65kxxxxam_sdrc_params,
 				  m65kxxxxam_sdrc_params);
 	usb_musb_init(NULL);



-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
