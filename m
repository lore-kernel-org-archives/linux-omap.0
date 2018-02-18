From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600 on
 Droid 4
Date: Sun, 18 Feb 2018 01:31:39 +0100
Message-ID: <20180218003139.qiojzvfnbb5vdmrj@earth.universe>
References: <20180217210723.7013-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s72qs4vmp53gbd4a"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180217210723.7013-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org


--s72qs4vmp53gbd4a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Sat, Feb 17, 2018 at 01:07:23PM -0800, Tony Lindgren wrote:
> Let's add support for the GPIO controlled USB PHY on the MDM6600 modem.
> It is used on some Motorola Mapphone series of phones and tablets such
> as Droid 4.
>=20
> The MDM6600 is hardwired to the first OHCI port in the Droid 4 case, and
> is controlled by several GPIOs. The USB PHY is integrated into the MDM6600
> device it seems. We know this as we get L3 errors from omap-usb-host if
> trying to use the PHY before MDM6600 is configured.
>=20
> The GPIOs controlling MDM6600 are used to power MDM660 on and off, to
> configure the USB start-up mode (normal mode versus USB flashing), and
> they also tell the state of the MDM6600 device.
>=20
> The two start-up mode GPIOs are dual-purposed and used for out of band
> (OOB) wake-up for USB and TS 27.010 serial mux. But we need to configure
> the USB start-up mode first to get MDM6600 booted in the right mode to
> be usable in the first place.
>=20
> For now, this driver just gives up the two start-up mode GPIOs after the
> modem has been configured to boot in normal mode. One of them we may
> want to configure for USB OOB wake in this driver later on, but that's a
> separate series of patches and needs more work.
>=20
> Note that the Motorola Mapphone Linux kernel tree has a "radio-ctrl"
> driver for modems. But it really does not control the radio at all, it
> just controls the modem power and start-up mode for USB. So I came to
> the conclusion that we're better off having this done in the USB PHY
> driver. For adding support for USB flashing mode, we can later on add
> a kernel module option for flash_mode=3D1 or something similar.
>=20
> Also note that currently there is no PM runtime support for the OHCI
> on omap variant SoCs. So for low(er) power idle states, currenty both
> ohci-platform and phy-mapphone-mdm6600 must be unloaded or unbound.
>=20
> For reference here is what I measured for total power consumption on
> an idle Droid 4 with and without USB related MDM6600 modules:
>=20
> idle lcd off	phy-mapphone-mdm6600	ohci-platform
> 153mW		284mW			344mW

So more than twice the idle power... We really want to get runtime
PM working :/

> So it seems that MDM6600 is currently not yet idling even with it's
> radio turned off, but that's something that is beyond the control of
> this USB PHY driver.
>=20
> Cc: devicetree@vger.kernel.org
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marcel Partap <mpartap@gmx.net>
> Cc: Michael Scott <michael.scott@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  .../bindings/phy/phy-mapphone-mdm6600.txt          |  30 ++
>  drivers/phy/motorola/Kconfig                       |   9 +
>  drivers/phy/motorola/Makefile                      |   1 +
>  drivers/phy/motorola/phy-mapphone-mdm6600.c        | 490 +++++++++++++++=
++++++
>  4 files changed, 530 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-mapphone-md=
m6600.txt
>  create mode 100644 drivers/phy/motorola/phy-mapphone-mdm6600.c
>=20
> diff --git a/Documentation/devicetree/bindings/phy/phy-mapphone-mdm6600.t=
xt b/Documentation/devicetree/bindings/phy/phy-mapphone-mdm6600.txt
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-mapphone-mdm6600.txt
> @@ -0,0 +1,30 @@
> +Device tree binding documentation for Motorola Mapphone MDM6600 USB PHY
> +
> +Required properties:
> +- compatible	Must be "motorola,mapphone-mdm6600"
> +- enable-gpios	GPIO to enable the USB PHY
> +- power-gpios	GPIO to power on the device
> +- reset-gpios	GPIO to reset the device
> +- mode-gpios	Two GPIOs to configure MDM6600 USB start-up mode for
> +		normal mode versus USB flashing mode
> +- status-gpios	Three GPIOs to read the power state of the MDM6600
> +- cmd-gpios	Three GPIOs to control the power state of the MDM6600
> +
> +Example:
> +
> +fsusb1_phy: fsusb1_phy {
> +	compatible =3D "motorola,mapphone-mdm6600";
> +	enable-gpios =3D <&gpio3 31 GPIO_ACTIVE_LOW>;     /* gpio_95 */
> +	power-gpios =3D <&gpio2 22 GPIO_ACTIVE_HIGH>;	/* gpio_54 */
> +	reset-gpios =3D <&gpio2 17 GPIO_ACTIVE_HIGH>;	/* gpio_49 */
> +	mode-gpios =3D <&gpio5 20 GPIO_ACTIVE_HIGH>,	/* gpio_148 */
> +		     <&gpio5 21 GPIO_ACTIVE_HIGH>;	/* gpio_149 */
> +	status-gpios =3D <&gpio2 23 GPIO_ACTIVE_HIGH>,	/* gpio_55 */
> +		       <&gpio2 21 GPIO_ACTIVE_HIGH>,	/* gpio_53 */
> +		       <&gpio2 20 GPIO_ACTIVE_HIGH>;	/* gpio_52 */
> +	cmd-gpios =3D <&gpio4 7 GPIO_ACTIVE_HIGH>,	/* gpio_103 */
> +		    <&gpio4 8 GPIO_ACTIVE_HIGH>,	/* gpio_104 */
> +		    <&gpio5 14 GPIO_ACTIVE_HIGH>;	/* gpio_142 */
> +	#phy-cells =3D <0>;
> +};
> +
> diff --git a/drivers/phy/motorola/Kconfig b/drivers/phy/motorola/Kconfig
> --- a/drivers/phy/motorola/Kconfig
> +++ b/drivers/phy/motorola/Kconfig
> @@ -10,3 +10,12 @@ config PHY_CPCAP_USB
>  	help
>  	  Enable this for USB to work on Motorola phones and tablets
>  	  such as Droid 4.
> +
> +config PHY_MAPPHONE_MDM6600
> +	tristate "Motorola Mapphone MDM6600 modem USB PHY driver"
> +	depends on USB_SUPPORT
> +	select GENERIC_PHY
> +	select USB_PHY
> +	help
> +	  Enable this for MDM6600 USB modem to work on Motorola phones
> +	  and tablets such as Droid 4.
> diff --git a/drivers/phy/motorola/Makefile b/drivers/phy/motorola/Makefile
> --- a/drivers/phy/motorola/Makefile
> +++ b/drivers/phy/motorola/Makefile
> @@ -3,3 +3,4 @@
>  #
> =20
>  obj-$(CONFIG_PHY_CPCAP_USB)		+=3D phy-cpcap-usb.o
> +obj-$(CONFIG_PHY_MAPPHONE_MDM6600)	+=3D phy-mapphone-mdm6600.o
> diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/mo=
torola/phy-mapphone-mdm6600.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
> @@ -0,0 +1,490 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Motorola Mapphone MDM6600 modem GPIO controlled USB PHY driver
> + * Copyright (C) 2018 Tony Lindgren <tony@atomide.com>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include <linux/gpio/consumer.h>
> +#include <linux/of_platform.h>
> +#include <linux/phy/phy.h>
> +#include <linux/usb/phy_companion.h>
> +
> +#define PHY_MDM6600_STARTUP_DELAY_MS	3000	/* A least 2.2s usually */
> +
> +/*
> + * MDM6600 status codes. These are copied from Motorola Mapphone Linux
> + * kernel tree. The BB naming here refers to "BaseBand" for modem.
> + */

Actually your status codes are BP_ (baseband processor) prefixed.

> +enum phy_mdm6600_status {
> +	BP_STATUS_PANIC,		/* Seems to be really off state */
> +	BP_STATUS_PANIC_BUSY_WAIT,
> +	BP_STATUS_QC_DLOAD,
> +	BP_STATUS_RAM_DOWNLOADER,	/* MDM6600 USB flashing mode */
> +	BP_STATUS_PHONE_CODE_AWAKE,	/* MDM6600 normal USB mode */
> +	BP_STATUS_PHONE_CODE_ASLEEP,
> +	BP_STATUS_SHUTDOWN_ACK,
> +	BP_STATUS_UNDEFINED,
> +};
> +
> +static const char * const
> +phy_mdm6600_status_name[] =3D {
> +	"off", "busy", "qc_dl", "ram_dl", "awake",
> +	"asleep", "shutdown", "undefined",
> +};
> +
> +/*
> + * MDM6600 command codes. These are copied from Motorola Mapphone Linux
> + * kernel tree. The AP naming here refers to "Application Processor".
> + */
> +enum phy_mdm6600_cmd {
> +	AP_STATUS_BP_PANIC_ACK,
> +	AP_STATUS_DATA_ONLY_BYPASS,	/* Reroute USB to CPCAP PHY */
> +	AP_STATUS_FULL_BYPASS,		/* Reroute USB to CPCAP PHY */
> +	AP_STATUS_NO_BYPASS,		/* Request normal start-up mode */
> +	AP_STATUS_BP_SHUTDOWN_REQ,	/* Request device power off */
> +	AP_STATUS_BP_UNKNOWN_5,
> +	AP_STATUS_BP_UNKNOWN_6,
> +	AP_STATUS_UNDEFINED,
> +};
> +
> +enum phy_mdm6600_lines {
> +	PHY_MDM6600_ENABLE,		/* USB PHY enable */
> +	PHY_MDM6600_POWER,		/* Device power */
> +	PHY_MDM6600_RESET,		/* Device reset */
> +	PHY_MDM6600_MODE0,		/* USB boot mode flashing vs normal */
> +	PHY_MDM6600_MODE1,		/* USB boot mode flashing vs normal */
> +	PHY_MDM6600_STATUS0,		/* Device state */
> +	PHY_MDM6600_STATUS1,		/* Device state */
> +	PHY_MDM6600_STATUS2,		/* Device state */
> +	PHY_MDM6600_CMD0,		/* Device command */
> +	PHY_MDM6600_CMD1,		/* Device command */
> +	PHY_MDM6600_CMD2,		/* Device command */
> +	PHY_MDM6600_NR_LINES,
> +};
> +
> +struct phy_mdm6600 {
> +	struct device *dev;
> +	struct usb_phy phy;
> +	struct phy *generic_phy;
> +	struct phy_provider *phy_provider;
> +	struct gpio_desc *gpio[PHY_MDM6600_NR_LINES];
> +	struct delayed_work bootup_work;
> +	struct delayed_work status_work;
> +	struct completion ack;
> +	bool enabled;
> +	int status;
> +};
> +
> +static int phy_mdm6600_init(struct phy *x)
> +{
> +	struct phy_mdm6600 *ddata =3D phy_get_drvdata(x);
> +	struct gpio_desc *enable_gpio =3D ddata->gpio[PHY_MDM6600_ENABLE];
> +
> +	if (!ddata->enabled)
> +		return -EPROBE_DEFER;
> +
> +	gpiod_set_value_cansleep(enable_gpio, 0);
> +
> +	return 0;
> +}
> +
> +static int phy_mdm6600_power_on(struct phy *x)
> +{
> +	struct phy_mdm6600 *ddata =3D phy_get_drvdata(x);
> +	struct gpio_desc *enable_gpio =3D ddata->gpio[PHY_MDM6600_ENABLE];
> +
> +	if (!ddata->enabled)
> +		return -ENODEV;
> +
> +	gpiod_set_value_cansleep(enable_gpio, 1);
> +
> +	return 0;
> +}
> +
> +static int phy_mdm6600_power_off(struct phy *x)
> +{
> +	struct phy_mdm6600 *ddata =3D phy_get_drvdata(x);
> +	struct gpio_desc *enable_gpio =3D ddata->gpio[PHY_MDM6600_ENABLE];
> +
> +	if (!ddata->enabled)
> +		return -ENODEV;
> +
> +	gpiod_set_value_cansleep(enable_gpio, 0);
> +
> +	return 0;
> +}
> +
> +static const struct phy_ops gpio_usb_ops =3D {
> +	.init =3D phy_mdm6600_init,
> +	.power_on =3D phy_mdm6600_power_on,
> +	.power_off =3D phy_mdm6600_power_off,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +struct phy_mdm6600_map {
> +	const char *name;
> +	int nr_gpios;
> +	int direction;
> +};
> +
> +static const struct phy_mdm6600_map
> +phy_mdm6600_line_map[PHY_MDM6600_NR_LINES] =3D {
> +	{ "enable", 1, GPIOD_OUT_LOW, },	/* low =3D disabled */
> +	{ "power", 1, GPIOD_OUT_LOW, },		/* low =3D off */
> +	{ "reset", 1, GPIOD_OUT_HIGH, },	/* high =3D reset */
> +	{ "mode", 2, GPIOD_OUT_LOW, },
> +	{ "status", 3, GPIOD_IN, },
> +	{ "cmd", 3, GPIOD_OUT_LOW, },		/* low =3D no command */
> +};
> +
> +/**
> + * phy_mdm6600_cmd() - send a command request to mdm6600
> + * @ddata: device driver data
> + *
> + * Configures the three command request GPIOs to the specified value.
> + */
> +static void phy_mdm6600_cmd(struct phy_mdm6600 *ddata, int val)
> +{
> +	int i;
> +
> +	val &=3D 0x7;
> +
> +	for (i =3D PHY_MDM6600_CMD0;
> +	     i <=3D PHY_MDM6600_CMD2; i++) {
> +		struct gpio_desc *gpio =3D ddata->gpio[i];
> +		int shift =3D (2 - (i - PHY_MDM6600_CMD0));
> +
> +		if (IS_ERR(gpio))
> +			return;
> +
> +		gpiod_set_value_cansleep(gpio, (val & BIT(shift)) >> shift);
> +	}
> +}
> +
> +/**
> + * phy_mdm6600_status() - read mdm6600 status lines
> + * @ddata: device driver data
> + */
> +static void phy_mdm6600_status(struct work_struct *work)
> +{
> +	struct phy_mdm6600 *ddata;
> +	struct device *dev;
> +	int i, val;
> +
> +	ddata =3D container_of(work, struct phy_mdm6600, status_work.work);
> +	dev =3D ddata->dev;
> +
> +	for (i =3D PHY_MDM6600_STATUS0;
> +	     i <=3D PHY_MDM6600_STATUS2; i++) {
> +		struct gpio_desc *gpio =3D ddata->gpio[i];
> +		int shift =3D (2 - (i - PHY_MDM6600_STATUS0));
> +
> +		if (IS_ERR(ddata->gpio[i]))
> +			continue;
> +		val =3D gpiod_get_value_cansleep(gpio);
> +		ddata->status &=3D ~(BIT(shift));
> +		ddata->status |=3D (val << shift);
> +	}
> +	dev_info(dev, "modem status: %i %s\n",
> +		 ddata->status,
> +		 phy_mdm6600_status_name[ddata->status & 7]);
> +	complete(&ddata->ack);
> +}
> +
> +static irqreturn_t phy_mdm6600_irq_thread(int irq, void *data)
> +{
> +	struct phy_mdm6600 *ddata =3D data;
> +
> +	schedule_delayed_work(&ddata->status_work, msecs_to_jiffies(10));
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + * phy_mdm6600_init_irq() - initialize mdm6600 status IRQ lines
> + * @ddata: device driver data
> + */
> +static void phy_mdm6600_init_irq(struct phy_mdm6600 *ddata)
> +{
> +	struct device *dev =3D ddata->dev;
> +	int i, error, irq;
> +
> +	for (i =3D PHY_MDM6600_STATUS0;
> +	     i <=3D PHY_MDM6600_STATUS2; i++) {
> +		if (IS_ERR(ddata->gpio[i]))
> +			continue;

This can be dropped, since the driver errors out of probe
when there are gpio errors.

> +		irq =3D gpiod_to_irq(ddata->gpio[i]);
> +		if (irq <=3D 0)
> +			continue;
> +
> +		error =3D devm_request_threaded_irq(dev, irq, NULL,
> +					phy_mdm6600_irq_thread,
> +					IRQF_TRIGGER_RISING |
> +					IRQF_TRIGGER_FALLING |
> +					IRQF_ONESHOT,
> +					"mdm6600",
> +					ddata);
> +		if (error)
> +			dev_warn(dev, "no modem status irq%i: %i\n",
> +				 irq, error);
> +	}
> +}
> +
> +/**
> + * phy_mdm6600_init_lines() - initialize mdm6600 GPIO lines
> + * @ddata: device driver data
> + */
> +static int phy_mdm6600_init_lines(struct phy_mdm6600 *ddata)
> +{
> +	struct device *dev =3D ddata->dev;
> +	int i, j, nr_gpio =3D 0;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(phy_mdm6600_line_map); i++) {
> +		const struct phy_mdm6600_map *map =3D
> +			&phy_mdm6600_line_map[i];
> +
> +		for (j =3D 0; j < map->nr_gpios; j++) {
> +			struct gpio_desc **gpio =3D &ddata->gpio[nr_gpio];
> +
> +			*gpio =3D devm_gpiod_get_index(dev,
> +						     map->name, j,
> +						     map->direction);
> +			if (IS_ERR(*gpio)) {
> +				dev_info(dev,
> +					 "gpio %s error %li, already taken?\n",
> +					 map->name, PTR_ERR(*gpio));
> +				return PTR_ERR(*gpio);
> +			}
> +			nr_gpio++;
> +		}

I think the code should use the gpiod_get_array() API.

> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * phy_mdm6600_device_power_on() - power on mdm6600 device
> + * @ddata: device driver data
> + *
> + * To get the integrated USB phy in MDM6600 takes some hoops. We must en=
sure
> + * the shared USB bootmode GPIOs are configured, then request modem star=
t-up,
> + * reset and power-up.. And then we need to give up the shared USB bootm=
ode
> + * GPIOs as they are also used for Out of Band (OOB) wake for the USB and
> + * TS 27.010 serial mux.
> + */
> +static int phy_mdm6600_device_power_on(struct phy_mdm6600 *ddata)
> +{
> +	struct gpio_desc *mode_gpio0 =3D ddata->gpio[PHY_MDM6600_MODE0];
> +	struct gpio_desc *mode_gpio1 =3D ddata->gpio[PHY_MDM6600_MODE1];
> +	struct gpio_desc *reset_gpio =3D ddata->gpio[PHY_MDM6600_RESET];
> +	struct gpio_desc *power_gpio =3D ddata->gpio[PHY_MDM6600_POWER];
> +	int error =3D 0;
> +
> +	/*
> +	 * Shared GPIOs must be low for normal USB mode. After booting,
> +	 * we don't need them. These can be also used to configure USB
> +	 * flashing mode later on based on a module parameter.
> +	 */
> +	gpiod_set_value_cansleep(mode_gpio0, 0);
> +	gpiod_set_value_cansleep(mode_gpio1, 0);
> +
> +	/* Request start-up mode */
> +	phy_mdm6600_cmd(ddata, AP_STATUS_NO_BYPASS);
> +
> +	/* Request a reset first */
> +	gpiod_set_value_cansleep(reset_gpio, 0);
> +	msleep(100);
> +
> +	/* Toggle power GPIO to request mdm6600 to start */
> +	gpiod_set_value_cansleep(power_gpio, 1);
> +	msleep(100);
> +	gpiod_set_value_cansleep(power_gpio, 0);
> +
> +	/*
> +	 * Looks like the USB PHY is at least 2.2 seconds.
> +	 * If we try to use it before that, we will get L3 errors
> +	 * from omap-usb-host trying to access the PHY. See also
> +	 * phy_mdm6600_init() for -EPROBE_DEFER.
> +	 */
> +	msleep(PHY_MDM6600_STARTUP_DELAY_MS);
> +	ddata->enabled =3D true;
> +
> +	/* Booting up the rest of MDM6600 will take total about 8 seconds */
> +	dev_info(ddata->dev, "Waiting for power up request to complete..\n");
> +	if (wait_for_completion_timeout(&ddata->ack,
> +					msecs_to_jiffies(8000))) {
> +		dev_info(ddata->dev, "Powered up OK\n");
> +	} else {
> +		ddata->enabled =3D false;
> +		error =3D -ETIMEDOUT;
> +		dev_err(ddata->dev, "Timed out powering up\n");
> +	}
> +
> +	/* Give up shared GPIOs now, they will be used for OOB wake */
> +	devm_gpiod_put(ddata->dev, mode_gpio0);
> +	ddata->gpio[PHY_MDM6600_MODE0] =3D ERR_PTR(-ENODEV);
> +	devm_gpiod_put(ddata->dev, mode_gpio1);
> +	ddata->gpio[PHY_MDM6600_MODE0] =3D ERR_PTR(-ENODEV);

You want PHY_MDM6600_MODE1 instead. Also I would just use NULL.
NULL is used by gpiod_get_optional and is handled by the gpiod
functions, so you don't need to check for gpio errors everywhere.

> +	return error;
> +}
> +
> +/**
> + * phy_mdm6600_device_power_off() - power off mdm6600 device
> + * @ddata: device driver data
> + */
> +static void phy_mdm6600_device_power_off(struct phy_mdm6600 *ddata)
> +{
> +	struct gpio_desc *reset_gpio =3D
> +		ddata->gpio[PHY_MDM6600_RESET];
> +
> +	ddata->enabled =3D false;
> +	phy_mdm6600_cmd(ddata, AP_STATUS_BP_SHUTDOWN_REQ);
> +	msleep(100);
> +
> +	if (reset_gpio >=3D 0)
> +		gpiod_set_value_cansleep(reset_gpio, 1);
> +
> +	dev_info(ddata->dev, "Waiting for power down request to complete.. ");
> +	if (wait_for_completion_timeout(&ddata->ack,
> +					msecs_to_jiffies(5000))) {
> +		dev_info(ddata->dev, "Powered down OK\n");
> +	} else {
> +		dev_err(ddata->dev, "Timed out powering down\n");
> +	}
> +}
> +
> +static void phy_mdm6600_deferred_power_on(struct work_struct *work)
> +{
> +	struct phy_mdm6600 *ddata;
> +	int error;
> +
> +	ddata =3D container_of(work, struct phy_mdm6600, bootup_work.work);
> +
> +	error =3D phy_mdm6600_device_power_on(ddata);
> +	if (error)
> +		dev_err(ddata->dev, "Device not functional\n");
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id phy_mdm6600_id_table[] =3D {
> +	{ .compatible =3D "motorola,mapphone-mdm6600", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, phy_mdm6600_id_table);
> +#endif

I suggest to just depend on CONFIG_OF in Kconfig and drop the ifdef
and of_match_ptr() parts. It's very unlikely, that this will be
used without DT and would need quite some rework anyways.

> +static int phy_mdm6600_probe(struct platform_device *pdev)
> +{
> +	struct phy_mdm6600 *ddata;
> +	struct usb_otg *otg;
> +	const struct of_device_id *of_id;
> +	int error;
> +
> +	of_id =3D of_match_device(of_match_ptr(phy_mdm6600_id_table),
> +				&pdev->dev);
> +	if (!of_id)
> +		return -EINVAL;

I suggest to drop the of_match_device(). The driver will error
out anyways when it can't get the gpios.

> +	ddata =3D devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
> +	if (!ddata)
> +		return -ENOMEM;
> +
> +	INIT_DELAYED_WORK(&ddata->bootup_work,
> +			  phy_mdm6600_deferred_power_on);
> +	INIT_DELAYED_WORK(&ddata->status_work, phy_mdm6600_status);
> +	init_completion(&ddata->ack);
> +
> +	otg =3D devm_kzalloc(&pdev->dev, sizeof(*otg), GFP_KERNEL);
> +	if (!otg)
> +		return -ENOMEM;
> +
> +	ddata->dev =3D &pdev->dev;
> +	ddata->phy.dev =3D ddata->dev;
> +	ddata->phy.label =3D "phy_mdm6600";
> +	ddata->phy.otg =3D otg;
> +	ddata->phy.type =3D USB_PHY_TYPE_USB2;
> +	otg->usb_phy =3D &ddata->phy;
> +
> +	platform_set_drvdata(pdev, ddata);
> +
> +	error =3D phy_mdm6600_init_lines(ddata);
> +	if (error)
> +		return error;
> +
> +	phy_mdm6600_init_irq(ddata);
> +
> +	ddata->generic_phy =3D devm_phy_create(ddata->dev, NULL, &gpio_usb_ops);
> +	if (IS_ERR(ddata->generic_phy)) {
> +		error =3D PTR_ERR(ddata->generic_phy);
> +		goto cleanup;
> +	}
> +
> +	phy_set_drvdata(ddata->generic_phy, ddata);
> +
> +	ddata->phy_provider =3D
> +		devm_of_phy_provider_register(ddata->dev,
> +					      of_phy_simple_xlate);
> +	if (IS_ERR(ddata->phy_provider)) {
> +		error =3D PTR_ERR(ddata->phy_provider);
> +		goto cleanup;
> +	}
> +
> +	schedule_delayed_work(&ddata->bootup_work, 0);
> +
> +	/*
> +	 * See phy_mdm6600_device_power_on(). We should be able
> +	 * to remove this eventually when ohci-platform can deal
> +	 * with -EPROBE_DEFER.
> +	 */
> +	msleep(PHY_MDM6600_STARTUP_DELAY_MS + 500);
> +
> +	usb_add_phy_dev(&ddata->phy);
> +
> +	return 0;
> +
> +cleanup:
> +	phy_mdm6600_device_power_off(ddata);
> +	return error;
> +}
> +
> +static int phy_mdm6600_remove(struct platform_device *pdev)
> +{
> +	struct phy_mdm6600 *ddata =3D platform_get_drvdata(pdev);
> +	struct gpio_desc *reset_gpio =3D ddata->gpio[PHY_MDM6600_RESET];
> +
> +	if (!IS_ERR(reset_gpio))
> +		gpiod_set_value_cansleep(reset_gpio, 1);
> +
> +	phy_mdm6600_device_power_off(ddata);
> +
> +	cancel_delayed_work_sync(&ddata->bootup_work);
> +	cancel_delayed_work_sync(&ddata->status_work);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver phy_mdm6600_driver =3D {
> +	.probe =3D phy_mdm6600_probe,
> +	.remove =3D phy_mdm6600_remove,
> +	.driver =3D {
> +		.name =3D "phy-mapphone-mdm6600",
> +		.of_match_table =3D of_match_ptr(phy_mdm6600_id_table),
> +	},
> +};
> +
> +module_platform_driver(phy_mdm6600_driver);
> +
> +MODULE_ALIAS("platform:gpio_usb");
> +MODULE_AUTHOR("Tony Lindgren <tony@atomide.com>");
> +MODULE_DESCRIPTION("generic gpio usb phy driver");
> +MODULE_LICENSE("GPL v2");

Generally I'm a bit worried about handling the mode gpios in two
different drivers. It looks like it might become a dependency hell.

-- Sebastian

--s72qs4vmp53gbd4a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlqIyWkACgkQ2O7X88g7
+pooYQ/+OI4fnNEFl6Io0XRbgG70BZQcVlbSiJWeEB1vofFoUmQMfiSF03dz1xu5
Erdvfu36XcxH77FeQN6Z8Hq1a2Ae0uOEa+oZJxpqCObZfTi3cPNHcbsHWp9yUki+
g6TQdjmzGT32gMSMDvFMp4VLg4fAWINsKIWrJQ8Eymm4C1fpzqRSyBfUm+Gr7ema
RWMmnWrBu+9obgujWOgu4U9k2+l9gj0bAmWq0hWfjFnqduls9cAdbyawedCADuiT
hBy9vy6ADTZH0FXY0DZSYESC/yL+WUtNI0sgdctToz0x2yDmLOKWOf/bEyvqkFjn
opShlopDMbZu19nSwXqxS58qO5vH/k7ZZxT3i77doob/zSBcl6Vj+m1LLnbJEQ70
rEh2TTGtEH3THLB+kEnr2ts2qiIQ9S7cR3SfZTJTB1kdi+jgZun1Q72ocIEkqBDj
IrrQ3Minc6mNC7g16Rx95wtofb+ThZbrzIhJ5XRk2abqHOp9JO6ImACGJpWB3/QF
YvOp/eUpNaGOhyWYzG/fcv3cofMR1xK1i0YdKLXGmd9+9ld2uGMjiWzCP1fOcrdd
EGnBPvVWbB2SkYLRJMT+X6rg5x9+PTBk2tK9I3UPGLfjOO1/JGdtcVrmyG4GhRn6
/06X+QkSWsbxZsMmvsaaSF5yYcwM1iPLPtpaGrE5sn/WMnUeOs8=
=q3pG
-----END PGP SIGNATURE-----

--s72qs4vmp53gbd4a--
