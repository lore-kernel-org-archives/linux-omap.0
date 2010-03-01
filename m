From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [RFC part2 v1][PATCH 1/4] omap2/3/4: serial: rename
 omap_serial_init
Date: Mon, 1 Mar 2010 17:26:46 -0600
Message-ID: <A24693684029E5489D1D202277BE894453B61FBC@dlee02.ent.ti.com>
References: <1267469754-10638-1-git-send-email-saaguirre@ti.com>
	<1267469754-10638-2-git-send-email-saaguirre@ti.com>
 <87mxyrbveo.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50449 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370Ab0CAX0t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Mar 2010 18:26:49 -0500
In-Reply-To: <87mxyrbveo.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Monday, March 01, 2010 3:10 PM
> To: Aguirre, Sergio
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [RFC part2 v1][PATCH 1/4] omap2/3/4: serial: rename
> omap_serial_init
>
> Sergio Aguirre <saaguirre@ti.com> writes:
>
> > The name itself doesn't make clear that all UARTs of the platform
> > are going to be initted. This is just to give more awareness of the
> > real action being done here.
> >
> > Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
>
> IMO,  I don't think this adds any more clarity.

OK. But, do you mean that this is clear enough already, or that you have a better suggestion than mine?

The reason I wanted to propose this change is because, you either use:

        omap_serial_init()

or

        omap_serial_init_port(number)

And for me it looked more consistent to have it named omap_serial_init_allports instead...

Regards,
Sergio

>
> Kevin
>
>
> > ---
> >  arch/arm/mach-omap2/board-2430sdp.c          |    2 +-
> >  arch/arm/mach-omap2/board-3430sdp.c          |    2 +-
> >  arch/arm/mach-omap2/board-4430sdp.c          |    2 +-
> >  arch/arm/mach-omap2/board-am3517evm.c        |    2 +-
> >  arch/arm/mach-omap2/board-apollon.c          |    2 +-
> >  arch/arm/mach-omap2/board-cm-t35.c           |    2 +-
> >  arch/arm/mach-omap2/board-devkit8000.c       |    2 +-
> >  arch/arm/mach-omap2/board-generic.c          |    2 +-
> >  arch/arm/mach-omap2/board-h4.c               |    2 +-
> >  arch/arm/mach-omap2/board-igep0020.c         |    2 +-
> >  arch/arm/mach-omap2/board-ldp.c              |    2 +-
> >  arch/arm/mach-omap2/board-n8x0.c             |    2 +-
> >  arch/arm/mach-omap2/board-omap3beagle.c      |    2 +-
> >  arch/arm/mach-omap2/board-omap3evm.c         |    2 +-
> >  arch/arm/mach-omap2/board-omap3pandora.c     |    2 +-
> >  arch/arm/mach-omap2/board-omap3touchbook.c   |    2 +-
> >  arch/arm/mach-omap2/board-overo.c            |    2 +-
> >  arch/arm/mach-omap2/board-rx51.c             |    2 +-
> >  arch/arm/mach-omap2/board-zoom-peripherals.c |    2 +-
> >  arch/arm/mach-omap2/serial.c                 |    8 ++++----
> >  arch/arm/plat-omap/include/plat/serial.h     |    2 +-
> >  21 files changed, 24 insertions(+), 24 deletions(-)
> >  mode change 100755 => 100644 arch/arm/mach-omap2/board-zoom-
> peripherals.c
> >
> > diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-
> omap2/board-2430sdp.c
> > index 01d113f..abc55bc 100644
> > --- a/arch/arm/mach-omap2/board-2430sdp.c
> > +++ b/arch/arm/mach-omap2/board-2430sdp.c
> > @@ -206,7 +206,7 @@ static void __init omap_2430sdp_init(void)
> >     omap2430_i2c_init();
> >
> >     platform_add_devices(sdp2430_devices, ARRAY_SIZE(sdp2430_devices));
> > -   omap_serial_init();
> > +   omap_serial_init_allports();
> >     omap2_hsmmc_init(mmc);
> >     usb_musb_init(&musb_board_data);
> >     board_smc91x_init();
> > diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-
> omap2/board-3430sdp.c
> > index f312b15..8c84973 100644
> > --- a/arch/arm/mach-omap2/board-3430sdp.c
> > +++ b/arch/arm/mach-omap2/board-3430sdp.c
> > @@ -799,7 +799,7 @@ static void __init omap_3430sdp_init(void)
> >     spi_register_board_info(sdp3430_spi_board_info,
> >                             ARRAY_SIZE(sdp3430_spi_board_info));
> >     ads7846_dev_init();
> > -   omap_serial_init();
> > +   omap_serial_init_allports();
> >     usb_musb_init(&musb_board_data);
> >     board_smc91x_init();
> >     sdp_flash_init(sdp_flash_partitions);
> > diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-
> omap2/board-4430sdp.c
> > index 029c6c9..1d47064 100644
> > --- a/arch/arm/mach-omap2/board-4430sdp.c
> > +++ b/arch/arm/mach-omap2/board-4430sdp.c
> > @@ -84,7 +84,7 @@ static struct omap_musb_board_data musb_board_data = {
> >  static void __init omap_4430sdp_init(void)
> >  {
> >     platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
> > -   omap_serial_init();
> > +   omap_serial_init_allports();
> >     /* OMAP4 SDP uses internal transceiver so register nop transceiver
> */
> >     usb_nop_xceiv_register();
> >     /* FIXME: allow multi-omap to boot until musb is updated for omap4
> */
> > diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-
> omap2/board-am3517evm.c
> > index e6b8967..d88b31f 100644
> > --- a/arch/arm/mach-omap2/board-am3517evm.c
> > +++ b/arch/arm/mach-omap2/board-am3517evm.c
> > @@ -300,7 +300,7 @@ static void __init am3517_evm_init(void)
> >     platform_add_devices(am3517_evm_devices,
> >                             ARRAY_SIZE(am3517_evm_devices));
> >
> > -   omap_serial_init();
> > +   omap_serial_init_allports();
> >     usb_ehci_init(&ehci_pdata);
> >     /* DSS */
> >     am3517_evm_display_init();
> > diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-
> omap2/board-apollon.c
> > index aa69fb9..6c14392 100644
> > --- a/arch/arm/mach-omap2/board-apollon.c
> > +++ b/arch/arm/mach-omap2/board-apollon.c
> > @@ -331,7 +331,7 @@ static void __init omap_apollon_init(void)
> >      * if not needed.
> >      */
> >     platform_add_devices(apollon_devices, ARRAY_SIZE(apollon_devices));
> > -   omap_serial_init();
> > +   omap_serial_init_allports();
> >  }
> >
> >  static void __init omap_apollon_map_io(void)
> > diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-
> omap2/board-cm-t35.c
> > index afa77ca..e148835 100644
> > --- a/arch/arm/mach-omap2/board-cm-t35.c
> > +++ b/arch/arm/mach-omap2/board-cm-t35.c
> > @@ -820,7 +820,7 @@ static struct omap_musb_board_data musb_board_data =
> {
> >  static void __init cm_t35_init(void)
> >  {
> >     omap3_mux_init(board_mux, OMAP_PACKAGE_CUS);
> > -   omap_serial_init();
> > +   omap_serial_init_allports();
> >     cm_t35_init_i2c();
> >     cm_t35_init_nand();
> >     cm_t35_init_ads7846();
> > diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-
> omap2/board-devkit8000.c
> > index 3710190..fcc790f 100644
> > --- a/arch/arm/mach-omap2/board-devkit8000.c
> > +++ b/arch/arm/mach-omap2/board-devkit8000.c
> > @@ -659,7 +659,7 @@ static void __init devkit8000_init(void)
> >     spi_register_board_info(devkit8000_spi_board_info,
> >     ARRAY_SIZE(devkit8000_spi_board_info));
> >
> > -   omap_serial_init();
> > +   omap_serial_init_allports();
> >
> >     omap_dm9000_init();
> >
> > diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-
> omap2/board-generic.c
> > index 16cc068..1ae986c 100644
> > --- a/arch/arm/mach-omap2/board-generic.c
> > +++ b/arch/arm/mach-omap2/board-generic.c
> > @@ -44,7 +44,7 @@ static void __init omap_generic_init_irq(void)
> >
> >  static void __init omap_generic_init(void)
> >  {
> > -   omap_serial_init();
> > +   omap_serial_init_allports();
> >  }
> >
> >  static void __init omap_generic_map_io(void)
> > diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-
> h4.c
> > index 0665f2c..8685d24 100644
> > --- a/arch/arm/mach-omap2/board-h4.c
> > +++ b/arch/arm/mach-omap2/board-h4.c
> > @@ -363,7 +363,7 @@ static void __init omap_h4_init(void)
> >
> >     platform_add_devices(h4_devices, ARRAY_SIZE(h4_devices));
> >     omap_usb_init(&h4_usb_config);
> > -   omap_serial_init();
> > +   omap_serial_init_allports();
> >  }
> >
> >  static void __init omap_h4_map_io(void)
> > diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-
> omap2/board-igep0020.c
> > index 9958987..55f6e76 100644
> > --- a/arch/arm/mach-omap2/board-igep0020.c
> > +++ b/arch/arm/mach-omap2/board-igep0020.c
> > @@ -466,7 +466,7 @@ static void __init igep2_init(void)
> >     omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
> >     igep2_i2c_init();
> >     platform_add_devices(igep2_devices, ARRAY_SIZE(igep2_devices));
> > -   omap_serial_init();
> > +   omap_serial_init_allports();
> >     usb_musb_init(&musb_board_data);
> >     usb_ehci_init(&ehci_pdata);
> >
> > diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-
> omap2/board-ldp.c
> > index 5fcb52e..59c53fa 100644
> > --- a/arch/arm/mach-omap2/board-ldp.c
> > +++ b/arch/arm/mach-omap2/board-ldp.c
> > @@ -399,7 +399,7 @@ static void __init omap_ldp_init(void)
> >     spi_register_board_info(ldp_spi_board_info,
> >                             ARRAY_SIZE(ldp_spi_board_info));
> >     ads7846_dev_init();
> > -   omap_serial_init();
> > +   omap_serial_init_allports();
> >     usb_musb_init(&musb_board_data);
> >
> >     omap2_hsmmc_init(mmc);
> > diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-
> omap2/board-n8x0.c
> > index ee548dd..4bcf901 100644
> > --- a/arch/arm/mach-omap2/board-n8x0.c
> > +++ b/arch/arm/mach-omap2/board-n8x0.c
> > @@ -146,7 +146,7 @@ static void __init n8x0_init_machine(void)
> >     spi_register_board_info(n800_spi_board_info,
> >                             ARRAY_SIZE(n800_spi_board_info));
> >
> > -   omap_serial_init();
> > +   omap_serial_init_allports();
> >     n8x0_onenand_init();
> >  }
> >
> > diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-
> omap2/board-omap3beagle.c
> > index 6eb77e1..f5b8106 100644
> > --- a/arch/arm/mach-omap2/board-omap3beagle.c
> > +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> > @@ -442,7 +442,7 @@ static void __init omap3_beagle_init(void)
> >     omap3_beagle_i2c_init();
> >     platform_add_devices(omap3_beagle_devices,
> >                     ARRAY_SIZE(omap3_beagle_devices));
> > -   omap_serial_init();
> > +   omap_serial_init_allports();
> >
> >     omap_mux_init_gpio(170, OMAP_PIN_INPUT);
> >     gpio_request(170, "DVI_nPD");
> > diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-
> omap2/board-omap3evm.c
> > index d6bc88c..bd87fce 100644
> > --- a/arch/arm/mach-omap2/board-omap3evm.c
> > +++ b/arch/arm/mach-omap2/board-omap3evm.c
> > @@ -680,7 +680,7 @@ static void __init omap3_evm_init(void)
> >     spi_register_board_info(omap3evm_spi_board_info,
> >                             ARRAY_SIZE(omap3evm_spi_board_info));
> >
> > -   omap_serial_init();
> > +   omap_serial_init_allports();
> >
> >     /* OMAP3EVM uses ISP1504 phy and so register nop transceiver */
> >     usb_nop_xceiv_register();
> > diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-
> omap2/board-omap3pandora.c
> > index 4827f46..29bc03b 100644
> > --- a/arch/arm/mach-omap2/board-omap3pandora.c
> > +++ b/arch/arm/mach-omap2/board-omap3pandora.c
> > @@ -569,7 +569,7 @@ static void __init omap3pandora_init(void)
> >     omap3pandora_i2c_init();
> >     platform_add_devices(omap3pandora_devices,
> >                     ARRAY_SIZE(omap3pandora_devices));
> > -   omap_serial_init();
> > +   omap_serial_init_allports();
> >     spi_register_board_info(omap3pandora_spi_board_info,
> >                     ARRAY_SIZE(omap3pandora_spi_board_info));
> >     omap3pandora_ads7846_init();
> > diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-
> omap2/board-omap3touchbook.c
> > index 3943d0f..cfb555d 100644
> > --- a/arch/arm/mach-omap2/board-omap3touchbook.c
> > +++ b/arch/arm/mach-omap2/board-omap3touchbook.c
> > @@ -540,7 +540,7 @@ static void __init omap3_touchbook_init(void)
> >     omap3_touchbook_i2c_init();
> >     platform_add_devices(omap3_touchbook_devices,
> >                     ARRAY_SIZE(omap3_touchbook_devices));
> > -   omap_serial_init();
> > +   omap_serial_init_allports();
> >
> >     omap_mux_init_gpio(170, OMAP_PIN_INPUT);
> >     gpio_request(176, "DVI_nPD");
> > diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-
> omap2/board-overo.c
> > index 50872a4..de44cd9 100644
> > --- a/arch/arm/mach-omap2/board-overo.c
> > +++ b/arch/arm/mach-omap2/board-overo.c
> > @@ -424,7 +424,7 @@ static void __init overo_init(void)
> >     omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
> >     overo_i2c_init();
> >     platform_add_devices(overo_devices, ARRAY_SIZE(overo_devices));
> > -   omap_serial_init();
> > +   omap_serial_init_allports();
> >     overo_flash_init();
> >     usb_musb_init(&musb_board_data);
> >     usb_ehci_init(&ehci_pdata);
> > diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-
> omap2/board-rx51.c
> > index b155c36..b556efe 100644
> > --- a/arch/arm/mach-omap2/board-rx51.c
> > +++ b/arch/arm/mach-omap2/board-rx51.c
> > @@ -129,7 +129,7 @@ static struct omap_musb_board_data musb_board_data =
> {
> >  static void __init rx51_init(void)
> >  {
> >     omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
> > -   omap_serial_init();
> > +   omap_serial_init_allports();
> >     usb_musb_init(&musb_board_data);
> >     rx51_peripherals_init();
> >
> > diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c
> b/arch/arm/mach-omap2/board-zoom-peripherals.c
> > old mode 100755
> > new mode 100644
> > index ca95d8d..a1011ee
> > --- a/arch/arm/mach-omap2/board-zoom-peripherals.c
> > +++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
> > @@ -280,7 +280,7 @@ static void enable_board_wakeup_source(void)
> >  void __init zoom_peripherals_init(void)
> >  {
> >     omap_i2c_init();
> > -   omap_serial_init();
> > +   omap_serial_init_allports();
> >     usb_musb_init(&musb_board_data);
> >     enable_board_wakeup_source();
> >  }
> > diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> > index c3bad91..234da5d 100644
> > --- a/arch/arm/mach-omap2/serial.c
> > +++ b/arch/arm/mach-omap2/serial.c
> > @@ -710,10 +710,10 @@ void __init omap_serial_early_init(void)
> >   * @port: serial port number (0-3)
> >   *
> >   * This function initialies serial driver for given @port only.
> > - * Platforms can call this function instead of omap_serial_init()
> > + * Platforms can call this function instead of
> omap_serial_init_allports()
> >   * if they don't plan to use all available UARTs as serial ports.
> >   *
> > - * Don't mix calls to omap_serial_init_port() and omap_serial_init(),
> > + * Don't mix calls to omap_serial_init_port() and
> omap_serial_init_allports(),
> >   * use only one of the two.
> >   */
> >  void __init omap_serial_init_port(int port)
> > @@ -765,13 +765,13 @@ void __init omap_serial_init_port(int port)
> >  }
> >
> >  /**
> > - * omap_serial_init() - intialize all supported serial ports
> > + * omap_serial_init_allports() - intialize all supported serial ports
> >   *
> >   * Initializes all available UARTs as serial ports. Platforms
> >   * can call this function when they want to have default behaviour
> >   * for serial ports (e.g initialize them all as serial ports).
> >   */
> > -void __init omap_serial_init(void)
> > +void __init omap_serial_init_allports(void)
> >  {
> >     int i, nr_ports;
> >
> > diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-
> omap/include/plat/serial.h
> > index 83dce4c..f6a1688 100644
> > --- a/arch/arm/plat-omap/include/plat/serial.h
> > +++ b/arch/arm/plat-omap/include/plat/serial.h
> > @@ -80,7 +80,7 @@
> >
> >  #ifndef __ASSEMBLER__
> >  extern void __init omap_serial_early_init(void);
> > -extern void omap_serial_init(void);
> > +extern void omap_serial_init_allports(void);
> >  extern void omap_serial_init_port(int port);
> >  extern int omap_uart_can_sleep(void);
> >  extern void omap_uart_check_wakeup(void);
> > --
> > 1.6.3.3
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
