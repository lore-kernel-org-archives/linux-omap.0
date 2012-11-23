From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] gpio: New driver for GPO emulation using PWM generators
Date: Fri, 23 Nov 2012 10:13:05 +0100
Message-ID: <50AF3E21.4000009@ti.com>
References: <1353591723-25233-1-git-send-email-peter.ujfalusi@ti.com>
 <20121123075537.A14713E0A91@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20121123075537.A14713E0A91@localhost>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Grant,

On 11/23/2012 08:55 AM, Grant Likely wrote:
> Ugh. and this is why I wanted the PWM and GPIO subsystems to use the
> same namespace and binding. <grumble, mutter> But that's not your fault.
> =

> It's pretty horrible to have a separate translator node to convert a PWM
> into a GPIO (with output only of course). The gpio properties should
> appear directly in the PWM node itself and the translation code should
> be in either the pwm or the gpio core. I don't think it should look like
> a separate device.

Let me see if I understand your suggestion correctly. In the DT you suggest
something like this:

twl_pwmled: pwmled {
	compatible =3D "ti,twl4030-pwmled";
	#pwm-cells =3D <2>;
	#gpio-cells =3D <2>;
	gpio-controller;
};

led_user {
	compatible =3D "pwm-leds";
	pwms =3D <&twl_pwmled 1 7812500>; /* PWMB/LEDB from twl4030 */
	pwm-names =3D "PMU_STAT LED";

	label =3D "beagleboard::pmu_stat";
	max-brightness =3D <127>;
};

vdd_usbhost: fixedregulator-vdd-usbhost {
	compatible =3D "regulator-fixed";
	regulator-name =3D "USBHOST_POWER";
	regulator-min-microvolt =3D <5000000>;
	regulator-max-microvolt =3D <5000000>;
	gpio =3D <&twl_pwmled 0 7812500>; /* PWMA/LEDA from twl4030 */
	enable-active-high;
	regulator-boot-on;
};

With this I think this is what should happen in code level:
- the "pwm-gpo" driver does not have of_match_table at all.
- the driver for the "ti,twl4030-pwmled" is loaded.
- it prepares and calls pwmchip_add() to add the PWM chip.
- the of_pwmchip_add() will look for gpio-controller property of the node
 - if it is found it prepares the pdata (based on the PWM chip information)
for the "pwm-gpo" driver and registers the platform_device for it.
 - the "pwm-gpo" driver will use:
    priv->gpio_chip.of_node =3D pdev->dev.parent->of_node;

In DT boot we are fine with this I think.

When it comes to legacy boot (boot without DT) I think we should still have
the two layers to avoid big changes which would affect all existing pwm
drivers. Something like this in the board files:

static struct pwm_lookup pwm_lookup[] =3D {
	/* LEDA ->  nUSBHOST_PWR_EN */
	PWM_LOOKUP("twl-pwmled", 0, "pwm-gpo", "nUSBHOST_PWR_EN"),
	/* LEDB -> PMU_STAT */
	PWM_LOOKUP("twl-pwmled", 1, "leds_pwm", "beagleboard::pmu_stat"),
};

/* for the LED user of PWM */
static struct led_pwm pwm_leds[] =3D {
	{
		.name		=3D "beagleboard::pmu_stat",
		.max_brightness	=3D 127,
		.pwm_period_ns	=3D 7812500,
	},
};

static struct led_pwm_platform_data pwm_data =3D {
	.num_leds	=3D ARRAY_SIZE(pwm_leds),
	.leds		=3D pwm_leds,
};

static struct platform_device leds_pwm =3D {
	.name	=3D "leds_pwm",
	.id	=3D -1,
	.dev	=3D {
		.platform_data =3D &pwm_data,
	},
};

/* for the GPIO user of PWM */
static struct gpio_pwm pwm_gpios[] =3D {
	{
		.name		=3D "nUSBHOST_PWR_EN",
		.pwm_period_ns	=3D 7812500,
	},
};

static struct gpio_pwm_pdata pwm_gpio_data =3D {
	.num_gpos	=3D ARRAY_SIZE(pwm_gpios),
	.gpos		=3D pwm_gpios,
	.setup		=3D beagle_pwm_gpio_setup, /*to get the gpio base	*/
};

static struct platform_device gpos_pwm =3D {
	.name	=3D "pwm-gpo",
	.id	=3D -1,
	.dev	=3D {
		.platform_data =3D &pwm_gpio_data,
	},
};

static int beagle_pwm_gpio_setup(struct device *dev, unsigned gpio,
				 unsigned ngpio)
{
	beagle_usbhub_pdata.gpio =3D gpio; /* fixed_voltage_config struct */

	platform_device_register(&beagle_usbhub);
	return 0;
}

What do you think?

-- =

P=E9ter
