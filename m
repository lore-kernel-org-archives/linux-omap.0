From: Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH 3/8] mfd: twl-core: Rename TWL4030_CORE Kconfig option
 to TWL_CORE
Date: Sat, 02 Apr 2016 22:12:15 +0200
Message-ID: <1459627935.12073.35.camel@paulk.fr>
References: <1459279341-17389-1-git-send-email-contact@paulk.fr>
	 <1459279341-17389-3-git-send-email-contact@paulk.fr>
	 <56FBF1FD.8090903@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-IXWGdjJgmjWra26uxv9C"
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <56FBF1FD.8090903@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-omap@vger.kernel.org


--=-IXWGdjJgmjWra26uxv9C
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mercredi 30 mars 2016 =C3=A0 18:34 +0300, Grygorii Strashko a =C3=A9crit=
=C2=A0:
> On 03/29/2016 10:22 PM, Paul Kocialkowski wrote:
> >=20
> > Since the twl-core mfd driver is not limited to twl4030 support, but al=
so
> > supports other chips of the TWL family, it makes sense to rename its
> > matching
> > Kconfig opton to a non-model-specific name.
>
> Personally I don't see too much reason for this, but it's up to maintaine=
rs to
> decide.

I'm a strong advocate of consistency in naming and using twl4030 prefixes f=
or
drivers that are common to more twl chips looks very inconsistent to me.
Besides, some common twl drivers are already using the twl prefix, so this =
can
also be seen as harmonisation.

> Regarding this patch - pls, do not mix Kconfig and code changes.

Do you mean that for code changes that are directly affected by Kconfig cha=
nges
(e.g. #ifdef CONFIG_)? Is the policy that "each commit must produce a worki=
ng
result" or is it okay to break drivers in between commits of the same serie=
s?

> And it will be good to have cover letter.

Noted, I'll come up with something for v2.

> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > ---
> > =C2=A0 arch/arm/mach-omap2/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 2 +-
> > =C2=A0 arch/arm/mach-omap2/Makefile=C2=A0=C2=A0=C2=A0=C2=A0| 2 +-
> > =C2=A0 arch/arm/mach-omap2/pm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0| 2 +-
> > =C2=A0 arch/arm/plat-omap/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| =
2 +-
> > =C2=A0 drivers/gpio/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 2 +-
> > =C2=A0 drivers/iio/adc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0| 4 ++--
> > =C2=A0 drivers/input/keyboard/Kconfig=C2=A0=C2=A0| 2 +-
> > =C2=A0 drivers/input/misc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| =
4 ++--
> > =C2=A0 drivers/mfd/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 6 +++---
> > =C2=A0 drivers/mfd/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 2 +-
> > =C2=A0 drivers/mfd/twl4030-irq.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0| 6 +++---
> > =C2=A0 drivers/phy/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 2 +-
> > =C2=A0 drivers/power/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0| 2 +-
> > =C2=A0 drivers/pwm/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 4 ++--
> > =C2=A0 drivers/regulator/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0| 2 +-
> > =C2=A0 drivers/rtc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 2 +-
> > =C2=A0 drivers/usb/phy/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0| 2 +-
> > =C2=A0 drivers/video/backlight/Kconfig | 2 +-
> > =C2=A0 drivers/watchdog/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0| 2 +-
> > =C2=A0 include/linux/i2c/twl.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0| 4 ++--
> > =C2=A0 sound/soc/codecs/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0| 2 +-
> > =C2=A0 sound/soc/omap/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0| 4 ++--
> > =C2=A0 22 files changed, 31 insertions(+), 31 deletions(-)
> >=20
> > diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> > index 0517f0c..ada4c7a1 100644
> > --- a/arch/arm/mach-omap2/Kconfig
> > +++ b/arch/arm/mach-omap2/Kconfig
> > @@ -124,7 +124,7 @@ config ARCH_OMAP2PLUS_TYPICAL
> > =C2=A0=C2=A0	select PM
> > =C2=A0=C2=A0	select REGULATOR
> > =C2=A0=C2=A0	select REGULATOR_FIXED_VOLTAGE
> > -	select TWL4030_CORE if ARCH_OMAP3 || ARCH_OMAP4
> > +	select TWL_CORE if ARCH_OMAP3 || ARCH_OMAP4
> > =C2=A0=C2=A0	select TWL4030_POWER if ARCH_OMAP3 || ARCH_OMAP4
> > =C2=A0=C2=A0	select VFP
> > =C2=A0=C2=A0	help
> > diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefil=
e
> > index 0ba6a0e..6eb680a 100644
> > --- a/arch/arm/mach-omap2/Makefile
> > +++ b/arch/arm/mach-omap2/Makefile
> > @@ -27,7 +27,7 @@ ifneq ($(CONFIG_SND_OMAP_SOC_MCBSP),)
> > =C2=A0 obj-y +=3D mcbsp.o
> > =C2=A0 endif
> > =C2=A0=C2=A0
> > -obj-$(CONFIG_TWL4030_CORE) +=3D omap_twl.o
> > +obj-$(CONFIG_TWL_CORE) +=3D omap_twl.o
> > =C2=A0 obj-$(CONFIG_SOC_HAS_OMAP2_SDRC)	+=3D sdrc.o
> > =C2=A0=C2=A0
> > =C2=A0 # SMP support ONLY available for OMAP4
> > diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> > index b668719..bf4dac2 100644
> > --- a/arch/arm/mach-omap2/pm.h
> > +++ b/arch/arm/mach-omap2/pm.h
> > @@ -123,7 +123,7 @@ static inline int omap_devinit_smartreflex(void)
> > =C2=A0 static inline void omap_enable_smartreflex_on_init(void) {}
> > =C2=A0 #endif
> > =C2=A0=C2=A0
> > -#ifdef CONFIG_TWL4030_CORE
> > +#ifdef CONFIG_TWL_CORE
> > =C2=A0 extern int omap3_twl_init(void);
> > =C2=A0 extern int omap4_twl_init(void);
> > =C2=A0 extern int omap3_twl_set_sr_bit(bool enable);
> > diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> > index d055db3..8631a45 100644
> > --- a/arch/arm/plat-omap/Kconfig
> > +++ b/arch/arm/plat-omap/Kconfig
> > @@ -44,7 +44,7 @@ config POWER_AVS_OMAP
> > =C2=A0=C2=A0
> > =C2=A0 config POWER_AVS_OMAP_CLASS3
> > =C2=A0=C2=A0	bool "Class 3 mode of Smartreflex Implementation"
> > -	depends on POWER_AVS_OMAP && TWL4030_CORE
> > +	depends on POWER_AVS_OMAP && TWL_CORE
> > =C2=A0=C2=A0	help
> > =C2=A0=C2=A0	=C2=A0=C2=A0Say Y to enable Class 3 implementation of Smar=
treflex
> > =C2=A0=C2=A0
> > diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> > index 5f3429f..62ca9b4 100644
> > --- a/drivers/gpio/Kconfig
> > +++ b/drivers/gpio/Kconfig
> > @@ -933,7 +933,7 @@ config GPIO_TPS65912
> > =C2=A0=C2=A0
> > =C2=A0 config GPIO_TWL4030
> > =C2=A0=C2=A0	tristate "TWL4030, TWL5030, and TPS659x0 GPIOs"
> > -	depends on TWL4030_CORE
> > +	depends on TWL_CORE
> > =C2=A0=C2=A0	help
> > =C2=A0=C2=A0	=C2=A0=C2=A0Say yes here to access the GPIO signals of var=
ious multi-
> > function
> > =C2=A0=C2=A0	=C2=A0=C2=A0power management chips from Texas Instruments.
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index af4aea7..3360492 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -440,7 +440,7 @@ config TI_AM335X_ADC
> > =C2=A0=C2=A0
> > =C2=A0 config TWL4030_MADC
> > =C2=A0=C2=A0	tristate "TWL4030 MADC (Monitoring A/D Converter)"
> > -	depends on TWL4030_CORE
> > +	depends on TWL_CORE
> > =C2=A0=C2=A0	help
> > =C2=A0=C2=A0	=C2=A0=C2=A0This driver provides support for Triton TWL403=
0-MADC. The
> > =C2=A0=C2=A0	=C2=A0=C2=A0driver supports both RT and SW conversion meth=
ods.
> > @@ -450,7 +450,7 @@ config TWL4030_MADC
> > =C2=A0=C2=A0
> > =C2=A0 config TWL6030_GPADC
> > =C2=A0=C2=A0	tristate "TWL6030 GPADC (General Purpose A/D Converter) Su=
pport"
> > -	depends on TWL4030_CORE
> > +	depends on TWL_CORE
> > =C2=A0=C2=A0	default n
> > =C2=A0=C2=A0	help
> > =C2=A0=C2=A0	=C2=A0=C2=A0Say yes here if you want support for the TWL60=
30/TWL6032 General
> > diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kc=
onfig
> > index 509608c..9cfa09b 100644
> > --- a/drivers/input/keyboard/Kconfig
> > +++ b/drivers/input/keyboard/Kconfig
> > @@ -653,7 +653,7 @@ config KEYBOARD_TC3589X
> > =C2=A0=C2=A0
> > =C2=A0 config KEYBOARD_TWL4030
> > =C2=A0=C2=A0	tristate "TI TWL4030/TWL5030/TPS659x0 keypad support"
> > -	depends on TWL4030_CORE
> > +	depends on TWL_CORE
> > =C2=A0=C2=A0	select INPUT_MATRIXKMAP
> > =C2=A0=C2=A0	help
> > =C2=A0=C2=A0	=C2=A0=C2=A0Say Y here if your board use the keypad contro=
ller on
> > diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> > index 1f2337a..6abb6df 100644
> > --- a/drivers/input/misc/Kconfig
> > +++ b/drivers/input/misc/Kconfig
> > @@ -461,7 +461,7 @@ config INPUT_AXP20X_PEK
> > =C2=A0=C2=A0
> > =C2=A0 config INPUT_TWL4030_PWRBUTTON
> > =C2=A0=C2=A0	tristate "TWL4030 Power button Driver"
> > -	depends on TWL4030_CORE
> > +	depends on TWL_CORE
> > =C2=A0=C2=A0	help
> > =C2=A0=C2=A0	=C2=A0=C2=A0Say Y here if you want to enable power key rep=
orting via the
> > =C2=A0=C2=A0	=C2=A0=C2=A0TWL4030 family of chips.
> > @@ -471,7 +471,7 @@ config INPUT_TWL4030_PWRBUTTON
> > =C2=A0=C2=A0
> > =C2=A0 config INPUT_TWL4030_VIBRA
> > =C2=A0=C2=A0	tristate "Support for TWL4030 Vibrator"
> > -	depends on TWL4030_CORE
> > +	depends on TWL_CORE
> > =C2=A0=C2=A0	select MFD_TWL4030_AUDIO
> > =C2=A0=C2=A0	select INPUT_FF_MEMLESS
> > =C2=A0=C2=A0	help
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index eea61e3..28bfe3d 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -1266,7 +1266,7 @@ config MFD_TPS80031
> > =C2=A0=C2=A0	=C2=A0=C2=A0ADC, RTC, 2 PWM, System Voltage Regulator/Batt=
ery Charger with
> > =C2=A0=C2=A0	=C2=A0=C2=A0Power Path from USB, 32K clock generator.
> > =C2=A0=C2=A0
> > -config TWL4030_CORE
> > +config TWL_CORE
> > =C2=A0=C2=A0	bool "TI TWL4030/TWL5030/TWL6030/TPS659x0 Support"
> > =C2=A0=C2=A0	depends on I2C=3Dy
> > =C2=A0=C2=A0	select IRQ_DOMAIN
> > @@ -1284,7 +1284,7 @@ config TWL4030_CORE
> > =C2=A0=C2=A0
> > =C2=A0 config TWL4030_POWER
> > =C2=A0=C2=A0	bool "TI TWL4030 power resources"
> > -	depends on TWL4030_CORE && ARM
> > +	depends on TWL_CORE && ARM
> > =C2=A0=C2=A0	help
> > =C2=A0=C2=A0	=C2=A0=C2=A0Say yes here if you want to use the power reso=
urces on the
> > =C2=A0=C2=A0	=C2=A0=C2=A0TWL4030 family chips.=C2=A0=C2=A0Most of these=
 resources are regulators,
> > @@ -1297,7 +1297,7 @@ config TWL4030_POWER
> > =C2=A0=C2=A0
> > =C2=A0 config MFD_TWL4030_AUDIO
> > =C2=A0=C2=A0	bool "TI TWL4030 Audio"
> > -	depends on TWL4030_CORE
> > +	depends on TWL_CORE
> > =C2=A0=C2=A0	select MFD_CORE
> > =C2=A0=C2=A0	default n
> > =C2=A0=C2=A0
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index 5eaa6465d..7daeab5 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -81,7 +81,7 @@ obj-$(CONFIG_MFD_TPS65912_SPI)=C2=A0=C2=A0+=3D tps659=
12-spi.o
> > =C2=A0 obj-$(CONFIG_MFD_TPS80031)	+=3D tps80031.o
> > =C2=A0 obj-$(CONFIG_MENELAUS)		+=3D menelaus.o
> > =C2=A0=C2=A0
> > -obj-$(CONFIG_TWL4030_CORE)	+=3D twl-core.o twl4030-irq.o twl6030-irq.o
> > +obj-$(CONFIG_TWL_CORE)	+=3D twl-core.o twl4030-irq.o twl6030-irq.o
> > =C2=A0 obj-$(CONFIG_TWL4030_POWER)=C2=A0=C2=A0=C2=A0=C2=A0+=3D twl4030-=
power.o
> > =C2=A0 obj-$(CONFIG_MFD_TWL4030_AUDIO)	+=3D twl4030-audio.o
> > =C2=A0 obj-$(CONFIG_TWL6040_CORE)	+=3D twl6040.o
> > diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
> > index 40e51b0..52dc294 100644
> > --- a/drivers/mfd/twl4030-irq.c
> > +++ b/drivers/mfd/twl4030-irq.c
> > @@ -54,7 +54,7 @@
> > =C2=A0=C2=A0=C2=A0*	base + 8=C2=A0=C2=A0.. base + 15	SIH for PWR_INT
> > =C2=A0=C2=A0=C2=A0*	base + 16 .. base + 33	SIH for GPIO
> > =C2=A0=C2=A0=C2=A0*/
> > -#define TWL4030_CORE_NR_IRQS	8
> > +#define TWL_CORE_NR_IRQS	8
> > =C2=A0 #define TWL4030_PWR_NR_IRQS	8
> > =C2=A0=C2=A0
> > =C2=A0 /* PIH register offsets */
> > @@ -693,7 +693,7 @@ int twl4030_init_irq(struct device *dev, int irq_nu=
m)
> > =C2=A0=C2=A0	=C2=A0* the hwirqs numbers are defined contiguously from 1=
 to 15.
> > =C2=A0=C2=A0	=C2=A0* Create only one domain for both.
> > =C2=A0=C2=A0	=C2=A0*/
> > -	nr_irqs =3D TWL4030_PWR_NR_IRQS + TWL4030_CORE_NR_IRQS;
> > +	nr_irqs =3D TWL4030_PWR_NR_IRQS + TWL_CORE_NR_IRQS;
> > =C2=A0=C2=A0
> > =C2=A0=C2=A0	irq_base =3D irq_alloc_descs(-1, 0, nr_irqs, 0);
> > =C2=A0=C2=A0	if (IS_ERR_VALUE(irq_base)) {
> > @@ -704,7 +704,7 @@ int twl4030_init_irq(struct device *dev, int irq_nu=
m)
> > =C2=A0=C2=A0	irq_domain_add_legacy(node, nr_irqs, irq_base, 0,
> > =C2=A0=C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&irq_domain_simple_o=
ps, NULL);
> > =C2=A0=C2=A0
> > -	irq_end =3D irq_base + TWL4030_CORE_NR_IRQS;
> > +	irq_end =3D irq_base + TWL_CORE_NR_IRQS;
> > =C2=A0=C2=A0
> > =C2=A0=C2=A0	/*
> > =C2=A0=C2=A0	=C2=A0* Mask and clear all TWL4030 interrupts since initia=
lly we do
> > diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> > index 26566db..6193565 100644
> > --- a/drivers/phy/Kconfig
> > +++ b/drivers/phy/Kconfig
> > @@ -164,7 +164,7 @@ config TI_PIPE3
> > =C2=A0=C2=A0
> > =C2=A0 config TWL4030_USB
> > =C2=A0=C2=A0	tristate "TWL4030 USB Transceiver Driver"
> > -	depends on TWL4030_CORE && REGULATOR_TWL4030 && USB_MUSB_OMAP2PLUS
> > +	depends on TWL_CORE && REGULATOR_TWL4030 && USB_MUSB_OMAP2PLUS
> > =C2=A0=C2=A0	depends on USB_SUPPORT
> > =C2=A0=C2=A0	select GENERIC_PHY
> > =C2=A0=C2=A0	select USB_PHY
> > diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> > index 421770d..cc5fe9a 100644
> > --- a/drivers/power/Kconfig
> > +++ b/drivers/power/Kconfig
> > @@ -323,7 +323,7 @@ config CHARGER_MAX8903
> > =C2=A0=C2=A0
> > =C2=A0 config CHARGER_TWL4030
> > =C2=A0=C2=A0	tristate "OMAP TWL4030 BCI charger driver"
> > -	depends on IIO && TWL4030_CORE
> > +	depends on IIO && TWL_CORE
> > =C2=A0=C2=A0	help
> > =C2=A0=C2=A0	=C2=A0=C2=A0Say Y here to enable support for TWL4030 Batte=
ry Charge
> > Interface.
> > =C2=A0=C2=A0
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index c182efc..6318f19 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -413,7 +413,7 @@ config=C2=A0=C2=A0PWM_TIPWMSS
> > =C2=A0=C2=A0
> > =C2=A0 config PWM_TWL
> > =C2=A0=C2=A0	tristate "TWL4030/6030 PWM support"
> > -	depends on TWL4030_CORE
> > +	depends on TWL_CORE
> > =C2=A0=C2=A0	help
> > =C2=A0=C2=A0	=C2=A0=C2=A0Generic PWM framework driver for TWL4030/6030.
> > =C2=A0=C2=A0
> > @@ -422,7 +422,7 @@ config PWM_TWL
> > =C2=A0=C2=A0
> > =C2=A0 config PWM_TWL_LED
> > =C2=A0=C2=A0	tristate "TWL4030/6030 PWM support for LED drivers"
> > -	depends on TWL4030_CORE
> > +	depends on TWL_CORE
> > =C2=A0=C2=A0	help
> > =C2=A0=C2=A0	=C2=A0=C2=A0Generic PWM framework driver for TWL4030/6030 =
LED terminals.
> > =C2=A0=C2=A0
> > diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> > index c77dc08..b62b4b4 100644
> > --- a/drivers/regulator/Kconfig
> > +++ b/drivers/regulator/Kconfig
> > @@ -803,7 +803,7 @@ config REGULATOR_TPS80031
> > =C2=A0=C2=A0
> > =C2=A0 config REGULATOR_TWL4030
> > =C2=A0=C2=A0	tristate "TI TWL4030/TWL5030/TWL6030/TPS659x0 PMIC"
> > -	depends on TWL4030_CORE
> > +	depends on TWL_CORE
> > =C2=A0=C2=A0	help
> > =C2=A0=C2=A0	=C2=A0=C2=A0This driver supports the voltage regulators pr=
ovided by
> > =C2=A0=C2=A0	=C2=A0=C2=A0this family of companion chips.
> > diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> > index 3e84315..198ac54 100644
> > --- a/drivers/rtc/Kconfig
> > +++ b/drivers/rtc/Kconfig
> > @@ -462,7 +462,7 @@ config RTC_DRV_TWL92330
> > =C2=A0=C2=A0
> > =C2=A0 config RTC_DRV_TWL4030
> > =C2=A0=C2=A0	tristate "TI TWL4030/TWL5030/TWL6030/TPS659x0"
> > -	depends on TWL4030_CORE
> > +	depends on TWL_CORE
> > =C2=A0=C2=A0	help
> > =C2=A0=C2=A0	=C2=A0=C2=A0If you say yes here you get support for the RT=
C on the
> > =C2=A0=C2=A0	=C2=A0=C2=A0TWL4030/TWL5030/TWL6030 family chips, used mos=
tly with OMAP3
> > platforms.
> > diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
> > index c690474..2911b11 100644
> > --- a/drivers/usb/phy/Kconfig
> > +++ b/drivers/usb/phy/Kconfig
> > @@ -80,7 +80,7 @@ config SAMSUNG_USBPHY
> > =C2=A0=C2=A0
> > =C2=A0 config TWL6030_USB
> > =C2=A0=C2=A0	tristate "TWL6030 USB Transceiver Driver"
> > -	depends on TWL4030_CORE && OMAP_USB2 && USB_MUSB_OMAP2PLUS
> > +	depends on TWL_CORE && OMAP_USB2 && USB_MUSB_OMAP2PLUS
> > =C2=A0=C2=A0	help
> > =C2=A0=C2=A0	=C2=A0=C2=A0Enable this to support the USB OTG transceiver=
 on TWL6030
> > =C2=A0=C2=A0	=C2=A0=C2=A0family chips. This TWL6030 transceiver has the=
 VBUS and ID GND
> > diff --git a/drivers/video/backlight/Kconfig
> > b/drivers/video/backlight/Kconfig
> > index 5ffa4b4..8d6e4e0 100644
> > --- a/drivers/video/backlight/Kconfig
> > +++ b/drivers/video/backlight/Kconfig
> > @@ -412,7 +412,7 @@ config BACKLIGHT_OT200
> > =C2=A0=C2=A0
> > =C2=A0 config BACKLIGHT_PANDORA
> > =C2=A0=C2=A0	tristate "Backlight driver for Pandora console"
> > -	depends on TWL4030_CORE
> > +	depends on TWL_CORE
> > =C2=A0=C2=A0	help
> > =C2=A0=C2=A0	=C2=A0=C2=A0If you have a Pandora console, say Y to enable=
 the
> > =C2=A0=C2=A0	=C2=A0=C2=A0backlight driver.
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index fb94765..4b24418 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -462,7 +462,7 @@ config COH901327_WATCHDOG
> > =C2=A0=C2=A0
> > =C2=A0 config TWL4030_WATCHDOG
> > =C2=A0=C2=A0	tristate "TWL4030 Watchdog"
> > -	depends on TWL4030_CORE
> > +	depends on TWL_CORE
> > =C2=A0=C2=A0	select WATCHDOG_CORE
> > =C2=A0=C2=A0	help
> > =C2=A0=C2=A0	=C2=A0=C2=A0Support for TI TWL4030 watchdog.=C2=A0=C2=A0Sa=
y 'Y' here to enable the
> > diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
> > index 4e7ea5f..2decb190 100644
> > --- a/include/linux/i2c/twl.h
> > +++ b/include/linux/i2c/twl.h
> > @@ -214,7 +214,7 @@ int twl6030_interrupt_unmask(u8 bit_mask, u8 offset=
);
> > =C2=A0 int twl6030_interrupt_mask(u8 bit_mask, u8 offset);
> > =C2=A0=C2=A0
> > =C2=A0 /* Card detect Configuration for MMC1 Controller on OMAP4 */
> > -#ifdef CONFIG_TWL4030_CORE
> > +#ifdef CONFIG_TWL_CORE
> > =C2=A0 int twl6030_mmc_card_detect_config(void);
> > =C2=A0 #else
> > =C2=A0 static inline int twl6030_mmc_card_detect_config(void)
> > @@ -225,7 +225,7 @@ static inline int twl6030_mmc_card_detect_config(vo=
id)
> > =C2=A0 #endif
> > =C2=A0=C2=A0
> > =C2=A0 /* MMC1 Controller on OMAP4 uses Phoenix irq for Card detect */
> > -#ifdef CONFIG_TWL4030_CORE
> > +#ifdef CONFIG_TWL_CORE
> > =C2=A0 int twl6030_mmc_card_detect(struct device *dev, int slot);
> > =C2=A0 #else
> > =C2=A0 static inline int twl6030_mmc_card_detect(struct device *dev, in=
t slot)
> > diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> > index 649e92a..009feb4 100644
> > --- a/sound/soc/codecs/Kconfig
> > +++ b/sound/soc/codecs/Kconfig
> > @@ -134,7 +134,7 @@ config SND_SOC_ALL_CODECS
> > =C2=A0=C2=A0	select SND_SOC_TPA6130A2 if I2C
> > =C2=A0=C2=A0	select SND_SOC_TLV320DAC33 if I2C
> > =C2=A0=C2=A0	select SND_SOC_TS3A227E if I2C
> > -	select SND_SOC_TWL4030 if TWL4030_CORE
> > +	select SND_SOC_TWL4030 if TWL_CORE
> > =C2=A0=C2=A0	select SND_SOC_TWL6040 if TWL6040_CORE
> > =C2=A0=C2=A0	select SND_SOC_UDA134X
> > =C2=A0=C2=A0	select SND_SOC_UDA1380 if I2C
> > diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
> > index 5185a38..49af002 100644
> > --- a/sound/soc/omap/Kconfig
> > +++ b/sound/soc/omap/Kconfig
> > @@ -85,7 +85,7 @@ config SND_OMAP_SOC_AM3517EVM
> > =C2=A0=C2=A0
> > =C2=A0 config SND_OMAP_SOC_OMAP_TWL4030
> > =C2=A0=C2=A0	tristate "SoC Audio support for TI SoC based boards with t=
wl4030
> > codec"
> > -	depends on TWL4030_CORE && SND_OMAP_SOC
> > +	depends on TWL_CORE && SND_OMAP_SOC
> > =C2=A0=C2=A0	select SND_OMAP_SOC_MCBSP
> > =C2=A0=C2=A0	select SND_SOC_TWL4030
> > =C2=A0=C2=A0	help
> > @@ -117,7 +117,7 @@ config SND_OMAP_SOC_OMAP_ABE_TWL6040
> > =C2=A0=C2=A0
> > =C2=A0 config SND_OMAP_SOC_OMAP3_PANDORA
> > =C2=A0=C2=A0	tristate "SoC Audio support for OMAP3 Pandora"
> > -	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP3_PANDORA
> > +	depends on TWL_CORE && SND_OMAP_SOC && MACH_OMAP3_PANDORA
> > =C2=A0=C2=A0	select SND_OMAP_SOC_MCBSP
> > =C2=A0=C2=A0	select SND_SOC_TWL4030
> > =C2=A0=C2=A0	help
> >=20
>=20
--=-IXWGdjJgmjWra26uxv9C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXACegAAoJEIT9weqP7pUM//kP/0vTOivCrs6ubKjVK9g/j9HN
4mFfHu4R70aL6UJk8y0e1jiQxEII/2kRCC+W7oLnpt6aWeCdpOZ7VL2ly7ZOytRf
1IcKhlJNhWcXPuTLV+vrKXduaueXrUFS6dRBK1HTjh1u9qXB/+ShSZYOu4Cwg4h2
gtiKV/3BfBQTmnOxEV2/vrSC/iK7pGam5eT3lmWo4K+54/HKIvafROEJa589hfCG
RWwL4GKa91QeO5wUAbpMlFreXCqdriYNdvXWweRj0efkp32U5h518Ra0XCk2Z77U
/zJqb+/h88VbVMGTF5q6O/yRT7NBOcL4h34NHjKEbt6QacGDwSErdF5dPiY+v5bz
mxqrcO6fdETtMZkbhCsrgMPY8yTa9MX//QUhub7jTlsPDndImtaMujkmenU5kEZt
cPZnCp77UPPeuLOXaTDPlCivAbI4hFo7s7RlEs4BvBgE7tjlTmERwoeUHOA7wSrv
NRYn8l8nAqMsc5bxb0ckjGxPoDY96nwoDeRM3CxPzX9FHRCyd8I2lHMA0eY8R4X+
kPbhzcefK7eOA53bXHcuAt1Ar6R/OA59jsqYSrGN5b3/Ga4u9yaXK/ELfscCoVGA
uX3yCRB22HC3i4bswBA3iMr6M27XNYM26qb1xsaMaNt1b7P4vACaGl1VvQIALPRe
T5uWTGxbcAOWJ+npg5YO
=tFj9
-----END PGP SIGNATURE-----

--=-IXWGdjJgmjWra26uxv9C--

