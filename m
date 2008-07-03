From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH 2/2] ARM:OMAP2: irda support 3430
Date: Thu, 3 Jul 2008 14:28:54 +0530
Message-ID: <5d5443650807030158o728c1d85p5062525d9c2a7a1e@mail.gmail.com>
References: <63619.192.168.10.89.1215067554.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:13735 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756500AbYGCMB6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jul 2008 08:01:58 -0400
Received: by fk-out-0910.google.com with SMTP id 18so596373fkq.5
        for <linux-omap@vger.kernel.org>; Thu, 03 Jul 2008 05:01:54 -0700 (PDT)
In-Reply-To: <63619.192.168.10.89.1215067554.squirrel@dbdmail.itg.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: girishsg@ti.com
Cc: linux-omap@vger.kernel.org

Hi Girish,

On Thu, Jul 3, 2008 at 12:15 PM, Girish. S. G. <girishsg@ti.com> wrote:
> This adds board specific changes to support IrDA on 3430
>
> Signed-off-by: Girish S G <girishsg@ti.com>
> ---
>  arch/arm/configs/omap_3430sdp_defconfig |   34 +++++++
>  arch/arm/mach-omap2/board-3430sdp.c     |  145 ++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/mux.c               |   16 +++
>  include/asm-arm/arch-omap/gpio.h        |    3
>  include/asm-arm/arch-omap/mux.h         |    9 +
>  5 files changed, 204 insertions(+), 3 deletions(-)
>
> Index: linux-omap-2.6/arch/arm/configs/omap_3430sdp_defconfig
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/configs/omap_3430sdp_defconfig 2008-07-02
> 18:54:15.000000000 +0530
> +++ linux-omap-2.6/arch/arm/configs/omap_3430sdp_defconfig      2008-07-02
> 18:56:41.000000000 +0530
> @@ -392,7 +392,39 @@
>  # CONFIG_NET_PKTGEN is not set
>  # CONFIG_HAMRADIO is not set
>  # CONFIG_CAN is not set
> -# CONFIG_IRDA is not set
> +CONFIG_IRDA=y
> +
> +#
> +# IrDA protocols
> +#
> +# CONFIG_IRLAN is not set
> +CONFIG_IRCOMM=y
> +# CONFIG_IRDA_ULTRA is not set
> +
> +#
> +# IrDA options
> +#
> +CONFIG_IRDA_CACHE_LAST_LSAP=y
> +CONFIG_IRDA_FAST_RR=y
> +# CONFIG_IRDA_DEBUG is not set
> +
> +#
> +# Infrared-port device drivers
> +#
> +
> +#
> +# SIR device drivers
> +#
> +# CONFIG_IRTTY_SIR is not set
> +
> +#
> +# Dongle support
> +#
> +
> +#
> +# FIR device drivers
> +#
> +CONFIG_OMAP_IR=y
>  # CONFIG_BT is not set
>  # CONFIG_AF_RXRPC is not set
>
> Index: linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/board-3430sdp.c     2008-07-02
> 18:54:15.000000000 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp.c  2008-07-02
> 18:56:41.000000000 +0530
> @@ -32,6 +32,7 @@
>  #include <asm/arch/mcspi.h>
>  #include <asm/arch/gpio.h>
>  #include <asm/arch/mux.h>
> +#include <asm/arch/irda.h>
>  #include <asm/arch/board.h>
>  #include <asm/arch/usb-musb.h>
>  #include <asm/arch/usb-ehci.h>
> @@ -46,6 +47,9 @@
>
>  #define        SDP3430_SMC91X_CS       3
>
> +#define ENABLE_VAUX1_DEDICATED 0x03
> +#define ENABLE_VAUX1_DEV_GRP   0x20
> +
>  #define ENABLE_VAUX3_DEDICATED 0x03
>  #define ENABLE_VAUX3_DEV_GRP   0x20
>
> @@ -70,6 +74,146 @@
>        .resource       = sdp3430_smc91x_resources,
>  };
>
> +/* IrDA
> + */
> +#if defined(CONFIG_OMAP_IR) || defined(CONFIG_OMAP_IR_MODULE)
> +
> +#define        IRDA_SD 164     /* gpio 164 */
> +#define        IRDA_TX 166     /* gpio 166 */
> +#define        IRDA_SD_PIN     T21_3430_GPIO164
> +#define        IRDA_TX_PIN     V21_3430_GPIO166
> +
> +#define IRDA_VAUX_EN   1
> +#define IRDA_VAUX_DIS  0
> +
> +/*
> + * This enable(1)/disable(0) the voltage for IrDA: uses twl4030 calls
> + */
> +static int irda_vaux_control(int vaux_cntrl)
> +{
> +       int ret = 0;
> +
> +#ifdef CONFIG_TWL4030_CORE
> +       /* check for return value of ldo_use: if success it returns 0 */
> +       if (vaux_cntrl == IRDA_VAUX_EN) {
> +               if (ret != twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
> +                       ENABLE_VAUX1_DEDICATED, TWL4030_VAUX1_DEDICATED))
> +                       return -EIO;
> +               if (ret != twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
> +                       ENABLE_VAUX1_DEV_GRP, TWL4030_VAUX1_DEV_GRP))
> +                       return -EIO;
> +       } else if (vaux_cntrl == IRDA_VAUX_DIS) {
> +               if (ret != twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
> +                       0x00, TWL4030_VAUX1_DEDICATED))
> +                       return -EIO;
> +               if (ret != twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
> +                       0x00, TWL4030_VAUX1_DEV_GRP))
> +                       return -EIO;
> +       }
> +#else
> +       ret = -EIO;
> +#endif
> +       return ret;
> +}
> +
> +static int select_irda(struct device *dev, int state)
> +{
> +       int err;
> +       if (state == IR_SEL) {
> +               err = irda_vaux_control(IRDA_VAUX_EN);
> +               if (err != 0) {
> +                       printk(KERN_ERR "OMAP: IrDA vaux enable failed\n");
> +                       return err;
> +               }
> +
> +               omap_cfg_reg(R21_3430_UART3_CTS_RCTX);
> +               omap_cfg_reg(T21_3430_UART3_RTS_SD);
> +               omap_cfg_reg(U21_3430_UART3_RX_IRRX);
> +               omap_cfg_reg(V21_3430_UART3_TX_IRTX);
> +
> +               omap_request_gpio(IRDA_SD);
> +               omap_request_gpio(IRDA_TX);
> +               omap_cfg_reg(IRDA_SD_PIN);
> +               omap_set_gpio_direction(IRDA_SD, GPIO_DIR_OUTPUT);
> +               omap_set_gpio_direction(IRDA_TX, GPIO_DIR_OUTPUT);
> +               omap_set_gpio_dataout(IRDA_SD, 0);
> +       } else {
> +               omap_free_gpio(IRDA_SD);
> +               omap_free_gpio(IRDA_TX);
> +               err = irda_vaux_control(IRDA_VAUX_EN);
> +               if (err != 0) {
> +                       printk(KERN_ERR "OMAP: IrDA vaux Enable failed\n");
> +                       return err;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static int transceiver_mode(struct device *dev, int mode)
> +{
> +       omap_cfg_reg(IRDA_SD_PIN);
> +       omap_cfg_reg(IRDA_TX_PIN);
> +
> +       if (mode & IR_SIRMODE) {
> +               /* SIR */
> +               omap_set_gpio_dataout(IRDA_SD, 1);
> +               udelay(1);
> +               omap_set_gpio_dataout(IRDA_TX, 0);
> +               udelay(1);
> +               omap_set_gpio_dataout(IRDA_SD, 0);
> +               udelay(1);
> +       } else {
> +               /* MIR/FIR */
> +               omap_set_gpio_dataout(IRDA_SD, 1);
> +               udelay(1);
> +               omap_set_gpio_dataout(IRDA_TX, 1);
> +               udelay(1);
> +               omap_set_gpio_dataout(IRDA_SD, 0);
> +               udelay(1);
> +               omap_set_gpio_dataout(IRDA_TX, 0);
> +               udelay(1);
> +       }
> +
> +       omap_cfg_reg(T21_3430_UART3_RTS_SD);
> +       omap_cfg_reg(V21_3430_UART3_TX_IRTX);
> +       return 0;
> +}
> +#else
> +static int select_irda(struct device *dev, int state) { return 0; }
> +static int transceiver_mode(struct device *dev, int mode) { return 0; }
> +#endif
> +
> +static struct omap_irda_config irda_data = {
> +       .transceiver_cap        = IR_SIRMODE | IR_MIRMODE | IR_FIRMODE,
> +       .transceiver_mode       = transceiver_mode,
> +       .select_irda            = select_irda,


Please rename this hooks to 3430sdp_transceiver_mode and
3430sdp_select_irda. Check board_h4.c for example.

> +       .rx_channel             = OMAP24XX_DMA_UART3_RX,
> +       .tx_channel             = OMAP24XX_DMA_UART3_TX,
> +       .dest_start             = OMAP_UART3_BASE,
> +       .src_start              = OMAP_UART3_BASE,
> +       .tx_trigger             = OMAP24XX_DMA_UART3_TX,
> +       .rx_trigger             = OMAP24XX_DMA_UART3_RX,
> +};

Actually rx_channel to rx_trigger are not platform data and it is long
pending cleanup. It would great if we can convert this to
platform_resource, as it is chip specific not board specific.

-- 
---Trilok Soni
http://triloksoni.wordpress.com
