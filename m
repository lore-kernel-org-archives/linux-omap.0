From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 4/7] [RFC] OMAP: hwmod implementation for MCBSP
Date: Wed, 6 Oct 2010 11:34:39 +0200
Message-ID: <4CAC42AF.2040405@ti.com>
References: <1286296662-7639-1-git-send-email-kishon@ti.com> <1286296662-7639-4-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55925 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932408Ab0JFJem (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Oct 2010 05:34:42 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o969Yg17010695
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 6 Oct 2010 04:34:42 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id o969Yf8I024897
	for <linux-omap@vger.kernel.org>; Wed, 6 Oct 2010 04:34:41 -0500 (CDT)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o969YfYI012132
	for <linux-omap@vger.kernel.org>; Wed, 6 Oct 2010 04:34:41 -0500 (CDT)
In-Reply-To: <1286296662-7639-4-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kamat, Nishant" <nskamat@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "Basak, Partha" <p-basak2@ti.com>

On 10/5/2010 6:37 PM, Kishon Vijay Abraham I wrote:
> Signed-off-by: Kishon Vijay Abraham I<kishon@ti.com>
> Signed-off-by: Charulatha V<charu@ti.com>
> Signed-off-by: Shubhrajyoti D<shubhrajyoti@ti.com>
> Cc: Partha Basak<p-basak2@ti.com>
> ---
>   arch/arm/mach-omap2/mcbsp.c             |  251 +++++++++----------------------
>   arch/arm/plat-omap/include/plat/mcbsp.h |    6 +-
>   arch/arm/plat-omap/mcbsp.c              |  189 +++++++++++-------------
>   3 files changed, 159 insertions(+), 287 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
> index eba9fa1..25c6703 100644
> --- a/arch/arm/mach-omap2/mcbsp.c
> +++ b/arch/arm/mach-omap2/mcbsp.c
> @@ -22,9 +22,13 @@
>   #include<plat/dma.h>
>   #include<plat/cpu.h>
>   #include<plat/mcbsp.h>
> +#include<plat/omap_hwmod.h>
> +#include<plat/omap_device.h>
>
>   #include "control.h"
>
> +static struct omap_hwmod *oh_st_device[] = {NULL, NULL};
> +static int no_of_st;
>
>   /* McBSP internal signal muxing functions */
>
> @@ -101,199 +105,90 @@ int omap2_mcbsp_set_clks_src(u8 id, u8 fck_src_id)
>   }
>   EXPORT_SYMBOL(omap2_mcbsp_set_clks_src);
>
> -
> -/* Platform data */
> -
> -#ifdef CONFIG_ARCH_OMAP2420
> -static struct omap_mcbsp_platform_data omap2420_mcbsp_pdata[] = {
> -       {
> -               .phys_base      = OMAP24XX_MCBSP1_BASE,
> -               .dma_rx_sync    = OMAP24XX_DMA_MCBSP1_RX,
> -               .dma_tx_sync    = OMAP24XX_DMA_MCBSP1_TX,
> -               .rx_irq         = INT_24XX_MCBSP1_IRQ_RX,
> -               .tx_irq         = INT_24XX_MCBSP1_IRQ_TX,
> -       },
> +struct omap_device_pm_latency omap2_mcbsp_latency[] = {
>          {
> -               .phys_base      = OMAP24XX_MCBSP2_BASE,
> -               .dma_rx_sync    = OMAP24XX_DMA_MCBSP2_RX,
> -               .dma_tx_sync    = OMAP24XX_DMA_MCBSP2_TX,
> -               .rx_irq         = INT_24XX_MCBSP2_IRQ_RX,
> -               .tx_irq         = INT_24XX_MCBSP2_IRQ_TX,
> +               .deactivate_func = omap_device_idle_hwmods,
> +               .activate_func   = omap_device_enable_hwmods,
> +               .flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
>          },
>   };
> -#define OMAP2420_MCBSP_PDATA_SZ                ARRAY_SIZE(omap2420_mcbsp_pdata)
> -#define OMAP2420_MCBSP_REG_NUM         (OMAP_MCBSP_REG_RCCR / sizeof(u32) + 1)
> -#else
> -#define omap2420_mcbsp_pdata           NULL
> -#define OMAP2420_MCBSP_PDATA_SZ                0
> -#define OMAP2420_MCBSP_REG_NUM         0
> -#endif
>
> -#ifdef CONFIG_ARCH_OMAP2430
> -static struct omap_mcbsp_platform_data omap2430_mcbsp_pdata[] = {
> -       {
> -               .phys_base      = OMAP24XX_MCBSP1_BASE,
> -               .dma_rx_sync    = OMAP24XX_DMA_MCBSP1_RX,
> -               .dma_tx_sync    = OMAP24XX_DMA_MCBSP1_TX,
> -               .rx_irq         = INT_24XX_MCBSP1_IRQ_RX,
> -               .tx_irq         = INT_24XX_MCBSP1_IRQ_TX,
> -       },
> -       {
> -               .phys_base      = OMAP24XX_MCBSP2_BASE,
> -               .dma_rx_sync    = OMAP24XX_DMA_MCBSP2_RX,
> -               .dma_tx_sync    = OMAP24XX_DMA_MCBSP2_TX,
> -               .rx_irq         = INT_24XX_MCBSP2_IRQ_RX,
> -               .tx_irq         = INT_24XX_MCBSP2_IRQ_TX,
> -       },
> -       {
> -               .phys_base      = OMAP2430_MCBSP3_BASE,
> -               .dma_rx_sync    = OMAP24XX_DMA_MCBSP3_RX,
> -               .dma_tx_sync    = OMAP24XX_DMA_MCBSP3_TX,
> -               .rx_irq         = INT_24XX_MCBSP3_IRQ_RX,
> -               .tx_irq         = INT_24XX_MCBSP3_IRQ_TX,
> -       },
> -       {
> -               .phys_base      = OMAP2430_MCBSP4_BASE,
> -               .dma_rx_sync    = OMAP24XX_DMA_MCBSP4_RX,
> -               .dma_tx_sync    = OMAP24XX_DMA_MCBSP4_TX,
> -               .rx_irq         = INT_24XX_MCBSP4_IRQ_RX,
> -               .tx_irq         = INT_24XX_MCBSP4_IRQ_TX,
> -       },
> -       {
> -               .phys_base      = OMAP2430_MCBSP5_BASE,
> -               .dma_rx_sync    = OMAP24XX_DMA_MCBSP5_RX,
> -               .dma_tx_sync    = OMAP24XX_DMA_MCBSP5_TX,
> -               .rx_irq         = INT_24XX_MCBSP5_IRQ_RX,
> -               .tx_irq         = INT_24XX_MCBSP5_IRQ_TX,
> -       },
> -};
> -#define OMAP2430_MCBSP_PDATA_SZ                ARRAY_SIZE(omap2430_mcbsp_pdata)
> -#define OMAP2430_MCBSP_REG_NUM         (OMAP_MCBSP_REG_RCCR / sizeof(u32) + 1)
> -#else
> -#define omap2430_mcbsp_pdata           NULL
> -#define OMAP2430_MCBSP_PDATA_SZ                0
> -#define OMAP2430_MCBSP_REG_NUM         0
> -#endif
> +static int omap_init_mcbsp(struct omap_hwmod *oh, void *user)
> +{
> +       int id, count = 1, i;
> +       char *name = "omap-mcbsp";
> +       char dev_name[16];
> +       struct omap_hwmod *oh_device[2];
> +       struct omap_mcbsp_platform_data *pdata;
> +       struct omap_device *od;
> +
> +       if (!oh) {
> +               pr_err("%s:NULL hwmod pointer (oh)\n", __func__);
> +               return -EINVAL;
> +       }
>
> -#ifdef CONFIG_ARCH_OMAP3
> -static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
> -       {
> -               .phys_base      = OMAP34XX_MCBSP1_BASE,
> -               .dma_rx_sync    = OMAP24XX_DMA_MCBSP1_RX,
> -               .dma_tx_sync    = OMAP24XX_DMA_MCBSP1_TX,
> -               .rx_irq         = INT_24XX_MCBSP1_IRQ_RX,
> -               .tx_irq         = INT_24XX_MCBSP1_IRQ_TX,
> -               .buffer_size    = 0x80, /* The FIFO has 128 locations */
> -       },
> -       {
> -               .phys_base      = OMAP34XX_MCBSP2_BASE,
> -               .phys_base_st   = OMAP34XX_MCBSP2_ST_BASE,
> -               .dma_rx_sync    = OMAP24XX_DMA_MCBSP2_RX,
> -               .dma_tx_sync    = OMAP24XX_DMA_MCBSP2_TX,
> -               .rx_irq         = INT_24XX_MCBSP2_IRQ_RX,
> -               .tx_irq         = INT_24XX_MCBSP2_IRQ_TX,
> -               .buffer_size    = 0x500, /* The FIFO has 1024 + 256 locations */
> -       },
> -       {
> -               .phys_base      = OMAP34XX_MCBSP3_BASE,
> -               .phys_base_st   = OMAP34XX_MCBSP3_ST_BASE,
> -               .dma_rx_sync    = OMAP24XX_DMA_MCBSP3_RX,
> -               .dma_tx_sync    = OMAP24XX_DMA_MCBSP3_TX,
> -               .rx_irq         = INT_24XX_MCBSP3_IRQ_RX,
> -               .tx_irq         = INT_24XX_MCBSP3_IRQ_TX,
> -               .buffer_size    = 0x80, /* The FIFO has 128 locations */
> -       },
> -       {
> -               .phys_base      = OMAP34XX_MCBSP4_BASE,
> -               .dma_rx_sync    = OMAP24XX_DMA_MCBSP4_RX,
> -               .dma_tx_sync    = OMAP24XX_DMA_MCBSP4_TX,
> -               .rx_irq         = INT_24XX_MCBSP4_IRQ_RX,
> -               .tx_irq         = INT_24XX_MCBSP4_IRQ_TX,
> -               .buffer_size    = 0x80, /* The FIFO has 128 locations */
> -       },
> -       {
> -               .phys_base      = OMAP34XX_MCBSP5_BASE,
> -               .dma_rx_sync    = OMAP24XX_DMA_MCBSP5_RX,
> -               .dma_tx_sync    = OMAP24XX_DMA_MCBSP5_TX,
> -               .rx_irq         = INT_24XX_MCBSP5_IRQ_RX,
> -               .tx_irq         = INT_24XX_MCBSP5_IRQ_TX,
> -               .buffer_size    = 0x80, /* The FIFO has 128 locations */
> -       },
> -};
> -#define OMAP34XX_MCBSP_PDATA_SZ                ARRAY_SIZE(omap34xx_mcbsp_pdata)
> -#define OMAP34XX_MCBSP_REG_NUM         (OMAP_MCBSP_REG_RCCR / sizeof(u32) + 1)
> -#else
> -#define omap34xx_mcbsp_pdata           NULL
> -#define OMAP34XX_MCBSP_PDATA_SZ                0
> -#define OMAP34XX_MCBSP_REG_NUM         0
> -#endif
> +       pdata = kzalloc(sizeof(struct omap_mcbsp_platform_data), GFP_KERNEL);
> +       if (!pdata) {
> +               pr_err("%s: No memory for mcbsp\n", __func__);
> +               return -ENOMEM;
> +       }
>
> -static struct omap_mcbsp_platform_data omap44xx_mcbsp_pdata[] = {
> -       {
> -               .phys_base      = OMAP44XX_MCBSP1_BASE,
> -               .dma_rx_sync    = OMAP44XX_DMA_MCBSP1_RX,
> -               .dma_tx_sync    = OMAP44XX_DMA_MCBSP1_TX,
> -               .tx_irq         = OMAP44XX_IRQ_MCBSP1,
> -       },
> -       {
> -               .phys_base      = OMAP44XX_MCBSP2_BASE,
> -               .dma_rx_sync    = OMAP44XX_DMA_MCBSP2_RX,
> -               .dma_tx_sync    = OMAP44XX_DMA_MCBSP2_TX,
> -               .tx_irq         = OMAP44XX_IRQ_MCBSP2,
> -               /* XXX .ops ? */
> -       },
> -       {
> -               .phys_base      = OMAP44XX_MCBSP3_BASE,
> -               .dma_rx_sync    = OMAP44XX_DMA_MCBSP3_RX,
> -               .dma_tx_sync    = OMAP44XX_DMA_MCBSP3_TX,
> -               .tx_irq         = OMAP44XX_IRQ_MCBSP3,
> -               /* XXX .ops ? */
> -       },
> -       {
> -               .phys_base      = OMAP44XX_MCBSP4_BASE,
> -               .dma_rx_sync    = OMAP44XX_DMA_MCBSP4_RX,
> -               .dma_tx_sync    = OMAP44XX_DMA_MCBSP4_TX,
> -               .tx_irq         = OMAP44XX_IRQ_MCBSP4,
> -               /* XXX .ops ? */
> -       },
> -};
> -#define OMAP44XX_MCBSP_PDATA_SZ                ARRAY_SIZE(omap44xx_mcbsp_pdata)
> -#define OMAP44XX_MCBSP_REG_NUM         (OMAP_MCBSP_REG_RCCR / sizeof(u32) + 1)
> +       if (cpu_is_omap34xx()) {
> +               pdata->dma_op_mode = MCBSP_DMA_MODE_ELEMENT;
> +               if (id == 2)
> +                       pdata->buffer_size = 0x500;
> +               else
> +                       pdata->buffer_size = 0x80;
> +       } else {
> +               pdata->dma_op_mode = -EINVAL;
> +               pdata->buffer_size = 0;
> +       }
>
> -static int __init omap2_mcbsp_init(void)
> +       sscanf(oh->name, "mcbsp%d",&id);
> +       sprintf(dev_name, "mcbsp%d_sidetone", id);
> +       oh_device[0] = oh;
> +
> +       for (i = 0; i<  no_of_st ; i++) {
> +               if (!strcmp(dev_name, oh_st_device[i]->name)) {
> +                       oh_device[1] = oh_st_device[i];
> +                       count++;
> +               }
> +       }

Pfuu, it took me a while to follow how all that stuff was working :-)

Since the sidetone block is tightly coupled to the mcbsp, you should 
simply add this information directly as a attribute of the mcbsp2 & 3 
hwmod dev_attr.

You will then easily detect which one does have a sidetone connected to 
it and avoid all this code.

+static struct omap_mcbsp_dev_attr omap34xx_mcbsp2_dev_attr = {
+       .sidetone       = "mcbsp2_sidetone",
+};

+static struct omap_hwmod omap34xx_mcbsp2_hwmod = {
...
+       .dev_attr       = &omap34xx_mcbsp2_dev_attr,
...


Regards,
Benoit


> +
> +       od = omap_device_build_ss(name, id, oh_device, count, pdata,
> +                               sizeof(*pdata), omap2_mcbsp_latency,
> +                               ARRAY_SIZE(omap2_mcbsp_latency), false);
> +       if (IS_ERR(od))  {
> +               pr_err("%s: Cant build omap_device for %s:%s.\n", __func__,
> +                                       name, oh->name);
> +               kfree(pdata);
> +               return PTR_ERR(od);
> +       }
> +       omap_mcbsp_count++;
> +       return 0;
> +}
> +
> +static int omap_mcbsp_st(struct omap_hwmod *oh, void *user)
>   {
> -       if (cpu_is_omap2420()) {
> -               omap_mcbsp_count = OMAP2420_MCBSP_PDATA_SZ;
> -               omap_mcbsp_cache_size = OMAP2420_MCBSP_REG_NUM * sizeof(u16);
> -       } else if (cpu_is_omap2430()) {
> -               omap_mcbsp_count = OMAP2430_MCBSP_PDATA_SZ;
> -               omap_mcbsp_cache_size = OMAP2430_MCBSP_REG_NUM * sizeof(u32);
> -       } else if (cpu_is_omap34xx()) {
> -               omap_mcbsp_count = OMAP34XX_MCBSP_PDATA_SZ;
> -               omap_mcbsp_cache_size = OMAP34XX_MCBSP_REG_NUM * sizeof(u32);
> -       } else if (cpu_is_omap44xx()) {
> -               omap_mcbsp_count = OMAP44XX_MCBSP_PDATA_SZ;
> -               omap_mcbsp_cache_size = OMAP44XX_MCBSP_REG_NUM * sizeof(u32);
> +       if (!oh) {
> +               pr_err("%s:NULL hwmod pointer (oh)\n", __func__);
> +               return -EINVAL;
>          }
> +       oh_st_device[no_of_st++] = oh;
> +       return 0;
> +}
> +
> +static int __init omap2_mcbsp_init(void)
> +{
> +       omap_hwmod_for_each_by_class("mcbsp_sidetone", omap_mcbsp_st,
> +                                       NULL);
> +       omap_hwmod_for_each_by_class("mcbsp", omap_init_mcbsp, NULL);
>
>          mcbsp_ptr = kzalloc(omap_mcbsp_count * sizeof(struct omap_mcbsp *),
>                                                                  GFP_KERNEL);
>          if (!mcbsp_ptr)
>                  return -ENOMEM;
>
> -       if (cpu_is_omap2420())
> -               omap_mcbsp_register_board_cfg(omap2420_mcbsp_pdata,
> -                                               OMAP2420_MCBSP_PDATA_SZ);
> -       if (cpu_is_omap2430())
> -               omap_mcbsp_register_board_cfg(omap2430_mcbsp_pdata,
> -                                               OMAP2430_MCBSP_PDATA_SZ);
> -       if (cpu_is_omap34xx())
> -               omap_mcbsp_register_board_cfg(omap34xx_mcbsp_pdata,
> -                                               OMAP34XX_MCBSP_PDATA_SZ);
> -       if (cpu_is_omap44xx())
> -               omap_mcbsp_register_board_cfg(omap44xx_mcbsp_pdata,
> -                                               OMAP44XX_MCBSP_PDATA_SZ);
> -
>          return omap_mcbsp_init();
>   }
>   arch_initcall(omap2_mcbsp_init);
> diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
> index 4da6f94..1ff283c 100644
> --- a/arch/arm/plat-omap/include/plat/mcbsp.h
> +++ b/arch/arm/plat-omap/include/plat/mcbsp.h
> @@ -418,11 +418,9 @@ struct omap_mcbsp_platform_data {
>          u8 dma_rx_sync, dma_tx_sync;
>          u16 rx_irq, tx_irq;
>          struct omap_mcbsp_ops *ops;
> -#ifdef CONFIG_ARCH_OMAP3
> -       /* Sidetone block for McBSP 2 and 3 */
>          unsigned long phys_base_st;
>          u16 buffer_size;
> -#endif
> +       int dma_op_mode;
>   };
>
>   struct omap_mcbsp_st_data {
> @@ -466,12 +464,10 @@ struct omap_mcbsp {
>          struct omap_mcbsp_platform_data *pdata;
>          struct clk *iclk;
>          struct clk *fclk;
> -#ifdef CONFIG_ARCH_OMAP3
>          struct omap_mcbsp_st_data *st_data;
>          int dma_op_mode;
>          u16 max_tx_thres;
>          u16 max_rx_thres;
> -#endif
>          void *reg_cache;
>   };
>   extern struct omap_mcbsp **mcbsp_ptr;
> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index eac4b97..c7c6a83 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -27,6 +27,8 @@
>
>   #include<plat/dma.h>
>   #include<plat/mcbsp.h>
> +#include<plat/omap_hwmod.h>
> +#include<plat/omap_device.h>
>
>   #include "../mach-omap2/cm-regbits-34xx.h"
>
> @@ -1466,7 +1468,6 @@ void omap_mcbsp_set_spi_mode(unsigned int id,
>   }
>   EXPORT_SYMBOL(omap_mcbsp_set_spi_mode);
>
> -#ifdef CONFIG_ARCH_OMAP3
>   #define max_thres(m)                   (mcbsp->pdata->buffer_size)
>   #define valid_threshold(m, val)                ((val)<= max_thres(m))
>   #define THRESHOLD_PROP_BUILDER(prop)                                   \
> @@ -1645,98 +1646,6 @@ static const struct attribute_group sidetone_attr_group = {
>          .attrs = (struct attribute **)sidetone_attrs,
>   };
>
> -static int __devinit omap_st_add(struct omap_mcbsp *mcbsp)
> -{
> -       struct omap_mcbsp_platform_data *pdata = mcbsp->pdata;
> -       struct omap_mcbsp_st_data *st_data;
> -       int err;
> -
> -       st_data = kzalloc(sizeof(*mcbsp->st_data), GFP_KERNEL);
> -       if (!st_data) {
> -               err = -ENOMEM;
> -               goto err1;
> -       }
> -
> -       st_data->io_base_st = ioremap(pdata->phys_base_st, SZ_4K);
> -       if (!st_data->io_base_st) {
> -               err = -ENOMEM;
> -               goto err2;
> -       }
> -
> -       err = sysfs_create_group(&mcbsp->dev->kobj,&sidetone_attr_group);
> -       if (err)
> -               goto err3;
> -
> -       mcbsp->st_data = st_data;
> -       return 0;
> -
> -err3:
> -       iounmap(st_data->io_base_st);
> -err2:
> -       kfree(st_data);
> -err1:
> -       return err;
> -
> -}
> -
> -static void __devexit omap_st_remove(struct omap_mcbsp *mcbsp)
> -{
> -       struct omap_mcbsp_st_data *st_data = mcbsp->st_data;
> -
> -       if (st_data) {
> -               sysfs_remove_group(&mcbsp->dev->kobj,&sidetone_attr_group);
> -               iounmap(st_data->io_base_st);
> -               kfree(st_data);
> -       }
> -}
> -
> -static inline void __devinit omap34xx_device_init(struct omap_mcbsp *mcbsp)
> -{
> -       mcbsp->dma_op_mode = MCBSP_DMA_MODE_ELEMENT;
> -       if (cpu_is_omap34xx()) {
> -               /*
> -                * Initially configure the maximum thresholds to a safe value.
> -                * The McBSP FIFO usage with these values should not go under
> -                * 16 locations.
> -                * If the whole FIFO without safety buffer is used, than there
> -                * is a possibility that the DMA will be not able to push the
> -                * new data on time, causing channel shifts in runtime.
> -                */
> -               mcbsp->max_tx_thres = max_thres(mcbsp) - 0x10;
> -               mcbsp->max_rx_thres = max_thres(mcbsp) - 0x10;
> -               /*
> -                * REVISIT: Set dmap_op_mode to THRESHOLD as default
> -                * for mcbsp2 instances.
> -                */
> -               if (omap_additional_add(mcbsp->dev))
> -                       dev_warn(mcbsp->dev,
> -                               "Unable to create additional controls\n");
> -
> -               if (mcbsp->id == 2 || mcbsp->id == 3)
> -                       if (omap_st_add(mcbsp))
> -                               dev_warn(mcbsp->dev,
> -                                "Unable to create sidetone controls\n");
> -
> -       } else {
> -               mcbsp->max_tx_thres = -EINVAL;
> -               mcbsp->max_rx_thres = -EINVAL;
> -       }
> -}
> -
> -static inline void __devexit omap34xx_device_exit(struct omap_mcbsp *mcbsp)
> -{
> -       if (cpu_is_omap34xx()) {
> -               omap_additional_remove(mcbsp->dev);
> -
> -               if (mcbsp->id == 2 || mcbsp->id == 3)
> -                       omap_st_remove(mcbsp);
> -       }
> -}
> -#else
> -static inline void __devinit omap34xx_device_init(struct omap_mcbsp *mcbsp) {}
> -static inline void __devexit omap34xx_device_exit(struct omap_mcbsp *mcbsp) {}
> -#endif /* CONFIG_ARCH_OMAP3 */
> -
>   /*
>    * McBSP1 and McBSP3 are directly mapped on 1610 and 1510.
>    * 730 has only 2 McBSP, and both of them are MPU peripherals.
> @@ -1746,6 +1655,7 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
>          struct omap_mcbsp_platform_data *pdata = pdev->dev.platform_data;
>          struct omap_mcbsp *mcbsp;
>          int id = pdev->id - 1;
> +       struct resource *res;
>          int ret = 0;
>
>          if (!pdata) {
> @@ -1775,25 +1685,50 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
>          mcbsp->dma_tx_lch = -1;
>          mcbsp->dma_rx_lch = -1;
>
> -       mcbsp->phys_base = pdata->phys_base;
> -       mcbsp->io_base = ioremap(pdata->phys_base, SZ_4K);
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res) {
> +               dev_err(&pdev->dev, "%s:mcbsp%d has invalid memory resource\n",
> +                                       __func__, pdev->id);
> +               ret = -ENOMEM;
> +               goto exit;
> +       }
> +       mcbsp->phys_base = res->start;
> +       mcbsp->io_base = ioremap(res->start, resource_size(res));
>          if (!mcbsp->io_base) {
>                  ret = -ENOMEM;
>                  goto err_ioremap;
>          }
>
> +       omap_mcbsp_cache_size = resource_size(res);
> +
>          /* Default I/O is IRQ based */
>          mcbsp->io_type = OMAP_MCBSP_IRQ_IO;
> -       mcbsp->tx_irq = pdata->tx_irq;
> -       mcbsp->rx_irq = pdata->rx_irq;
> -       mcbsp->dma_rx_sync = pdata->dma_rx_sync;
> -       mcbsp->dma_tx_sync = pdata->dma_tx_sync;
> +       mcbsp->tx_irq = platform_get_irq_byname(pdev, "tx");
> +       mcbsp->rx_irq = platform_get_irq_byname(pdev, "rx");
> +
> +       res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
> +       if (!res) {
> +               dev_err(&pdev->dev, "%s:mcbsp%d has invalid DMA channel\n",
> +                                       __func__, pdev->id);
> +               ret = -ENODEV;
> +               goto err_res;
> +       }
> +       mcbsp->dma_rx_sync = res->start;
> +
> +       res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
> +       if (!res) {
> +               dev_err(&pdev->dev, "%s:mcbsp%d has invalid DMA channel\n",
> +                                       __func__, pdev->id);
> +               ret = -ENODEV;
> +               goto err_res;
> +       }
> +       mcbsp->dma_tx_sync = res->start;
>
>          mcbsp->iclk = clk_get(&pdev->dev, "ick");
>          if (IS_ERR(mcbsp->iclk)) {
>                  ret = PTR_ERR(mcbsp->iclk);
>                  dev_err(&pdev->dev, "unable to get ick: %d\n", ret);
> -               goto err_iclk;
> +               goto err_res;
>          }
>
>          mcbsp->fclk = clk_get(&pdev->dev, "fck");
> @@ -1808,14 +1743,53 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
>          mcbsp_ptr[id] = mcbsp;
>          platform_set_drvdata(pdev, mcbsp);
>
> -       /* Initialize mcbsp properties for OMAP34XX if needed / applicable */
> -       omap34xx_device_init(mcbsp);
> +       omap_additional_add(mcbsp->dev);
> +       if (pdata->dma_op_mode != -EINVAL) {
> +               /*
> +                * Initially configure the maximum thresholds to a safe value.
> +                * The McBSP FIFO usage with these values should not go under
> +                * 16 locations.
> +                * If the whole FIFO without safety buffer is used, than there
> +                * is a possibility that the DMA will be not able to push the
> +                * new data on time, causing channel shifts in runtime.
> +                */
> +               mcbsp->max_tx_thres = max_thres(mcbsp) - 0x10 ;
> +               mcbsp->max_rx_thres = max_thres(mcbsp) - 0x10 ;
> +       }
> +
> +       if (cpu_is_omap34xx()) {
> +               res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +               if (res) {
> +                       mcbsp->st_data = kzalloc(sizeof(*mcbsp->st_data),
> +                                               GFP_KERNEL);
> +                       if (!mcbsp->st_data) {
> +                               ret = -ENOMEM;
> +                               goto err_st_data;
> +                       }
> +                       mcbsp->st_data->io_base_st = ioremap(res->start,
> +                                               resource_size(res));
> +                       if (!mcbsp->st_data->io_base_st) {
> +                               ret = -ENOMEM;
> +                               goto err_io_st;
> +                       }
> +                       ret = sysfs_create_group(&mcbsp->dev->kobj,
> +&sidetone_attr_group);
> +                       if (ret)
> +                               goto err_sysfs;
> +               }
> +       }
>
>          return 0;
>
> +err_sysfs:
> +       iounmap(mcbsp->st_data->io_base_st);
> +err_io_st:
> +       kfree(mcbsp->st_data);
> +err_st_data:
> +       clk_put(mcbsp->fclk);
>   err_fclk:
>          clk_put(mcbsp->iclk);
> -err_iclk:
> +err_res:
>          iounmap(mcbsp->io_base);
>   err_ioremap:
>          kfree(mcbsp);
> @@ -1834,7 +1808,14 @@ static int __devexit omap_mcbsp_remove(struct platform_device *pdev)
>                                  mcbsp->pdata->ops->free)
>                          mcbsp->pdata->ops->free(mcbsp->id);
>
> -               omap34xx_device_exit(mcbsp);
> +               omap_additional_remove(mcbsp->dev);
> +
> +               if (mcbsp->st_data) {
> +                       sysfs_remove_group(&mcbsp->dev->kobj,
> +&sidetone_attr_group);
> +                       iounmap(mcbsp->st_data->io_base_st);
> +                       kfree(mcbsp->st_data);
> +               }
>
>                  clk_disable(mcbsp->fclk);
>                  clk_disable(mcbsp->iclk);
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

