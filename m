From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH 5/12] OMAP3430 support in mach-omap2 folder
Date: Fri, 1 Jun 2007 11:51:16 +0530
Message-ID: <5d5443650705312321m4b381090yec02078b45d0540c@mail.gmail.com>
References: <9C23CDD79DA20A479D4615857B2E2C4701063213@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C4701063213@dlee13.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On 5/31/07, Syed Mohammed, Khasim <x0khasim@ti.com> wrote:
> Adding OMAP 3430 support to arch/arm/mach-omap2
>
> Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>
>
> Files:
>  Kconfig         |   14 ++
>  Makefile        |    6 -
>  board-3430sdp.c |  301
>  clock.h         |    1
>  gpmc.c          |    8 -
>  id.c            |   23 ++--
>  irq.c           |   20 ++-
>  7 files changed, 350 insertions(+), 23 deletions(-)

...

>
> > +/*
> + * linux/arch/arm/mach-omap2/board-3430sdp.c
> + *
> + * Copyright (C) 2007 Texas Instruments
> + *
> + * Modified from mach-omap2/board-generic.c
> + *
> + * Initial code: Syed Mohammed Khasim
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */

....

> +
> +
> +static struct resource sdp3430_smc91x_resources[] = {
> +       [0] = {
> +               .start  = OMAP34XX_ETHR_START,
> +               .end    = OMAP34XX_ETHR_START + SZ_4K,
> +               .flags          = IORESOURCE_MEM,
> +                 },
> +       [1] = {
> +               .start          = OMAP_GPIO_IRQ(OMAP34XX_ETHR_GPIO_IRQ),
> +               .end    = 0,
> +               .flags          = IORESOURCE_IRQ,
> +                 },
> +};
> +
> +static struct platform_device sdp3430_smc91x_device = {
> +       .name           = "smc91x",
> +       .id             = -1,
> +       .num_resources  = ARRAY_SIZE(sdp3430_smc91x_resources),
> +       .resource       = sdp3430_smc91x_resources,
> +};
> +
> +#ifdef CONFIG_USB_MUSB_HDRC
> +static struct resource musb_resources[] = {
> +       [0] = {
> +                .start = OMAP343X_HS_BASE,
> +                .end   = OMAP343X_HS_BASE + SZ_8K,
> +                .flags = IORESOURCE_MEM,
> +                 },
> +       [1] = { /* general IRQ */
> +                .start = INT_HS_USB_MC_NINT,
> +                .flags = IORESOURCE_IRQ,
> +                 },
> +       [2] = {         /* DMA IRQ */
> +                .start = INT_HS_USB_DMA_NINT,
> +                .flags = IORESOURCE_IRQ,
> +                 },
> +};
> +
> +static struct musb_hdrc_platform_data musb_plat = {
> +#ifdef CONFIG_USB_MUSB_OTG
> +       .mode           = MUSB_OTG,
> +#elif CONFIG_USB_MUSB_HDRC_HCD
> +       .mode           = MUSB_HOST,
> +#elif CONFIG_USB_GADGET_MUSB_HDRC
> +       .mode           = MUSB_PERIPHERAL,
> +#endif
> +       .multipoint     = 1,
> +};
> +
> +static u64 musb_dmamask = ~(u32)0;
> +
> +static struct platform_device musb_device = {
> +       .name           = "musb_hdrc",
> +       .id             = 0,
> +       .dev = {
> +               .dma_mask               = &musb_dmamask,
> +               .coherent_dma_mask      = 0xffffffff,
> +               .platform_data          = &musb_plat,
> +       },
> +       .num_resources  = ARRAY_SIZE(musb_resources),
> +       .resource       = musb_resources,
> +};
> +#endif /* CONFIG_USB_MUSB_HDRC */
> +static struct platform_device *sdp3430_devices[] __initdata = {
> +       &sdp3430_smc91x_device,
> +       &sdp3430_flash_device,
> +#ifdef CONFIG_USB_MUSB_HDRC
> +       &musb_device,
> +#endif
> +};
> +#if    defined(CONFIG_USB_OMAP24XX_FS_PORT0)
> +static struct omap_usb_config fsusb_otg0_config __initdata = {
> +       /* usb0 has a Mini-AB port and external isp1301 transceiver */
> +       .otg            = 1,
> +
> +#ifdef CONFIG_USB_GADGET_OMAP
> +       .hmc_mode       = 0x0,  // 0:dev/otg 1:disabled 2:disabled
> +
> +#elif  defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
> +       .hmc_mode       = 0x1,  // 0:host|otg 1:host 2:host
> +#endif
> +
> +       .pins[0]        = 3,
> +};
> +
> +#elif  defined(CONFIG_USB_OMAP24XX_FS_PORT1)
> +static struct omap_usb_config fsusb_host1_config __initdata = {
> +       .register_host  = 1,
> +       .hmc_mode       = 0x1,  // 0:host|otg 1:host 2:host
> +       .pins[1]        = 3,
> +};
> +#endif
> +
> +static inline void __init sdp3430_init_smc91x(void)

Rename this to sdp3430_init_debug like H4.

> +{
> +       int eth_cs;
> +       unsigned long cs_mem_base;
> +       unsigned int rate;
> +       struct clk *l3ck;
> +
> +       eth_cs  = SDP3430_SMC91X_CS;
> +
> +       l3ck = clk_get(NULL, "core_l3_ck");
> +       if (IS_ERR(l3ck))
> +               rate = 100000000;
> +       else
> +               rate = clk_get_rate(l3ck);
> +
> +       if (gpmc_cs_request(eth_cs, SZ_16M, &cs_mem_base) < 0) {
> +               printk(KERN_ERR "Failed to request GPMC mem for smc91x\n");
> +               return;
> +       }
> +
> +       sdp3430_smc91x_resources[0].start = cs_mem_base + 0x0;
> +       sdp3430_smc91x_resources[0].end   = cs_mem_base + 0xf;
> +       udelay(100);
> +       if (omap_request_gpio(OMAP34XX_ETHR_GPIO_IRQ) < 0) {
> +               printk(KERN_ERR "Failed to request GPIO%d for smc91x IRQ\n",
> +                       OMAP34XX_ETHR_GPIO_IRQ);
> +               return;
> +       }
> +       omap_set_gpio_direction(OMAP34XX_ETHR_GPIO_IRQ, 1);
> +}

We have now common debug card interface. Check
arch/arm/plat-omap/debug-devices.c and do similar calls like
board-h4.c {debug_card_init}.

-- 
--Trilok Soni
