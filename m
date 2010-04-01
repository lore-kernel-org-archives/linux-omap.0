From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 1/8] OMAP:GPIO:Move architecture specific macros to
 specific header
Date: Thu, 1 Apr 2010 10:17:13 +0300
Message-ID: <20100401071713.GC16297@nokia.com>
References: <1270038239-1090-1-git-send-email-charu@ti.com>
 <1270038239-1090-2-git-send-email-charu@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:21523 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514Ab0DAHRv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 03:17:51 -0400
Content-Disposition: inline
In-Reply-To: <1270038239-1090-2-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Charulatha V <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "rnayak@ti.com" <rnayak@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>

Hi,

On Wed, Mar 31, 2010 at 02:23:52PM +0200, ext Charulatha V wrote:
>diff --git a/arch/arm/mach-omap1/include/mach/gpio.h b/arch/arm/mach-omap1/include/mach/gpio.h
>index e737706..c4945d7 100644
>--- a/arch/arm/mach-omap1/include/mach/gpio.h
>+++ b/arch/arm/mach-omap1/include/mach/gpio.h
>@@ -3,3 +3,91 @@
>  */
>
> #include <plat/gpio.h>
>+
>+/*
>+ * OMAP1510 GPIO registers
>+ */
>+#define OMAP1510_GPIO_BASE             0xfffce000
>+#define OMAP1510_GPIO_DATA_INPUT       0x00
>+#define OMAP1510_GPIO_DATA_OUTPUT      0x04
>+#define OMAP1510_GPIO_DIR_CONTROL      0x08
>+#define OMAP1510_GPIO_INT_CONTROL      0x0c
>+#define OMAP1510_GPIO_INT_MASK         0x10
>+#define OMAP1510_GPIO_INT_STATUS       0x14
>+#define OMAP1510_GPIO_PIN_CONTROL      0x18
>+
>+#define OMAP1510_IH_GPIO_BASE          64
>+
>+/*
>+ * OMAP1610 specific GPIO registers
>+ */
>+#define OMAP1610_GPIO1_BASE            0xfffbe400
>+#define OMAP1610_GPIO2_BASE            0xfffbec00
>+#define OMAP1610_GPIO3_BASE            0xfffbb400
>+#define OMAP1610_GPIO4_BASE            0xfffbbc00
>+#define OMAP1610_GPIO_REVISION         0x0000
>+#define OMAP1610_GPIO_SYSCONFIG                0x0010
>+#define OMAP1610_GPIO_SYSSTATUS                0x0014
>+#define OMAP1610_GPIO_IRQSTATUS1       0x0018
>+#define OMAP1610_GPIO_IRQENABLE1       0x001c
>+#define OMAP1610_GPIO_WAKEUPENABLE     0x0028
>+#define OMAP1610_GPIO_DATAIN           0x002c
>+#define OMAP1610_GPIO_DATAOUT          0x0030
>+#define OMAP1610_GPIO_DIRECTION                0x0034
>+#define OMAP1610_GPIO_EDGE_CTRL1       0x0038
>+#define OMAP1610_GPIO_EDGE_CTRL2       0x003c
>+#define OMAP1610_GPIO_CLEAR_IRQENABLE1 0x009c
>+#define OMAP1610_GPIO_CLEAR_WAKEUPENA  0x00a8
>+#define OMAP1610_GPIO_CLEAR_DATAOUT    0x00b0
>+#define OMAP1610_GPIO_SET_IRQENABLE1   0x00dc
>+#define OMAP1610_GPIO_SET_WAKEUPENA    0x00e8
>+#define OMAP1610_GPIO_SET_DATAOUT      0x00f0
>+
>+/*
>+ * OMAP7XX specific GPIO registers
>+ */
>+#define OMAP7XX_GPIO1_BASE             0xfffbc000
>+#define OMAP7XX_GPIO2_BASE             0xfffbc800
>+#define OMAP7XX_GPIO3_BASE             0xfffbd000
>+#define OMAP7XX_GPIO4_BASE             0xfffbd800
>+#define OMAP7XX_GPIO5_BASE             0xfffbe000
>+#define OMAP7XX_GPIO6_BASE             0xfffbe800
>+#define OMAP7XX_GPIO_DATA_INPUT                0x00
>+#define OMAP7XX_GPIO_DATA_OUTPUT       0x04
>+#define OMAP7XX_GPIO_DIR_CONTROL       0x08
>+#define OMAP7XX_GPIO_INT_CONTROL       0x0c
>+#define OMAP7XX_GPIO_INT_MASK          0x10
>+#define OMAP7XX_GPIO_INT_STATUS                0x14
>+
>+#define OMAP1_MPUIO_VBASE              OMAP1_MPUIO_BASE
>+#define OMAP1_MPUIO_BASE               0xfffb5000
>+
>+#if (defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850))
>+#define OMAP_MPUIO_INPUT_LATCH         0x00
>+#define OMAP_MPUIO_OUTPUT              0x02
>+#define OMAP_MPUIO_IO_CNTL             0x04
>+#define OMAP_MPUIO_KBR_LATCH           0x08
>+#define OMAP_MPUIO_KBC                 0x0a
>+#define OMAP_MPUIO_GPIO_EVENT_MODE     0x0c
>+#define OMAP_MPUIO_GPIO_INT_EDGE       0x0e
>+#define OMAP_MPUIO_KBD_INT             0x10
>+#define OMAP_MPUIO_GPIO_INT            0x12
>+#define OMAP_MPUIO_KBD_MASKIT          0x14
>+#define OMAP_MPUIO_GPIO_MASKIT         0x16
>+#define OMAP_MPUIO_GPIO_DEBOUNCING     0x18
>+#define OMAP_MPUIO_LATCH               0x1a
>+#else
>+#define OMAP_MPUIO_INPUT_LATCH         0x00
>+#define OMAP_MPUIO_OUTPUT              0x04
>+#define OMAP_MPUIO_IO_CNTL             0x08
>+#define OMAP_MPUIO_KBR_LATCH           0x10
>+#define OMAP_MPUIO_KBC                 0x14
>+#define OMAP_MPUIO_GPIO_EVENT_MODE     0x18
>+#define OMAP_MPUIO_GPIO_INT_EDGE       0x1c
>+#define OMAP_MPUIO_KBD_INT             0x20
>+#define OMAP_MPUIO_GPIO_INT            0x24
>+#define OMAP_MPUIO_KBD_MASKIT          0x28
>+#define OMAP_MPUIO_GPIO_MASKIT         0x2c
>+#define OMAP_MPUIO_GPIO_DEBOUNCING     0x30
>+#define OMAP_MPUIO_LATCH               0x34
>+#endif

Add prefixes to these defines and remove the ifdefs.
This breaks multi-omap builds.

>-struct gpio_bank {
>-       unsigned long pbase;
>-       void __iomem *base;
>-       u16 irq;
>-       u16 virtual_irq_start;
>-       int method;
>-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
>-       u32 suspend_wakeup;
>-       u32 saved_wakeup;
>-#endif
>-#ifdef CONFIG_ARCH_OMAP2PLUS
>-       u32 non_wakeup_gpios;
>-       u32 enabled_non_wakeup_gpios;
>-
>-       u32 saved_datain;
>-       u32 saved_fallingdetect;
>-       u32 saved_risingdetect;
>-#endif
>-       u32 level_mask;
>-       u32 toggle_mask;
>-       spinlock_t lock;
>-       struct gpio_chip chip;
>-       struct clk *dbck;
>-       u32 mod_usage;
>-};

defines are fine, but this structure belongs to this driver. Nobody else 
should need to poke on it. Keep it here.

>@@ -625,10 +421,12 @@ void omap_set_gpio_debounce(int gpio, int enable)
>        bank = get_gpio_bank(gpio);
>        reg = bank->base;
>
>+#ifdef CONFIG_ARCH_OMAP2PLUS
>        if (cpu_is_omap44xx())
>                reg += OMAP4_GPIO_DEBOUNCENABLE;
>        else
>                reg += OMAP24XX_GPIO_DEBOUNCE_EN;
>+#endif

you should try to remove ifdefs not add more.

-- 
balbi
