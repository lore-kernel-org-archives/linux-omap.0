From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 3/3] mfd: twl: move header file out of I2C realm
Date: Mon, 22 May 2017 11:14:50 +0200
Message-ID: <20170522091450.auxaosd7aipjbjaa@piout.net>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-4-wsa@the-dreams.de>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <rtc-linux+bncBCKYNX7Y3IMBBFOYRLEQKGQEV6MTHDI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20170521220212.1404-4-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Daniel Thompson <daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Wim
List-Id: linux-omap@vger.kernel.org

On 22/05/2017 at 00:02:10 +0200, Wolfram Sang wrote:
> include/linux/i2c is not for client devices. Move the header file to a
> more appropriate location.
> 
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Acked-by: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

> ---
>  arch/arm/mach-omap2/common.h            | 2 +-
>  arch/arm/mach-omap2/omap_twl.c          | 2 +-
>  drivers/gpio/gpio-twl4030.c             | 2 +-
>  drivers/iio/adc/twl4030-madc.c          | 2 +-
>  drivers/iio/adc/twl6030-gpadc.c         | 2 +-
>  drivers/input/keyboard/twl4030_keypad.c | 2 +-
>  drivers/input/misc/twl4030-pwrbutton.c  | 2 +-
>  drivers/input/misc/twl4030-vibra.c      | 2 +-
>  drivers/mfd/twl-core.c                  | 6 +++---
>  drivers/mfd/twl4030-audio.c             | 2 +-
>  drivers/mfd/twl4030-irq.c               | 2 +-
>  drivers/mfd/twl4030-power.c             | 2 +-
>  drivers/mfd/twl6030-irq.c               | 2 +-
>  drivers/phy/phy-twl4030-usb.c           | 2 +-
>  drivers/power/supply/twl4030_charger.c  | 2 +-
>  drivers/pwm/pwm-twl-led.c               | 2 +-
>  drivers/pwm/pwm-twl.c                   | 2 +-
>  drivers/regulator/twl-regulator.c       | 2 +-
>  drivers/regulator/twl6030-regulator.c   | 2 +-
>  drivers/rtc/rtc-twl.c                   | 2 +-
>  drivers/usb/phy/phy-twl6030-usb.c       | 2 +-
>  drivers/video/backlight/pandora_bl.c    | 2 +-
>  drivers/watchdog/twl4030_wdt.c          | 2 +-
>  include/linux/{i2c => mfd}/twl.h        | 0
>  sound/soc/codecs/twl4030.c              | 2 +-
>  25 files changed, 26 insertions(+), 26 deletions(-)
>  rename include/linux/{i2c => mfd}/twl.h (100%)
> 
> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
> index 8cc6338fcb1288..b5ad7fcb80ed24 100644
> --- a/arch/arm/mach-omap2/common.h
> +++ b/arch/arm/mach-omap2/common.h
> @@ -29,7 +29,7 @@
>  #include <linux/irq.h>
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
> -#include <linux/i2c/twl.h>
> +#include <linux/mfd/twl.h>
>  #include <linux/i2c-omap.h>
>  #include <linux/reboot.h>
>  #include <linux/irqchip/irq-omap-intc.h>
> diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
> index 1346b3ab34a5e3..295124b248ae3f 100644
> --- a/arch/arm/mach-omap2/omap_twl.c
> +++ b/arch/arm/mach-omap2/omap_twl.c
> @@ -16,7 +16,7 @@
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> -#include <linux/i2c/twl.h>
> +#include <linux/mfd/twl.h>
>  
>  #include "soc.h"
>  #include "voltage.h"
> diff --git a/drivers/gpio/gpio-twl4030.c b/drivers/gpio/gpio-twl4030.c
> index 24f388ed46d4c4..9b511df5450eb6 100644
> --- a/drivers/gpio/gpio-twl4030.c
> +++ b/drivers/gpio/gpio-twl4030.c
> @@ -35,7 +35,7 @@
>  #include <linux/of.h>
>  #include <linux/irqdomain.h>
>  
> -#include <linux/i2c/twl.h>
> +#include <linux/mfd/twl.h>
>  
>  /*
>   * The GPIO "subchip" supports 18 GPIOs which can be configured as
> diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
> index 0c74869a540ad3..5a64eda1652061 100644
> --- a/drivers/iio/adc/twl4030-madc.c
> +++ b/drivers/iio/adc/twl4030-madc.c
> @@ -35,7 +35,7 @@
>  #include <linux/delay.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> -#include <linux/i2c/twl.h>
> +#include <linux/mfd/twl.h>
>  #include <linux/i2c/twl4030-madc.h>
>  #include <linux/module.h>
>  #include <linux/stddef.h>
> diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
> index becbb0aef232b9..bc0e60b9da452e 100644
> --- a/drivers/iio/adc/twl6030-gpadc.c
> +++ b/drivers/iio/adc/twl6030-gpadc.c
> @@ -33,7 +33,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/of_platform.h>
> -#include <linux/i2c/twl.h>
> +#include <linux/mfd/twl.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  
> diff --git a/drivers/input/keyboard/twl4030_keypad.c b/drivers/input/keyboard/twl4030_keypad.c
> index 39e72b3219d8a4..f9f98ef1d98e3f 100644
> --- a/drivers/input/keyboard/twl4030_keypad.c
> +++ b/drivers/input/keyboard/twl4030_keypad.c
> @@ -30,7 +30,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/input.h>
>  #include <linux/platform_device.h>
> -#include <linux/i2c/twl.h>
> +#include <linux/mfd/twl.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>
>  
> diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/twl4030-pwrbutton.c
> index 1c13005b228fa7..b307cca1702226 100644
> --- a/drivers/input/misc/twl4030-pwrbutton.c
> +++ b/drivers/input/misc/twl4030-pwrbutton.c
> @@ -27,7 +27,7 @@
>  #include <linux/input.h>
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
> -#include <linux/i2c/twl.h>
> +#include <linux/mfd/twl.h>
>  
>  #define PWR_PWRON_IRQ (1 << 0)
>  
> diff --git a/drivers/input/misc/twl4030-vibra.c b/drivers/input/misc/twl4030-vibra.c
> index caa5a62c42fbe0..6c51d404874bbd 100644
> --- a/drivers/input/misc/twl4030-vibra.c
> +++ b/drivers/input/misc/twl4030-vibra.c
> @@ -28,7 +28,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/of.h>
>  #include <linux/workqueue.h>
> -#include <linux/i2c/twl.h>
> +#include <linux/mfd/twl.h>
>  #include <linux/mfd/twl4030-audio.h>
>  #include <linux/input.h>
>  #include <linux/slab.h>
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index c64615dca2bd33..2a09dde4ca6efc 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -44,7 +44,7 @@
>  #include <linux/regulator/machine.h>
>  
>  #include <linux/i2c.h>
> -#include <linux/i2c/twl.h>
> +#include <linux/mfd/twl.h>
>  
>  /* Register descriptions for audio */
>  #include <linux/mfd/twl4030-audio.h>
> @@ -173,7 +173,7 @@ static struct twl_private *twl_priv;
>  static struct twl_mapping twl4030_map[] = {
>  	/*
>  	 * NOTE:  don't change this table without updating the
> -	 * <linux/i2c/twl.h> defines for TWL4030_MODULE_*
> +	 * <linux/mfd/twl.h> defines for TWL4030_MODULE_*
>  	 * so they continue to match the order in this table.
>  	 */
>  
> @@ -344,7 +344,7 @@ static const struct regmap_config twl4030_regmap_config[4] = {
>  static struct twl_mapping twl6030_map[] = {
>  	/*
>  	 * NOTE:  don't change this table without updating the
> -	 * <linux/i2c/twl.h> defines for TWL4030_MODULE_*
> +	 * <linux/mfd/twl.h> defines for TWL4030_MODULE_*
>  	 * so they continue to match the order in this table.
>  	 */
>  
> diff --git a/drivers/mfd/twl4030-audio.c b/drivers/mfd/twl4030-audio.c
> index 0a1606480023f9..da16bf45fab43e 100644
> --- a/drivers/mfd/twl4030-audio.c
> +++ b/drivers/mfd/twl4030-audio.c
> @@ -30,7 +30,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
> -#include <linux/i2c/twl.h>
> +#include <linux/mfd/twl.h>
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/twl4030-audio.h>
>  
> diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
> index b46c0cfc27d958..86f8fd8e81e4b5 100644
> --- a/drivers/mfd/twl4030-irq.c
> +++ b/drivers/mfd/twl4030-irq.c
> @@ -33,7 +33,7 @@
>  #include <linux/slab.h>
>  #include <linux/of.h>
>  #include <linux/irqdomain.h>
> -#include <linux/i2c/twl.h>
> +#include <linux/mfd/twl.h>
>  
>  #include "twl-core.h"
>  
> diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
> index f4b2c29d77e330..6b36932263ba78 100644
> --- a/drivers/mfd/twl4030-power.c
> +++ b/drivers/mfd/twl4030-power.c
> @@ -25,7 +25,7 @@
>  
>  #include <linux/module.h>
>  #include <linux/pm.h>
> -#include <linux/i2c/twl.h>
> +#include <linux/mfd/twl.h>
>  #include <linux/platform_device.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
> index 53574508a613f2..e3ec8dfa9f1ec0 100644
> --- a/drivers/mfd/twl6030-irq.c
> +++ b/drivers/mfd/twl6030-irq.c
> @@ -35,7 +35,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/kthread.h>
> -#include <linux/i2c/twl.h>
> +#include <linux/mfd/twl.h>
>  #include <linux/platform_device.h>
>  #include <linux/suspend.h>
>  #include <linux/of.h>
> diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl4030-usb.c
> index 2990b3965460e8..28f49902760d82 100644
> --- a/drivers/phy/phy-twl4030-usb.c
> +++ b/drivers/phy/phy-twl4030-usb.c
> @@ -36,7 +36,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/usb/musb.h>
>  #include <linux/usb/ulpi.h>
> -#include <linux/i2c/twl.h>
> +#include <linux/mfd/twl.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/err.h>
>  #include <linux/slab.h>
> diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
> index 2f82d0e9ec1bf7..390bfde86ae39b 100644
> --- a/drivers/power/supply/twl4030_charger.c
> +++ b/drivers/power/supply/twl4030_charger.c
> @@ -18,7 +18,7 @@
>  #include <linux/err.h>
>  #include <linux/platform_device.h>
>  #include <linux/interrupt.h>
> -#include <linux/i2c/twl.h>
> +#include <linux/mfd/twl.h>
>  #include <linux/power_supply.h>
>  #include <linux/notifier.h>
>  #include <linux/usb/otg.h>
> diff --git a/drivers/pwm/pwm-twl-led.c b/drivers/pwm/pwm-twl-led.c
> index 21eff991d0e355..01153622778bad 100644
> --- a/drivers/pwm/pwm-twl-led.c
> +++ b/drivers/pwm/pwm-twl-led.c
> @@ -24,7 +24,7 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pwm.h>
> -#include <linux/i2c/twl.h>
> +#include <linux/mfd/twl.h>
>  #include <linux/slab.h>
>  
>  /*
> diff --git a/drivers/pwm/pwm-twl.c b/drivers/pwm/pwm-twl.c
> index 9de617b766801b..b7a45be998153b 100644
> --- a/drivers/pwm/pwm-twl.c
> +++ b/drivers/pwm/pwm-twl.c
> @@ -21,7 +21,7 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pwm.h>
> -#include <linux/i2c/twl.h>
> +#include <linux/mfd/twl.h>
>  #include <linux/slab.h>
>  
>  /*
> diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
> index 6c9ec84121bde4..a4456db5849d06 100644
> --- a/drivers/regulator/twl-regulator.c
> +++ b/drivers/regulator/twl-regulator.c
> @@ -20,7 +20,7 @@
>  #include <linux/regulator/driver.h>
>  #include <linux/regulator/machine.h>
>  #include <linux/regulator/of_regulator.h>
> -#include <linux/i2c/twl.h>
> +#include <linux/mfd/twl.h>
>  #include <linux/delay.h>
>  
>  /*
> diff --git a/drivers/regulator/twl6030-regulator.c b/drivers/regulator/twl6030-regulator.c
> index 56aada38788776..219cbd910dbf52 100644
> --- a/drivers/regulator/twl6030-regulator.c
> +++ b/drivers/regulator/twl6030-regulator.c
> @@ -21,7 +21,7 @@
>  #include <linux/regulator/driver.h>
>  #include <linux/regulator/machine.h>
>  #include <linux/regulator/of_regulator.h>
> -#include <linux/i2c/twl.h>
> +#include <linux/mfd/twl.h>
>  #include <linux/delay.h>
>  
>  struct twlreg_info {
> diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
> index c18c39212ce680..3472e79f2b1782 100644
> --- a/drivers/rtc/rtc-twl.c
> +++ b/drivers/rtc/rtc-twl.c
> @@ -31,7 +31,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/of.h>
>  
> -#include <linux/i2c/twl.h>
> +#include <linux/mfd/twl.h>
>  
>  enum twl_class {
>  	TWL_4030 = 0,
> diff --git a/drivers/usb/phy/phy-twl6030-usb.c b/drivers/usb/phy/phy-twl6030-usb.c
> index 628b600b02b174..b5dc077ed7d3c6 100644
> --- a/drivers/usb/phy/phy-twl6030-usb.c
> +++ b/drivers/usb/phy/phy-twl6030-usb.c
> @@ -28,7 +28,7 @@
>  #include <linux/usb/musb.h>
>  #include <linux/usb/phy_companion.h>
>  #include <linux/phy/omap_usb.h>
> -#include <linux/i2c/twl.h>
> +#include <linux/mfd/twl.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/err.h>
>  #include <linux/slab.h>
> diff --git a/drivers/video/backlight/pandora_bl.c b/drivers/video/backlight/pandora_bl.c
> index 5d8bb8b201835d..a186bc677c7d80 100644
> --- a/drivers/video/backlight/pandora_bl.c
> +++ b/drivers/video/backlight/pandora_bl.c
> @@ -16,7 +16,7 @@
>  #include <linux/delay.h>
>  #include <linux/fb.h>
>  #include <linux/backlight.h>
> -#include <linux/i2c/twl.h>
> +#include <linux/mfd/twl.h>
>  #include <linux/err.h>
>  
>  #define TWL_PWM0_ON		0x00
> diff --git a/drivers/watchdog/twl4030_wdt.c b/drivers/watchdog/twl4030_wdt.c
> index 9bf3cc0f396106..569fe85e52da75 100644
> --- a/drivers/watchdog/twl4030_wdt.c
> +++ b/drivers/watchdog/twl4030_wdt.c
> @@ -24,7 +24,7 @@
>  #include <linux/kernel.h>
>  #include <linux/watchdog.h>
>  #include <linux/platform_device.h>
> -#include <linux/i2c/twl.h>
> +#include <linux/mfd/twl.h>
>  
>  #define TWL4030_WATCHDOG_CFG_REG_OFFS	0x3
>  
> diff --git a/include/linux/i2c/twl.h b/include/linux/mfd/twl.h
> similarity index 100%
> rename from include/linux/i2c/twl.h
> rename to include/linux/mfd/twl.h
> diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
> index a2104d68169d9e..bd86a2d78c5ff2 100644
> --- a/sound/soc/codecs/twl4030.c
> +++ b/sound/soc/codecs/twl4030.c
> @@ -28,7 +28,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/of.h>
>  #include <linux/of_gpio.h>
> -#include <linux/i2c/twl.h>
> +#include <linux/mfd/twl.h>
>  #include <linux/slab.h>
>  #include <linux/gpio.h>
>  #include <sound/core.h>
> -- 
> 2.11.0
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
