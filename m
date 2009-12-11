From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: Re: [PATCH 3/3] OMAP: UART: convert to use omap_device layer
Date: Fri, 11 Dec 2009 18:53:52 +0530 (IST)
Message-ID: <57834.192.168.10.88.1260537832.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38157 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755322AbZLKNXr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Dec 2009 08:23:47 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

Kevin,

I have following changes on top of this patch,
1.) Updated omap_uart_port_info as per your comments.
2.) Added Errata 2.15 for DMA mode.
3.) Fix compilation error if omap-serial is enabled with 8250.

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index c067416..cbe1f76 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -249,10 +249,18 @@ static inline void omap_uart_smart_idle_enable(struct omap_uart_state *p,

 	sysc = omap_hwmod_read_sysc(p->oh);
 	sysc &= ~SYSC_SIDLEMODE_MASK;
-	if (enable)
-		sysc |= 0x2 << SYSC_SIDLEMODE_SHIFT;
-	else
+	if (enable) {
+		/**
+		 * Errata 2.15: [UART]:Cannot Acknowledge Idle Requests
+		 * in Smartidle Mode When Configured for DMA Operations.
+		 */
+		if (p->dma_enabled)
+			sysc |= 0x0 << SYSC_SIDLEMODE_SHIFT;
+		else
+			sysc |= 0x2 << SYSC_SIDLEMODE_SHIFT;
+	} else {
 		sysc |= 0x1 << SYSC_SIDLEMODE_SHIFT;
+	}
 	omap_hwmod_write_sysc(sysc, p->oh);
 }

@@ -540,14 +548,17 @@ void __init omap_serial_early_init(void)
 void __init omap_serial_init(void)
 {
 	struct omap_uart_state *uart;
+	char *name;

 	list_for_each_entry(uart, &uart_list, node) {
 		struct omap_hwmod *oh = uart->oh;
 		struct omap_device *od;
 		void *pdata = NULL;
 		u32 pdata_size = 0;
+
+		uart->dma_enabled = 0;
 #ifdef CONFIG_SERIAL_8250_CONSOLE
-		char *name = "serial8250";
+		name = "serial8250";
 		struct plat_serial8250_port ports[2] = {
 			{},
 			{.flags = 0},
@@ -578,14 +589,20 @@ void __init omap_serial_init(void)
 		pdata_size = 2 * sizeof(struct plat_serial8250_port);
 #endif
 #ifdef CONFIG_SERIAL_OMAP_CONSOLE
-		struct uart_port_info p;
-		char *name = "omap-hsuart";
+		struct omap_uart_port_info omap_up;
+		name = "omap-hsuart";
+
+		omap_up.dma_enabled = 0;
+		uart->dma_enabled =  omap_up.dma_enabled;

-		p.dma_enabled = 0;
-		p.uartclk = OMAP24XX_BASE_BAUD * 16;
+		omap_up.uartclk = OMAP24XX_BASE_BAUD * 16;
+		omap_up.mapbase = oh->slaves[0]->addr->pa_start;
+		omap_up.membase = oh->_rt_va;
+		omap_up.irqflags = IRQF_SHARED;
+		omap_up.flags = UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;

-		pdata = &p;
-		pdata_size = sizeof(struct uart_port_info);
+		pdata = &omap_up;
+		pdata_size = sizeof(struct omap_uart_port_info);
 #endif

 		if (WARN_ON(!oh))

Do you want me to re-post this patch integrating the above changes?
If changes are fine with you.

-- 
Regards,
Govindraj.R


On Wed, Nov 25, 2009 at 1:26 AM, Kevin Hilman <khilman@deeprootsystems.com> wrote:
> Convert UART core and PM support to use omap_device layer.  Also add
> support for both console on 8250 or omap-serial driver.
>
> omap_device conversion:
> - Convert clock API calls to omap_device calls
> - Remove all static platform_data setup and configuration.  This is
>  all done by the omap_device build phase.
>
> Known issues:
> - broken on OMAP4 until OMAP4 UART hwmods are available
>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/serial.c |  338 +++++++++++++++++++-----------------------
>  1 files changed, 154 insertions(+), 184 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 3595ffa..c067416 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -24,20 +24,33 @@
>  #include <linux/io.h>
>  #include <linux/platform_device.h>
>
> +#ifdef CONFIG_SERIAL_8250_CONSOLE
> +#include <linux/serial_8250.h>
> +#endif
> +
> +#ifdef CONFIG_SERIAL_OMAP_CONSOLE
> +#include <plat/omap-serial.h>
> +#endif
> +
>  #include <plat/common.h>
>  #include <plat/board.h>
>  #include <plat/clock.h>
>  #include <plat/control.h>
>  #include <plat/dma.h>
> +#include <plat/omap_hwmod.h>
> +#include <plat/omap_device.h>
>
>  #include "prm.h"
>  #include "pm.h"
> +#include "cm.h"
>  #include "prm-regbits-34xx.h"
>
>  #define UART_OMAP_WER          0x17    /* Wake-up enable register */
>
>  #define DEFAULT_TIMEOUT (5 * HZ)
>
> +#define MAX_UART_HWMOD_NAME_LEN                16
> +
>  struct omap_uart_state {
>        int num;
>        int can_sleep;
> @@ -61,7 +74,8 @@ struct omap_uart_state {
>        resource_size_t mapbase;
>
>        struct list_head node;
> -       struct platform_device pdev;
> +       struct omap_hwmod *oh;
> +       struct platform_device *pdev;
>
>  #if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
>        int context_valid;
> @@ -78,102 +92,13 @@ struct omap_uart_state {
>
>  static LIST_HEAD(uart_list);
>
> -#ifdef CONFIG_SERIAL_8250
> -#include <linux/serial_8250.h>
> -
> -static struct plat_serial8250_port serial_platform_data0[] = {
> -       {
> -               .mapbase        = OMAP_UART1_BASE,
> -               .irq            = 72,
> -               .flags          = UPF_BOOT_AUTOCONF,
> -               .iotype         = UPIO_MEM,
> -               .regshift       = 2,
> -               .uartclk        = OMAP24XX_BASE_BAUD * 16,
> -       }, {
> -               .flags          = 0
> -       }
> -};
> -
> -static struct plat_serial8250_port serial_platform_data1[] = {
> -       {
> -               .mapbase        = OMAP_UART2_BASE,
> -               .irq            = 73,
> -               .flags          = UPF_BOOT_AUTOCONF,
> -               .iotype         = UPIO_MEM,
> -               .regshift       = 2,
> -               .uartclk        = OMAP24XX_BASE_BAUD * 16,
> -       }, {
> -               .flags          = 0
> -       }
> -};
> -
> -static struct plat_serial8250_port serial_platform_data2[] = {
> +static struct omap_device_pm_latency omap_uart_latency[] = {
>        {
> -               .mapbase        = OMAP_UART3_BASE,
> -               .irq            = 74,
> -               .flags          = UPF_BOOT_AUTOCONF,
> -               .iotype         = UPIO_MEM,
> -               .regshift       = 2,
> -               .uartclk        = OMAP24XX_BASE_BAUD * 16,
> -       }, {
> -               .flags          = 0
> -       }
> -};
> -
> -#ifdef CONFIG_ARCH_OMAP4
> -static struct plat_serial8250_port serial_platform_data3[] = {
> -       {
> -               .mapbase        = OMAP_UART4_BASE,
> -               .irq            = 70,
> -               .flags          = UPF_BOOT_AUTOCONF,
> -               .iotype         = UPIO_MEM,
> -               .regshift       = 2,
> -               .uartclk        = OMAP24XX_BASE_BAUD * 16,
> -       }, {
> -               .flags          = 0
> -       }
> -};
> -#endif
> -
> -static struct omap_uart_state omap_uart[] = {
> -       {
> -               .pdev = {
> -                       .name                   = "serial8250",
> -                       .id                     = PLAT8250_DEV_PLATFORM,
> -                       .dev                    = {
> -                               .platform_data  = serial_platform_data0,
> -                       },
> -               },
> -       }, {
> -               .pdev = {
> -                       .name                   = "serial8250",
> -                       .id                     = PLAT8250_DEV_PLATFORM1,
> -                       .dev                    = {
> -                               .platform_data  = serial_platform_data1,
> -                       },
> -               },
> -       }, {
> -               .pdev = {
> -                       .name                   = "serial8250",
> -                       .id                     = PLAT8250_DEV_PLATFORM2,
> -                       .dev                    = {
> -                               .platform_data  = serial_platform_data2,
> -                       },
> -               },
> -       },
> -#ifdef CONFIG_ARCH_OMAP4
> -       {
> -               .pdev = {
> -                       .name                   = "serial8250",
> -                       .id                     = 3,
> -                       .dev                    = {
> -                               .platform_data  = serial_platform_data3,
> -                       },
> -               },
> +               .deactivate_func = omap_device_idle_hwmods,
> +               .activate_func   = omap_device_enable_hwmods,
> +               .flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
>        },
> -#endif
>  };
> -#endif
>
>  static inline unsigned int serial_read_reg(struct omap_uart_state *up,
>                                           int offset)
> @@ -200,7 +125,6 @@ static inline void __init omap_uart_reset(struct omap_uart_state *p)
>        serial_write_reg(p, UART_OMAP_MDR1, 0x07);
>        serial_write_reg(p, UART_OMAP_SCR, 0x08);
>        serial_write_reg(p, UART_OMAP_MDR1, 0x00);
> -       serial_write_reg(p, UART_OMAP_SYSC, (0x02 << 3) | (1 << 2) | (1 << 0));
>  }
>
>  #if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3)
> @@ -267,8 +191,7 @@ static inline void omap_uart_enable_clocks(struct omap_uart_state *uart)
>        if (uart->clocked)
>                return;
>
> -       clk_enable(uart->ick);
> -       clk_enable(uart->fck);
> +       omap_device_enable(uart->pdev);
>        uart->clocked = 1;
>        omap_uart_restore_context(uart);
>  }
> @@ -282,8 +205,7 @@ static inline void omap_uart_disable_clocks(struct omap_uart_state *uart)
>
>        omap_uart_save_context(uart);
>        uart->clocked = 0;
> -       clk_disable(uart->ick);
> -       clk_disable(uart->fck);
> +       omap_device_idle(uart->pdev);
>  }
>
>  static void omap_uart_enable_wakeup(struct omap_uart_state *uart)
> @@ -320,18 +242,18 @@ static void omap_uart_disable_wakeup(struct omap_uart_state *uart)
>        }
>  }
>
> -static void omap_uart_smart_idle_enable(struct omap_uart_state *p,
> -                                       int enable)
> +static inline void omap_uart_smart_idle_enable(struct omap_uart_state *p,
> +                                              int enable)
>  {
> -       u16 sysc;
> +       u32 sysc;
>
> -       sysc = serial_read_reg(p, UART_OMAP_SYSC) & 0x7;
> +       sysc = omap_hwmod_read_sysc(p->oh);
> +       sysc &= ~SYSC_SIDLEMODE_MASK;
>        if (enable)
> -               sysc |= 0x2 << 3;
> +               sysc |= 0x2 << SYSC_SIDLEMODE_SHIFT;
>        else
> -               sysc |= 0x1 << 3;
> -
> -       serial_write_reg(p, UART_OMAP_SYSC, sysc);
> +               sysc |= 0x1 << SYSC_SIDLEMODE_SHIFT;
> +       omap_hwmod_write_sysc(sysc, p->oh);
>  }
>
>  static void omap_uart_block_sleep(struct omap_uart_state *uart)
> @@ -348,7 +270,7 @@ static void omap_uart_block_sleep(struct omap_uart_state *uart)
>
>  static void omap_uart_allow_sleep(struct omap_uart_state *uart)
>  {
> -       if (device_may_wakeup(&uart->pdev.dev))
> +       if (device_may_wakeup(&uart->pdev->dev))
>                omap_uart_enable_wakeup(uart);
>        else
>                omap_uart_disable_wakeup(uart);
> @@ -443,6 +365,7 @@ int omap_uart_can_sleep(void)
>  * UART will not idle or sleep for its timeout period.
>  *
>  **/
> +/* static int first_interrupt; */
>  static irqreturn_t omap_uart_interrupt(int irq, void *dev_id)
>  {
>        struct omap_uart_state *uart = dev_id;
> @@ -516,8 +439,8 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
>        }
>
>        uart->irqflags |= IRQF_SHARED;
> -       ret = request_irq(uart->irq, omap_uart_interrupt, IRQF_SHARED,
> -                         "serial idle", (void *)uart);
> +       ret = request_threaded_irq(uart->irq, NULL, omap_uart_interrupt,
> +                                  IRQF_SHARED, "serial idle", (void *)uart);
>        WARN_ON(ret);
>  }
>
> @@ -528,8 +451,11 @@ void omap_uart_enable_irqs(int enable)
>
>        list_for_each_entry(uart, &uart_list, node) {
>                if (enable)
> -                       ret = request_irq(uart->irq, omap_uart_interrupt,
> -                               IRQF_SHARED, "serial idle", (void *)uart);
> +                       ret = request_threaded_irq(uart->irq, NULL,
> +                                                  omap_uart_interrupt,
> +                                                  IRQF_SHARED,
> +                                                  "serial idle",
> +                                                  (void *)uart);
>                else
>                        free_irq(uart->irq, (void *)uart);
>        }
> @@ -539,10 +465,9 @@ static ssize_t sleep_timeout_show(struct device *dev,
>                                  struct device_attribute *attr,
>                                  char *buf)
>  {
> -       struct platform_device *pdev = container_of(dev,
> -                                       struct platform_device, dev);
> -       struct omap_uart_state *uart = container_of(pdev,
> -                                       struct omap_uart_state, pdev);
> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct omap_device *odev = to_omap_device(pdev);
> +       struct omap_uart_state *uart = odev->hwmods[0]->dev_attr;
>
>        return sprintf(buf, "%u\n", uart->timeout / HZ);
>  }
> @@ -551,10 +476,9 @@ static ssize_t sleep_timeout_store(struct device *dev,
>                                   struct device_attribute *attr,
>                                   const char *buf, size_t n)
>  {
> -       struct platform_device *pdev = container_of(dev,
> -                                       struct platform_device, dev);
> -       struct omap_uart_state *uart = container_of(pdev,
> -                                       struct omap_uart_state, pdev);
> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct omap_device *odev = to_omap_device(pdev);
> +       struct omap_uart_state *uart = odev->hwmods[0]->dev_attr;
>        unsigned int value;
>
>        if (sscanf(buf, "%u", &value) != 1) {
> @@ -582,87 +506,133 @@ static inline void omap_uart_idle_init(struct omap_uart_state *uart) {}
>
>  void __init omap_serial_early_init(void)
>  {
> -       int i;
> -       char name[16];
> -
> -       /*
> -        * Make sure the serial ports are muxed on at this point.
> -        * You have to mux them off in device drivers later on
> -        * if not needed.
> -        */
> +       int i = 0;
>
> -       for (i = 0; i < ARRAY_SIZE(omap_uart); i++) {
> -               struct omap_uart_state *uart = &omap_uart[i];
> +       do {
> +               char oh_name[MAX_UART_HWMOD_NAME_LEN];
> +               struct omap_hwmod *oh;
> +               struct omap_uart_state *uart;
>
> -               uart->num = i;
> -
> -               /*
> -                * Module 4KB + L4 interconnect 4KB
> -                * Static mapping, never released
> -                */
> -               uart->membase = ioremap(uart->mapbase, SZ_8K);
> -               if (!uart->membase) {
> -                       printk(KERN_ERR "ioremap failed for uart%i\n", i + 1);
> -                       continue;
> -               }
> -
> -               sprintf(name, "uart%d_ick", i+1);
> -               uart->ick = clk_get(NULL, name);
> -               if (IS_ERR(uart->ick)) {
> -                       printk(KERN_ERR "Could not get uart%d_ick\n", i+1);
> -                       uart->ick = NULL;
> -               }
> -
> -               sprintf(name, "uart%d_fck", i+1);
> -               uart->fck = clk_get(NULL, name);
> -               if (IS_ERR(uart->fck)) {
> -                       printk(KERN_ERR "Could not get uart%d_fck\n", i+1);
> -                       uart->fck = NULL;
> -               }
> +               snprintf(oh_name, MAX_UART_HWMOD_NAME_LEN,
> +                        "uart%d_hwmod", i + 1);
> +               oh = omap_hwmod_lookup(oh_name);
> +               if (!oh)
> +                       break;
>
> -               /* FIXME: Remove this once the clkdev is ready */
> -               if (!cpu_is_omap44xx()) {
> -                       if (!uart->ick || !uart->fck)
> -                               continue;
> -               }
> +               uart = kzalloc(sizeof(struct omap_uart_state), GFP_KERNEL);
> +               if (WARN_ON(!uart))
> +                       return;
>
> +               uart->oh = oh;
> +               uart->num = i++;
>                list_add_tail(&uart->node, &uart_list);
>
> -               if (cpu_is_omap44xx())
> -                       uart->irq += 32;
> -
> -               omap_uart_enable_clocks(uart);
> -       }
> +               /* NOTE: omap_hwmod_init() has not yet been called,
> +                *       so no hwmod functions will work yet. */
> +#ifdef CONFIG_DEBUG_LL
> +               /* For DEBUG_LL, don't reset/idle the UARTs otherwise
> +                * early UART access will fault. */
> +               uart->oh->flags |= HWMOD_INIT_NO_IDLE;
> +#endif
> +       } while(1);
>  }
>
>  void __init omap_serial_init(void)
>  {
> -       int i;
> -
> -       for (i = 0; i < ARRAY_SIZE(omap_uart); i++) {
> -               struct omap_uart_state *uart = &omap_uart[i];
> -               struct platform_device *pdev = &uart->pdev;
> -               struct device *dev = &pdev->dev;
> -#ifdef CONFIG_SERIAL_8250
> -               struct plat_serial8250_port *p = dev->platform_data;
> +       struct omap_uart_state *uart;
> +
> +       list_for_each_entry(uart, &uart_list, node) {
> +               struct omap_hwmod *oh = uart->oh;
> +               struct omap_device *od;
> +               void *pdata = NULL;
> +               u32 pdata_size = 0;
> +#ifdef CONFIG_SERIAL_8250_CONSOLE
> +               char *name = "serial8250";
> +               struct plat_serial8250_port ports[2] = {
> +                       {},
> +                       {.flags = 0},
> +               };
> +               struct plat_serial8250_port *p = &ports[0];
> +
> +               /*
> +                * !! 8250 driver does not use standard IORESOURCE* It
> +                * has it's own custom pdata that can be taken from
> +                * the hwmod resource data.  But, this needs to be
> +                * done after the build.
> +                *
> +                * ?? does it have to be done before the register ??
> +                * YES, because platform_device_data_add() copies
> +                * pdata, it does not use a pointer.
> +                */
> +               p->flags = UPF_BOOT_AUTOCONF;
> +               p->iotype = UPIO_MEM;
> +               p->regshift = 2;
> +               p->uartclk = OMAP24XX_BASE_BAUD * 16;
> +               p->irq = oh->mpu_irqs[0].irq;
> +               p->mapbase = oh->slaves[0]->addr->pa_start;
> +               p->membase = oh->_rt_va;
> +               p->irqflags = IRQF_SHARED;
> +               p->private_data = uart;
> +
> +               pdata = &ports[0];
> +               pdata_size = 2 * sizeof(struct plat_serial8250_port);
>  #endif
> +#ifdef CONFIG_SERIAL_OMAP_CONSOLE
> +               struct uart_port_info p;
> +               char *name = "omap-hsuart";
>
> -               omap_uart_reset(uart);
> -               omap_uart_idle_init(uart);
> +               p.dma_enabled = 0;
> +               p.uartclk = OMAP24XX_BASE_BAUD * 16;
>
> -#ifdef CONFIG_SERIAL_8250
> -               p->membase = uart->membase;
> -               p->mapbase = uart->mapbase;
> -               p->irq     = uart->irq;
> -               p->irqflags = uart->irqflags;
> -               p->private_data = uart;
> +               pdata = &p;
> +               pdata_size = sizeof(struct uart_port_info);
>  #endif
> -               if (WARN_ON(platform_device_register(pdev)))
> +
> +               if (WARN_ON(!oh))
>                        continue;
> +
> +               od = omap_device_build(name, uart->num, oh, pdata, pdata_size,
> +                                      omap_uart_latency,
> +                                      ARRAY_SIZE(omap_uart_latency));
> +               WARN(IS_ERR(od), "Could not build omap_device for %s: %s.\n",
> +                    name, oh->name);
> +
> +               uart->irq = oh->mpu_irqs[0].irq;
> +               uart->regshift = 2;
> +               uart->mapbase = oh->slaves[0]->addr->pa_start;
> +               uart->membase = oh->_rt_va;
> +               uart->pdev = &od->pdev;
> +
> +               oh->dev_attr = uart;
> +
> +#ifdef CONFIG_DEBUG_LL
> +               /*
> +                * Because of earlyprintk output, UART did not get idled
> +                * on init.  Now that omap_device is ready, ensure full idle
> +                * before doing omap_device_enable().
> +                */
> +               omap_hwmod_idle(uart->oh);
> +#endif
> +               omap_device_enable(uart->pdev);
> +               omap_uart_idle_init(uart);
> +               omap_uart_reset(uart);
> +               omap_hwmod_enable_wakeup(uart->oh);
> +               omap_device_idle(uart->pdev);
> +
> +               /*
> +                * Need to block sleep long enough for interrupt driven
> +                * driver to start.  Console driver is in polling mode
> +                * so device needs to be kept enabled while polling driver
> +                * is in use.
> +                */
> +               uart->timeout = (30 * HZ);
> +               omap_uart_block_sleep(uart);
> +               uart->timeout = DEFAULT_TIMEOUT;
> +
>                if ((cpu_is_omap34xx() && uart->padconf) ||
>                    (uart->wk_en && uart->wk_mask)) {
> -                       device_init_wakeup(dev, true);
> -                       DEV_CREATE_FILE(dev, &dev_attr_sleep_timeout);
> +                       device_init_wakeup(&od->pdev.dev, true);
> +                       DEV_CREATE_FILE(&od->pdev.dev, &dev_attr_sleep_timeout);
>                }
>        }
>  }
> --
> 1.6.5.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


