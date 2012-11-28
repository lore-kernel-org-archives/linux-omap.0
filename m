From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] gpio: New driver for GPO emulation using PWM generators
Date: Wed, 28 Nov 2012 09:54:57 +0100
Message-ID: <50B5D161.6010200@ti.com>
References: <1353591723-25233-1-git-send-email-peter.ujfalusi@ti.com>
 <20121123075537.A14713E0A91@localhost> <50AF3E21.4000009@ti.com>
 <50AF4584.7020604@ti.com> <20121126154600.765E03E1AFD@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20121126154600.765E03E1AFD@localhost>
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
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Grant, Lars, Thierry,

On 11/26/2012 04:46 PM, Grant Likely wrote:
> You're effectively asking the pwm layer to behave like a gpio (which
> is completely reasonable). Having a completely separate translation node
> really doesn't make sense because it is entirely a software construct.
> In fact, the way your using it is *entirely* to make the Linux driver
> model instantiate the translation code. It has *nothing* to do with the
> structure of the hardware. It makes complete sense that if a PWM is
> going to be used as a GPIO, then the PWM node should conform to the GPIO
> binding.

I understand your point around this. I might say I agree with it as well...
I spent yesterday with prototyping and I'm not really convinced that it is a
good approach from C code point of view. I got it working, yes.
In essence this is what I have on top of the slightly modified gpio-pwm.c
driver I have submitted:

DTS files:
twl_pwm: pwm {
	/* provides two PWMs (id 0, 1 for PWM1 and PWM2) */
	compatible =3D "ti,twl6030-pwm";
	#pwm-cells =3D <2>;

	/* Enable GPIO us of the PWMs */
	gpio-controller =3D <1>;
	#gpio-cells =3D <2>;
	pwm,period_ns =3D <7812500>;
};

leds {
	compatible =3D "gpio-leds";
	backlight {
		label =3D "omap4::backlight";
		gpios =3D <&twl_pwm 1 0>; /* PWM1 of twl6030 */
	};

	keypad {
		label =3D "omap4::keypad";
		gpios =3D <&twl_pwm 0 0>; /* PWM0 of twl6030 */
	};
};

The bulk of the code in drivers/pwm/core.c to create the pwm-gpo device when
it is requested going to look something like this. I have removed the error
checks for now and I still don't have the code to clean up the allocated
memory for the created device on error, or in case the module is unloaded. =
We
should also prevent the pwm core from removal when the pwm-gpo driver is lo=
aded.
We need to create the platform device for gpo-pwm, create the pdata structu=
re
for it and fill it in. We also need to hand craft the pwm_lookup table so we
can use pwm_get() to request the PWM. I have other minor changes around this
to get things working when we booted with DT.
So the function to do the heavy lifting is something like this:
static void of_pwmchip_as_gpio(struct pwm_chip *chip)
{
	struct platform_device *pdev;
	struct gpio_pwm *gpos;
	struct gpio_pwm_pdata *pdata;
	struct pwm_lookup *lookup;
	char gpodev_name[15];
	int i;
	u32 gpio_mode =3D 0;
	u32 period_ns =3D 0;

	of_property_read_u32(chip->dev->of_node, "gpio-controller",
			     &gpio_mode);
	if (!gpio_mode)
		return;

	of_property_read_u32(chip->dev->of_node, "pwm,period_ns", &period_ns);
	if (!period_ns) {
		dev_err(chip->dev,
			"period_ns is not specified for GPIO use\n");
		return;
	}

	lookup =3D devm_kzalloc(chip->dev, sizeof(*lookup) * chip->npwm,
			      GFP_KERNEL);
	pdata =3D devm_kzalloc(chip->dev, sizeof(*pdata), GFP_KERNEL);
	gpos =3D devm_kzalloc(chip->dev, sizeof(*gpos) * chip->npwm,
			    GFP_KERNEL);

	pdata->gpos =3D gpos;
	pdata->num_gpos =3D chip->npwm;
	pdata->gpio_base =3D -1;

	pdev =3D platform_device_alloc("pwm-gpo", chip->base);
	pdev->dev.parent =3D chip->dev;

	sprintf(gpodev_name, "pwm-gpo.%d", chip->base);
	for (i =3D 0; i < chip->npwm; i++) {
		struct gpio_pwm *gpo =3D &gpos[i];
		struct pwm_lookup *pl =3D &lookup[i];
		char con_id[15];

		sprintf(con_id, "pwm-gpo.%d", chip->base + i);

		/* prepare GPO information */
		gpo->pwm_period_ns =3D period_ns;
		gpo->name =3D kmemdup(con_id, sizeof(con_id), GFP_KERNEL);;

		/* prepare pwm lookup table */
		pl->provider =3D dev_name(chip->dev);
		pl->index =3D i;
		pl->dev_id =3D kmemdup(gpodev_name, sizeof(gpodev_name),
				     GFP_KERNEL);
		pl->con_id =3D kmemdup(con_id, sizeof(con_id), GFP_KERNEL);
	}

	platform_device_add_data(pdev, pdata, sizeof(*pdata));
	pwm_add_table(lookup, chip->npwm);
	platform_device_add(pdev);
}

PS: as I have said I have removed the error check just to make the code
snippet more readable and yes we need to do some memory cleanup as well at =
the
right time.

Is this something you would like to see?

-- =

P=E9ter
