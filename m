From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 3/3] pwm: New driver to support PWM driven LEDs on
 TWL4030/6030 series of PMICs
Date: Wed, 7 Nov 2012 20:12:54 +0200
Message-ID: <CANOLnONc29=cDZE=UXubs7DYOUWbgLJspPPVT2Hfq9E3zXkgVQ@mail.gmail.com>
References: <1352299488-11351-1-git-send-email-peter.ujfalusi@ti.com>
	<1352299488-11351-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352299488-11351-4-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Thierry Reding <thierry.reding@avionic-design.de>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 7, 2012 at 4:44 PM, Peter Ujfalusi <peter.ujfalusi@ti.com> =
wrote:
> The driver supports the following LED outputs as generic PWM driver:
> TWL4030 LEDA and LEDB (PWMA and PWMB)
> TWL6030 Charging indicator LED (PWM LED)
>
> On TWL6030 when the PWM requested LED is configured to be controlled =
by SW.
> In this case the user can enable/disable and set the duty period free=
ly.
> When the PWM has been freed, the LED driver is put back to HW control=
=2E
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/pwm/Kconfig       |  10 ++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-twl-led.c | 287 ++++++++++++++++++++++++++++++++++++=
++++++++++
>  3 files changed, 298 insertions(+)
>  create mode 100644 drivers/pwm/pwm-twl-led.c
>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index c577db9..49c2082 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -152,6 +152,16 @@ config PWM_TWL
>           To compile this driver as a module, choose M here: the modu=
le
>           will be called pwm-twl.
>
> +config PWM_TWL_LED
> +       tristate "TWL4030/6030 PWM support for LED drivers"
> +       select HAVE_PWM
> +       depends on TWL4030_CORE
> +       help
> +         Generic PWM framework driver for TWL4030/6030 LED.
> +
> +         To compile this driver as a module, choose M here: the modu=
le
> +         will be called pwm-twl-led.
> +
>  config PWM_VT8500
>         tristate "vt8500 pwm support"
>         depends on ARCH_VT8500
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 3324c06..5f26134 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -12,4 +12,5 @@ obj-$(CONFIG_PWM_TEGRA)               +=3D pwm-tegr=
a.o
>  obj-$(CONFIG_PWM_TIECAP)       +=3D pwm-tiecap.o
>  obj-$(CONFIG_PWM_TIEHRPWM)     +=3D pwm-tiehrpwm.o
>  obj-$(CONFIG_PWM_TWL)          +=3D pwm-twl.o
> +obj-$(CONFIG_PWM_TWL_LED)      +=3D pwm-twl-led.o
>  obj-$(CONFIG_PWM_VT8500)       +=3D pwm-vt8500.o
> diff --git a/drivers/pwm/pwm-twl-led.c b/drivers/pwm/pwm-twl-led.c
> new file mode 100644
> index 0000000..4d6ddc9
> --- /dev/null
> +++ b/drivers/pwm/pwm-twl-led.c
> @@ -0,0 +1,287 @@
> +/*
> + * Driver for TWL4030/6030 Pulse Width Modulator used as LED driver
> + *
> + * Copyright (C) 2012 Texas Instruments
> + * Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
> + *
> + * This driver is a complete rewrite of the former pwm-twl6030.c aut=
horded by:
> + * Hemanth V <hemanthv@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under the terms of the GNU General Public License version 2 as pu=
blished by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, b=
ut WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILIT=
Y or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Lic=
ense for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License=
 along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/i2c/twl.h>
> +#include <linux/slab.h>
> +
> +#define TWL4030_LED_MAX                0x7f
> +#define TWL6030_LED_MAX                0xff
> +
> +/* Registers, bits and macro for TWL4030 */
> +#define TWL4030_LEDEN_REG      0x00
> +#define TWL4030_PWMA_REG       0x01
> +
> +#define TWL4030_LEDXON         (1 << 0)
> +#define TWL4030_LEDXPWM                (1 << 4)
> +#define TWL4030_LED_PINS       (TWL4030_LEDXON | TWL4030_LEDXPWM)
> +#define TWL4030_LED_TOGGLE(led, x)     ((x) << (led))
> +
> +/* Register, bits and macro for TWL6030 */
> +#define TWL6030_LED_PWM_CTRL1  0xf4
> +#define TWL6030_LED_PWM_CTRL2  0xf5
> +
> +#define TWL6040_LED_MODE_HW    0x00
> +#define TWL6040_LED_MODE_ON    0x01
> +#define TWL6040_LED_MODE_OFF   0x02
> +#define TWL6040_LED_MODE_MASK  0x03
> +
> +struct twl_pwmled_chip {
> +       struct pwm_chip chip;
> +};
> +
> +static int twl4030_pwmled_config(struct pwm_chip *chip, struct pwm_d=
evice *pwm,
> +                             int duty_ns, int period_ns)
> +{
> +       int duty_cycle =3D (duty_ns * TWL4030_LED_MAX) / period_ns;
> +       u8 on_time;
> +       u8 pwm_config[2];
> +       int base, ret;
> +
> +       if (duty_cycle >=3D TWL4030_LED_MAX)
> +               on_time =3D TWL4030_LED_MAX;
> +       else if (!duty_cycle)
> +               on_time =3D TWL4030_LED_MAX - 1;
> +       else
> +               on_time =3D TWL4030_LED_MAX - duty_cycle;
> +
> +       base =3D pwm->hwpwm * 2 + TWL4030_PWMA_REG;
> +
> +       pwm_config[0] =3D on_time;
> +       pwm_config[1] =3D TWL4030_LED_MAX;
> +
> +       ret =3D twl_i2c_write(TWL4030_MODULE_LED, pwm_config, base, 2=
);

Shouldn't this use TWL4030_MODULE_PWMA and TWL4030_MODULE_PWMB as
first argument? I can guess it works your way too, but
TWL4030_MODULE_PWMx would match the TRM better.


--=20
Gra=C5=BEvydas
