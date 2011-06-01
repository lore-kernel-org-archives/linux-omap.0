From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH 4/8] mfd: twl6040: Add initial support
Date: Wed, 1 Jun 2011 19:17:21 +0530
Message-ID: <BANLkTi=3Xw8Ti80oreBiN4_a-=ekDfFM6A@mail.gmail.com>
References: <1306927051-8937-1-git-send-email-peter.ujfalusi@ti.com>
	<1306927051-8937-5-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1306927051-8937-5-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>, Jorge Eduardo Candelaria <jorge.candelaria@ti.com>, Margarita Olaya Cabrera <magi.olaya@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 1, 2011 at 4:47 PM, Peter Ujfalusi <peter.ujfalusi@ti.com> =
wrote:
> From: Misael Lopez Cruz <misael.lopez@ti.com>
>
> TWL6040 IC provides analog high-end audio codec functions for
> handset applications. It contains several audio analog inputs
> and outputs as well as vibrator support. It's connected to the
> host processor via PDM interface for audio data communication.
> The audio modules are controlled by internal registers that
> can be accessed by I2C and PDM interface.
>
> TWL6040 MFD will be registered as a child of TWL-CORE, and will
> have two children of its own: twl6040-codec and twl6040-vibra.
>
> This driver is based on TWL4030 and WM8350 MFD drivers.
>
> Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
> Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
> Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> =A0arch/arm/plat-omap/include/plat/irqs.h | =A0 12 +-
> =A0drivers/mfd/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
6 +
> =A0drivers/mfd/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
1 +
> =A0drivers/mfd/twl-core.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A05 =
+-
> =A0drivers/mfd/twl6040-core.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0589 ++++++=
++++++++++++++++++++++++++
> =A0drivers/mfd/twl6040-irq.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0205 ++++=
+++++++
> =A0include/linux/i2c/twl.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 =
+
> =A0include/linux/mfd/twl6040.h =A0 =A0 =A0 =A0 =A0 =A0| =A0260 ++++++=
++++++++
> =A08 files changed, 1074 insertions(+), 5 deletions(-)
> =A0create mode 100644 drivers/mfd/twl6040-core.c
> =A0create mode 100644 drivers/mfd/twl6040-irq.c
> =A0create mode 100644 include/linux/mfd/twl6040.h
>
> diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-o=
map/include/plat/irqs.h
> index 5a25098..2cfba51 100644
> --- a/arch/arm/plat-omap/include/plat/irqs.h
> +++ b/arch/arm/plat-omap/include/plat/irqs.h
> @@ -407,11 +407,19 @@
> =A0#endif
> =A0#define TWL6030_IRQ_END =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(TWL6030_IR=
Q_BASE + TWL6030_BASE_NR_IRQS)
>
> +#define TWL6040_CODEC_IRQ_BASE TWL6030_IRQ_END
> +#ifdef CONFIG_TWL6040_CODEC
> +#define TWL6040_CODEC_NR_IRQS =A06
> +#else
> +#define TWL6040_CODEC_NR_IRQS =A00
> +#endif
> +#define TWL6040_CODEC_IRQ_END =A0(TWL6040_CODEC_IRQ_BASE + TWL6040_C=
ODEC_NR_IRQS)
> +
> =A0/* Total number of interrupts depends on the enabled blocks above =
*/
> -#if (TWL4030_GPIO_IRQ_END > TWL6030_IRQ_END)
> +#if (TWL4030_GPIO_IRQ_END > TWL6040_CODEC_IRQ_END)
> =A0#define TWL_IRQ_END =A0 =A0 =A0 =A0 =A0 =A0TWL4030_GPIO_IRQ_END
> =A0#else
> -#define TWL_IRQ_END =A0 =A0 =A0 =A0 =A0 =A0TWL6030_IRQ_END
> +#define TWL_IRQ_END =A0 =A0 =A0 =A0 =A0 =A0TWL6040_CODEC_IRQ_END
> =A0#endif
>
> =A0/* GPMC related */
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 3a6f76a..ac6b4ae 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -233,6 +233,12 @@ config TWL6030_PWM
> =A0 =A0 =A0 =A0 =A0Say yes here if you want support for TWL6030 PWM.
> =A0 =A0 =A0 =A0 =A0This is used to control charging LED brightness.
>
> +config TWL6040_CORE
> + =A0 =A0 =A0 bool
> + =A0 =A0 =A0 depends on TWL4030_CORE && GENERIC_HARDIRQS
> + =A0 =A0 =A0 select MFD_CORE
> + =A0 =A0 =A0 default n
> +
> =A0config MFD_STMPE
> =A0 =A0 =A0 =A0bool "Support STMicroelectronics STMPE"
> =A0 =A0 =A0 =A0depends on I2C=3Dy && GENERIC_HARDIRQS
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 4cf9465..41f3b61 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -42,6 +42,7 @@ obj-$(CONFIG_TWL4030_MADC) =A0 =A0 =A0+=3D twl4030-=
madc.o
> =A0obj-$(CONFIG_TWL4030_POWER) =A0 =A0+=3D twl4030-power.o
> =A0obj-$(CONFIG_MFD_TWL4030_AUDIO) =A0 =A0 =A0 =A0+=3D twl4030-audio.=
o
> =A0obj-$(CONFIG_TWL6030_PWM) =A0 =A0 =A0+=3D twl6030-pwm.o
> +obj-$(CONFIG_TWL6040_CORE) =A0 =A0 +=3D twl6040-core.o twl6040-irq.o
>
> =A0obj-$(CONFIG_MFD_MC13XXX) =A0 =A0 =A0+=3D mc13xxx-core.o
>
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index f9d7880..a2eddc7 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -110,7 +110,7 @@
> =A0#endif
>
> =A0#if defined(CONFIG_TWL4030_CODEC) || defined(CONFIG_TWL4030_CODEC_=
MODULE) ||\
> - =A0 =A0 =A0 defined(CONFIG_SND_SOC_TWL6040) || defined(CONFIG_SND_S=
OC_TWL6040_MODULE)
> + =A0 =A0 =A0 defined(CONFIG_TWL6040_CORE) || defined(CONFIG_TWL6040_=
CORE_MODULE)
> =A0#define twl_has_codec() =A0 =A0 =A0 =A0true
> =A0#else
> =A0#define twl_has_codec() =A0 =A0 =A0 =A0false
> @@ -824,10 +824,9 @@ add_children(struct twl4030_platform_data *pdata=
, unsigned long features)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return PTR_ERR(child);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 /* Phoenix codec driver is probed directly atm */
> =A0 =A0 =A0 =A0if (twl_has_codec() && pdata->audio && twl_class_is_60=
30()) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sub_chip_id =3D twl_map[TWL_MODULE_AUD=
IO_VOICE].sid;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 child =3D add_child(sub_chip_id, "twl60=
40-codec",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 child =3D add_child(sub_chip_id, "twl60=
40",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata-=
>audio, sizeof(*pdata->audio),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0false,=
 0, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (IS_ERR(child))
> diff --git a/drivers/mfd/twl6040-core.c b/drivers/mfd/twl6040-core.c
> new file mode 100644
> index 0000000..bb36862
> --- /dev/null
> +++ b/drivers/mfd/twl6040-core.c
> @@ -0,0 +1,589 @@
> +/*
> + * MFD driver for TWL6040 audio device
> + *
> + * Authors: =A0 =A0Misael Lopez Cruz <misael.lopez@ti.com>
> + * =A0 =A0 =A0 =A0 =A0 =A0 Jorge Eduardo Candelaria <jorge.candelari=
a@ti.com>
> + * =A0 =A0 =A0 =A0 =A0 =A0 Peter Ujfalusi <peter.ujfalusi@ti.com>
> + *
> + * Copyright: =A0(C) 2011 Texas Instruments, Inc.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, b=
ut
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the G=
NU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + * 02110-1301 USA
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/slab.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/gpio.h>
> +#include <linux/delay.h>
> +#include <linux/i2c/twl.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/twl6040.h>
> +
> +static struct platform_device *twl6040_dev;
> +
> +int twl6040_reg_read(struct twl6040 *twl6040, unsigned int reg)
> +{
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 u8 val =3D 0;
> +
> + =A0 =A0 =A0 mutex_lock(&twl6040->io_mutex);
> + =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL_MODULE_AUDIO_VOICE, &val, r=
eg);

Can this dependency on twl_i2c_[read/write] be removed,
Since TWL6040 is a separate IC which can get its own i2c_client in
twl6040-core.c and
create its own mfd devices like vibra, audio-codec ... while creating
twl6040-core.c

> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&twl6040->io_mutex);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 mutex_unlock(&twl6040->io_mutex);
> +
> + =A0 =A0 =A0 return val;
> +}
> +EXPORT_SYMBOL(twl6040_reg_read);
> +
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
