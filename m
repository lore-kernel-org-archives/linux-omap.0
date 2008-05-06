From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH 2/2] OMAP3 EVM: add touchscreen support
Date: Tue, 6 May 2008 07:16:30 -0700
Message-ID: <5e088bd90805060716hd3b6b91mc005fc12b6fe24cc@mail.gmail.com>
References: <5e088bd90804301232k5a442506oc9f355c0716add43@mail.gmail.com>
	 <20080502231537.GW8981@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.191]:49562 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653AbYEFOQc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 May 2008 10:16:32 -0400
Received: by mu-out-0910.google.com with SMTP id w8so237139mue.1
        for <linux-omap@vger.kernel.org>; Tue, 06 May 2008 07:16:30 -0700 (PDT)
In-Reply-To: <20080502231537.GW8981@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony,

>  >  #define TWL4030_IRQNUM               INT_34XX_SYS_NIRQ
>
>  And this should really be OMAP3_TWL4030_IRQNUM defined in 34xx.h.

I noticed that in another thread you asked Nishant Kamat to submit
this as a separate general patch for all boards that use this define.

Would you prefer that I wait for him to do this before resubmitting,
or should I resubmit now?

Steve

On Fri, May 2, 2008 at 4:15 PM, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
>
>  This patch should be first one in the series as you cannot really
>  enable it in the .config before this patch.
>
>  Also see some comments below.
>
>  * Steve Sakoman <sakoman@gmail.com> [080430 12:35]:
>
>
> > From: Steve Sakoman <steve@sakoman.com>
>  >
>  > Add touchscreen support for OMAP3 EVM
>  >
>  > Signed-off-by: Steve Sakoman <steve@sakoman.com>
>  > ---
>  >  arch/arm/mach-omap2/board-omap3evm.c       |   42 +++++++++++++++++++++++++++++
>  >  include/asm-arm/arch-omap/board-omap3evm.h |    1
>  >  2 files changed, 43 insertions(+)
>  > diff -uprN -X a/Documentation/dontdiff
>  > a/arch/arm/mach-omap2/board-omap3evm.c
>  > b/arch/arm/mach-omap2/board-omap3evm.c
>  > --- a/arch/arm/mach-omap2/board-omap3evm.c    2008-04-28 21:03:22.000000000 -0700
>  > +++ b/arch/arm/mach-omap2/board-omap3evm.c    2008-04-28 21:16:35.000000000 -0700
>  > @@ -19,6 +19,8 @@
>  >  #include <linux/err.h>
>  >  #include <linux/clk.h>
>  >  #include <linux/io.h>
>  > +#include <linux/spi/spi.h>
>  > +#include <linux/spi/ads7846.h>
>  >
>  >  #include <asm/hardware.h>
>  >  #include <asm/mach-types.h>
>  > @@ -31,6 +33,7 @@
>  >  #include <asm/arch/usb-musb.h>
>  >  #include <asm/arch/usb-ehci.h>
>  >  #include <asm/arch/common.h>
>  > +#include <asm/arch/mcspi.h>
>  >
>  >  static struct omap_uart_config omap3_evm_uart_config __initdata = {
>  >       .enabled_uarts  = ((1 << 0) | (1 << 1) | (1 << 2)),
>  > @@ -65,6 +68,44 @@
>  >       .id             = -1,
>  >  };
>  >
>  > +static void ads7846_dev_init(void)
>  > +{
>  > +     if (omap_request_gpio(TS_GPIO) < 0)
>  > +             printk(KERN_ERR "can't get ads7846 pen down GPIO\n");
>  > +
>  > +     omap_set_gpio_direction(TS_GPIO, 1);
>  > +
>  > +     omap_set_gpio_debounce(TS_GPIO, 1);
>  > +     omap_set_gpio_debounce_time(TS_GPIO, 0xa);
>  > +}
>  > +
>  > +static int ads7846_get_pendown_state(void)
>  > +{
>  > +     return !omap_get_gpio_datain(TS_GPIO);
>  > +}
>  > +
>  > +struct ads7846_platform_data ads7846_config = {
>  > +     .get_pendown_state      = ads7846_get_pendown_state,
>  > +     .keep_vref_on           = 1,
>  > +};
>  > +
>  > +static struct omap2_mcspi_device_config ads7846_mcspi_config = {
>  > +     .turbo_mode     = 0,
>  > +     .single_channel = 1,  /* 0: slave, 1: master */
>  > +};
>  > +
>  > +struct spi_board_info omap3evm_spi_board_info[] = {
>  > +     [0] = {
>  > +             .modalias               = "ads7846",
>  > +             .bus_num                = 1,
>  > +             .chip_select            = 0,
>  > +             .max_speed_hz           = 1500000,
>  > +             .controller_data        = &ads7846_mcspi_config,
>  > +             .irq                    = OMAP_GPIO_IRQ(TS_GPIO),
>  > +             .platform_data          = &ads7846_config,
>  > +     },
>  > +};
>  > +
>  >  static void __init omap3_evm_init_irq(void)
>  >  {
>  >       omap2_init_common_hw();
>  > @@ -90,6 +90,10 @@ static void __init omap3_evm_init(void)
>  >       platform_add_devices(omap3_evm_devices, ARRAY_SIZE(omap3_evm_devices));
>  >       omap_board_config = omap3_evm_config;
>  >       omap_board_config_size = ARRAY_SIZE(omap3_evm_config);
>  > +
>  > +     spi_register_board_info(omap3evm_spi_board_info,
>  > +                             ARRAY_SIZE(omap3evm_spi_board_info));
>  > +
>  >       omap_serial_init();
>  >       hsmmc_init();
>  >       usb_musb_init();
>  > @@ -95,6 +136,7 @@
>  >       usb_musb_init();
>  >       usb_ehci_init();
>  >       omap3evm_flash_init();
>  > +     ads7846_dev_init();
>  >  }
>  >
>  >  arch_initcall(omap3_evm_i2c_init);
>  > diff -uprN -X a/Documentation/dontdiff
>  > a/include/asm-arm/arch-omap/board-omap3evm.h
>  > b/include/asm-arm/arch-omap/board-omap3evm.h
>  > --- a/include/asm-arm/arch-omap/board-omap3evm.h      2008-04-28
>  > 21:03:19.000000000 -0700
>  > +++ b/include/asm-arm/arch-omap/board-omap3evm.h      2008-04-28
>  > 21:11:29.000000000 -0700
>  > @@ -31,6 +31,7 @@
>  >
>  >  extern void omap3evm_flash_init(void);
>  >
>  > +#define TS_GPIO              175
>
>  This should be OMAP3_EVM_TS_GPIO or similar. Otherwise things will
>  get redefined when compiling in support for multiple boards.
>
>
>  >  #define TWL4030_IRQNUM               INT_34XX_SYS_NIRQ
>
>  And this should really be OMAP3_TWL4030_IRQNUM defined in 34xx.h.
>
>  Tony
>
>
>  >
>  >  #define ONENAND_MAP          0x20000000
>  > --
>  > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>  > the body of a message to majordomo@vger.kernel.org
>  > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
