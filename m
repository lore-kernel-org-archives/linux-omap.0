From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH 10/12] Add support for HTC Typhoon leds.
Date: Tue, 12 Jun 2007 17:04:02 +0530
Message-ID: <5d5443650706120434o582ca28ahddd393fa9d258e5f@mail.gmail.com>
References: <466AE46B.3010605@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <466AE46B.3010605@free.fr>
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
To: Vivien Chappelier <vivien.chappelier@free.fr>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On 6/9/07, Vivien Chappelier <vivien.chappelier@free.fr> wrote:
> This patch add support for the HTC Typhoon tricolor led.
>
> Signed-off-by: Vivien Chappelier <vivien.chappelier@free.fr>
>
> ---
>  arch/arm/mach-omap1/Makefile       |    1 +
>  arch/arm/mach-omap1/leds-typhoon.c |  184
> ++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap1/leds.c         |    3 +
>  arch/arm/mach-omap1/leds.h         |    1 +
>  4 files changed, 189 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap1/leds-typhoon.c
>
> diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
> index 9f6bcbb..5153e43 100644
> --- a/arch/arm/mach-omap1/Makefile
> +++ b/arch/arm/mach-omap1/Makefile
> @@ -46,4 +46,5 @@ led-$(CONFIG_MACH_OMAP_H3)        += leds-h2p2-debug.o
>  led-$(CONFIG_MACH_OMAP_INNOVATOR)    += leds-innovator.o
>  led-$(CONFIG_MACH_OMAP_PERSEUS2)    += leds-h2p2-debug.o
>  led-$(CONFIG_MACH_OMAP_OSK)        += leds-osk.o
> +led-$(CONFIG_MACH_TYPHOON)        += leds-typhoon.o
>  obj-$(CONFIG_LEDS)            += $(led-y)
> diff --git a/arch/arm/mach-omap1/leds-typhoon.c
> b/arch/arm/mach-omap1/leds-typhoon.c
> new file mode 100644
> index 0000000..eff868f
> --- /dev/null
> +++ b/arch/arm/mach-omap1/leds-typhoon.c
> @@ -0,0 +1,184 @@
> +/*
> + * linux/arch/arm/mach-omap1/leds-typhoon.c
> + *
> + * Copyright 2005 Vivien Chappelier <vivien.chappelier@free.fr>
> + *   Modified from leds-h2p2-debug.c
> + *
> + * The HTC Typhoon has a tricolor led. Timers can be setup the 'red'
> + * and 'green' components for blinking. The 'blue' component is on/off
> only.
> + */
> +#include <linux/init.h>
> +#include <linux/kernel_stat.h>
> +#include <linux/sched.h>
> +#include <linux/version.h>
> +
> +#include <asm/io.h>
> +#include <asm/hardware.h>
> +#include <asm/leds.h>
> +#include <asm/system.h>
> +
> +#include <asm/arch/gpio.h>
> +#include <asm/arch/board-typhoon.h>
> +
> +#include "leds.h"
> +
> +/* led registers */
> +#define TYPHOON_LED_STATUS_ON       1
> +#define TYPHOON_LED_STATUS_OFF      0
> +#define TYPHOON_LED_STATUS_BLINK(on, off) (((on) << 2) | ((off) << 17))
> +
> +#define TYPHOON_LED_BASE   0xfffba800
> +#define TYPHOON_LED_ENABLE 0xfffba801
> +#    define LED_ON         (1 << 7)
> +#    define LED_BLINK      (1 << 6)
> +#    define LED_ONTIME(x)  ((x) & 0x7)
> +#    define LED_OFFTIME(x) (((x) & 0x7) << 3)
> +
> +/* led status */
> +#define LED_STATE_ENABLED     (1 << 7)
> +#define LED_STATE_CLAIMED     (1 << 6)
> +#define LED_BLUE  (1 <<  0)
> +#define LED_GREEN (1 <<  1)
> +#define LED_RED   (1 <<  2)
> +#define LED_MASK (LED_BLUE | LED_GREEN | LED_RED)
> +
> +#define LED_TIMER LED_GREEN
> +#define LED_CPU   LED_RED
> +
> +/* route power to the tricolor led */
> +static void typhoon_start_led(void)
> +{
> +    omap_writel(omap_readl(OMAP730_IO_CONF_10) & ~0x20,
> OMAP730_IO_CONF_10);
> +    omap_writel(omap_readl(OMAP730_IO_CONF_10) |  0xd0,
> OMAP730_IO_CONF_10);
> +    omap_set_gpio_direction(TYPHOON_GPIO_LED_BLUE, 0); /* out */
> +
> +    omap_writel(omap_readl(OMAP730_MODE_1) | (1 << 29), OMAP730_MODE_1);
> +    omap_writeb(LED_ON, TYPHOON_LED_BASE);
> +    omap_writeb(1, TYPHOON_LED_ENABLE);
> +}
> +
> +/* power off the tricolor led */
> +static void typhoon_stop_led(void)
> +{
> +    omap_writel(omap_readl(OMAP730_MODE_1) & ~(1 << 29), OMAP730_MODE_1);
> +    omap_writeb(0, TYPHOON_LED_BASE);
> +    omap_writeb(0, TYPHOON_LED_ENABLE);
> +}
> +
> +/* set the 'blue', 'green' and 'red' components of the tricolor led */
> +static void typhoon_set_led(int led)
> +{
> +    if(led & LED_BLUE)

space before opening parenthesis.

> +        omap_set_gpio_dataout(TYPHOON_GPIO_LED_BLUE, 1);
> +    else
> +        omap_set_gpio_dataout(TYPHOON_GPIO_LED_BLUE, 0);
> +
> +    if(led & (LED_RED | LED_GREEN)) {

Ditto.

> +        if(led & LED_GREEN) {

Ditto.
> +            omap_set_gpio_direction(TYPHOON_GPIO_LED_GREEN, 1);
> +        } else {
> +            omap_set_gpio_direction(TYPHOON_GPIO_LED_GREEN, 0);
> +            omap_set_gpio_dataout(TYPHOON_GPIO_LED_GREEN, 0);
> +        }
> +
> +        if(led & LED_RED) {

Ditto.

> +            omap_set_gpio_direction(TYPHOON_GPIO_LED_RED, 1);
> +        } else {
> +            omap_set_gpio_direction(TYPHOON_GPIO_LED_RED, 0);
> +            omap_set_gpio_dataout(TYPHOON_GPIO_LED_RED, 0);
> +        }
> +    } else {
> +        omap_set_gpio_direction(TYPHOON_GPIO_LED_GREEN, 0);
> +        omap_set_gpio_dataout(TYPHOON_GPIO_LED_GREEN, 0);
> +        omap_set_gpio_direction(TYPHOON_GPIO_LED_RED, 0);
> +        omap_set_gpio_dataout(TYPHOON_GPIO_LED_RED, 0);
> +    }
> +}
> +
> +
> +void typhoon_leds_event(led_event_t evt)
> +{
> +    unsigned long flags;
> +
> +    static u16 led_state, hw_led_state;
> +
> +    local_irq_save(flags);
> +
> +    if (!(led_state & LED_STATE_ENABLED) && evt != led_start)
> +        goto done;
> +
> +    switch (evt) {
> +    case led_start:
> +        typhoon_start_led();
> +        led_state |= LED_STATE_ENABLED;
> +        break;
> +
> +    case led_stop:
> +    case led_halted:
> +        /* all leds off during suspend or shutdown */
> +        typhoon_set_led(0);
> +        typhoon_stop_led();
> +        goto done;
> +
> +    case led_claim:
> +        led_state |= LED_STATE_CLAIMED;
> +        hw_led_state = 0;
> +        break;
> +
> +    case led_release:
> +        led_state &= ~LED_STATE_CLAIMED;
> +        break;
> +
> +#ifdef CONFIG_LEDS_TIMER
> +    case led_timer:
> +        led_state ^= LED_TIMER;
> +        break;
> +#endif
> +
> +#ifdef CONFIG_LEDS_CPU
> +    case led_idle_start:
> +        led_state &= ~LED_CPU;
> +        break;
> +
> +    case led_idle_end:
> +        led_state |= LED_CPU;
> +        break;
> +#endif
> +
> +    case led_green_on:
> +        hw_led_state |= LED_GREEN;
> +        break;
> +    case led_green_off:
> +        hw_led_state &= ~LED_GREEN;
> +        break;
> +
> +    case led_red_on:
> +        hw_led_state |= LED_RED;
> +        break;
> +    case led_red_off:
> +        hw_led_state &= ~LED_RED;
> +        break;
> +
> +    case led_blue_on:
> +        hw_led_state |= LED_BLUE;
> +        break;
> +    case led_blue_off:
> +        hw_led_state &= ~LED_BLUE;
> +        break;
> +
> +    default:
> +        break;
> +    }
> +
> +
> +    /*
> +     *  Actually burn the LEDs
> +     */
> +    if (led_state & LED_STATE_CLAIMED)
> +        typhoon_set_led(hw_led_state);
> +    else
> +        typhoon_set_led(led_state & LED_MASK);
> +
> +done:
> +    local_irq_restore(flags);
> +}
> diff --git a/arch/arm/mach-omap1/leds.c b/arch/arm/mach-omap1/leds.c
> index 3f9dcac..59b7135 100644
> --- a/arch/arm/mach-omap1/leds.c
> +++ b/arch/arm/mach-omap1/leds.c
> @@ -28,6 +28,9 @@ omap_leds_init(void)
>      else if (machine_is_omap_osk())
>          leds_event = osk_leds_event;
>
> +    else if (machine_is_typhoon())
> +        leds_event = typhoon_leds_event;
> +
>      else
>          return -1;
>
> diff --git a/arch/arm/mach-omap1/leds.h b/arch/arm/mach-omap1/leds.h
> index a1e9fed..1760eb0 100644
> --- a/arch/arm/mach-omap1/leds.h
> +++ b/arch/arm/mach-omap1/leds.h
> @@ -1,3 +1,4 @@
>  extern void innovator_leds_event(led_event_t evt);
>  extern void h2p2_dbg_leds_event(led_event_t evt);
>  extern void osk_leds_event(led_event_t evt);
> +extern void typhoon_leds_event(led_event_t evt);
> --
> 1.5.1.3
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>


-- 
--Trilok Soni
