From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] McSPI Slave and DMA,FIFO support
Date: Wed, 20 May 2009 09:10:18 -0700
Message-ID: <20090520161017.GF8308@atomide.com>
References: <54349.10.24.255.18.1242799017.squirrel@dbdmail.itg.ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB030574190F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56341 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754110AbZETQKT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 12:10:19 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030574190F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "V, Hemanth" <hemanthv@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Gadiyar, Anand <gadiyar@ti.com> [090519 23:15]:
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org 
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Hemanth V
> > Sent: Wednesday, May 20, 2009 11:27 AM
> > To: linux-omap@vger.kernel.org
> > Subject: [PATCH 2/2] McSPI Slave and DMA,FIFO support
> > 
> > This patch adds MUX changes for SPI2 and also adds an
> > option for test driver
> > 
> > Signed-off-by: Hemanth V <hemanthv@ti.com>
> > ---
> >  arch/arm/mach-omap2/board-3430sdp.c   |   26 ++++++++++++++++++++++++++
> >  arch/arm/mach-omap2/mux.c             |   11 +++++++++++
> >  arch/arm/plat-omap/include/mach/mux.h |    7 +++++++
> >  3 files changed, 44 insertions(+)
> > 
> > Index: linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp.c
> > ===================================================================
> > --- linux-omap-2.6.orig/arch/arm/mach-omap2/board-3430sdp.c	2009-05-20 11:02:34.000000000 +0530
> > +++ linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp.c	2009-05-20 11:05:22.000000000 +0530
> > @@ -228,6 +228,13 @@
> >  	.single_channel	= 1,	/* 0: slave, 1: master */
> >  };
> > 
> > +#ifdef CONFIG_SPI_DEBUG
> > +static struct omap2_mcspi_device_config dummy_mcspi_config = {
> > +	.turbo_mode	= 0,
> > +	.single_channel	= 1,  /* 0: slave, 1: master */
> > +};
> > +#endif
> > +
> >  static struct spi_board_info sdp3430_spi_board_info[] __initdata = {
> >  	[0] = {
> >  		/*
> > @@ -242,6 +249,18 @@
> >  		.irq			= 0,
> >  		.platform_data		= &tsc2046_config,
> >  	},
> > +#ifdef CONFIG_SPI_DEBUG
> > +	[1] = {
> > +		/* SPI test driver attached to SPI2 controller by
> > +		 * default
> > +		 */
> > +		.modalias		= "spitst",
> > +		.bus_num		= 2,
> > +		.chip_select		= 0,
> > +		.max_speed_hz		= 1500000,
> > +		.controller_data	= &dummy_mcspi_config,
> > +	},
> > +#endif
> >  };
> > 
> >  static struct platform_device sdp3430_lcd_device = {
> > @@ -666,6 +685,13 @@
> > 
> >  static void __init omap_3430sdp_init(void)
> >  {
> > +
> > +	/* SPI2 Pin MUX */
> > +	omap_cfg_reg(AA3_3430_McSPI2_CLK);
> > +	omap_cfg_reg(Y2_3430_McSPI2_SIMO);
> > +	omap_cfg_reg(Y3_3430_McSPI2_SOMI);
> > +	omap_cfg_reg(Y4_3430_McSPI2_CS0);
> > +
> 
> This will still change the padconf for this port unconditionally.
> 
> How do we handle the case where the same platform (SDP in this case)
> could have different configurations McSPI2 vs USBHOST2, etc? Is there
> a clean way, or do we have no option but to use a CONFIG option?

Sounds like a cmdline option would do the trick.

Tony


> 
> - Anand
> 
> 
> >  	omap3430_i2c_init();
> >  	platform_add_devices(sdp3430_devices, ARRAY_SIZE(sdp3430_devices));
> >  	omap_board_config = sdp3430_config;
> > Index: linux-omap-2.6/arch/arm/mach-omap2/mux.c
> > ===================================================================
> > --- linux-omap-2.6.orig/arch/arm/mach-omap2/mux.c	2009-05-20 11:02:34.000000000 +0530
> > +++ linux-omap-2.6/arch/arm/mach-omap2/mux.c	2009-05-20 11:05:22.000000000 +0530
> > @@ -486,6 +486,17 @@
> >  		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
> >  MUX_CFG_34XX("J25_34XX_GPIO170", 0x1c6,
> >  		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
> > +
> > +/* McSPI */
> > +MUX_CFG_34XX("AA3_3430_McSPI2_CLK", 0x1d6,
> > +	OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT)
> > +MUX_CFG_34XX("Y2_3430_McSPI2_SIMO", 0x1d8,
> > +	OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT)
> > +MUX_CFG_34XX("Y3_3430_McSPI2_SOMI", 0x1da,
> > +	OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT)
> > +MUX_CFG_34XX("Y4_3430_McSPI2_CS0", 0x1dc,
> > +	OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLDOWN)
> > +
> >  };
> > 
> >  #define OMAP34XX_PINS_SZ	ARRAY_SIZE(omap34xx_pins)
> > Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/mux.h
> > ===================================================================
> > --- linux-omap-2.6.orig/arch/arm/plat-omap/include/mach/mux.h	2009-05-20 11:02:34.000000000 +0530
> > +++ linux-omap-2.6/arch/arm/plat-omap/include/mach/mux.h	2009-05-20 11:05:22.000000000 +0530
> > @@ -853,6 +853,13 @@
> >  	AE5_34XX_GPIO143,
> >  	H19_34XX_GPIO164_OUT,
> >  	J25_34XX_GPIO170,
> > +
> > +	/* McSPI */
> > +	AA3_3430_McSPI2_CLK,
> > +	Y2_3430_McSPI2_SIMO,
> > +	Y3_3430_McSPI2_SOMI,
> > +	Y4_3430_McSPI2_CS0,
> > +
> >  };
> > 
> >  struct omap_mux_cfg {
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe 
> > linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
