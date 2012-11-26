From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 2/3] pwm: New driver to support PWMs on TWL4030/6030
 series of PMICs
Date: Mon, 26 Nov 2012 10:31:33 +0100
Message-ID: <50B336F5.1010302@ti.com>
References: <1353405382-9226-1-git-send-email-peter.ujfalusi@ti.com> <1353405382-9226-3-git-send-email-peter.ujfalusi@ti.com> <20121123145844.GA16810@avionic-0098.adnet.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47032 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753975Ab2KZJbi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Nov 2012 04:31:38 -0500
In-Reply-To: <20121123145844.GA16810@avionic-0098.adnet.avionic-design.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Tero Kristo <t-kristo@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

On 11/23/2012 03:58 PM, Thierry Reding wrote:
> On Tue, Nov 20, 2012 at 10:56:21AM +0100, Peter Ujfalusi wrote:
>> The driver supports the following PWM outputs:
>> TWL4030 PWM0 and PWM1
>> TWL6030 PWM1 and PWM2
>>
>> On TWL4030 the PWM signals are muxed. Upon requesting the PWM the dr=
iver
>> will select the correct mux so the PWM can be used. When the PWM has=
 been
>> freed the original configuration going to be restored.
>=20
> "configuration is going to be"

Yes, I'll fix it.

>=20
>> +config PWM_TWL
>> +	tristate "TWL4030/6030 PWM support"
>> +	select HAVE_PWM
>=20
> Why do you select HAVE_PWM?

LEDS_PWM driver for example depends on this option. Not sure why we hav=
e this
in the first place, why PWM alone is not good enough?
we could also select HAVE_PWM when the CONFIG_PWM is enabled to cut bac=
k on
duplicated lines in the Kconfig.


>> +static int twl_pwm_config(struct pwm_chip *chip, struct pwm_device =
*pwm,
>> +			      int duty_ns, int period_ns)
>> +{
>> +	int duty_cycle =3D DIV_ROUND_UP(duty_ns * TWL_PWM_MAX, period_ns);
>> +	u8 pwm_config[2] =3D {1, 0};
>> +	int base, ret;
>> +
>> +	/*
>> +	 * To configure the duty period:
>> +	 * On-cycle is set to 1 (the minimum allowed value)
>> +	 * The off time of 0 is not configurable, so the mapping is:
>> +	 * 0 -> off cycle =3D 2,
>> +	 * 1 -> off cycle =3D 2,
>> +	 * 2 -> off cycle =3D 3,
>> +	 * 126 - > off cycle 127,
>> +	 * 127 - > off cycle 1
>> +	 * When on cycle =3D=3D off cycle the PWM will be always on
>> +	 */
>> +	duty_cycle +=3D 1;
>=20
> The canonical form to write this would be "duty_cycle++", but maybe i=
t
> would even be better to add it to the expression that defines
> duty_cycle?

True. This is actually a leftover from a previous version I had for the
calculation. Will change it.

>=20
>> +static int twl4030_pwm_enable(struct pwm_chip *chip, struct pwm_dev=
ice *pwm)
>> +{
>> +	int ret;
>> +	u8 val;
>> +
>> +	ret =3D twl_i2c_read_u8(TWL4030_MODULE_INTBR, &val, TWL4030_GPBR1_=
REG);
>> +	if (ret < 0) {
>> +		dev_err(chip->dev, "%s: Failed to read GPBR1\n", pwm->label);
>> +		return ret;
>> +	}
>> +
>> +	val |=3D TWL4030_PWM_TOGGLE(pwm->hwpwm, TWL4030_PWMXCLK_ENABLE);
>> +
>> +	ret =3D twl_i2c_write_u8(TWL4030_MODULE_INTBR, val, TWL4030_GPBR1_=
REG);
>> +	if (ret < 0)
>> +		dev_err(chip->dev, "%s: Failed to enable PWM\n", pwm->label);
>> +
>> +	val |=3D TWL4030_PWM_TOGGLE(pwm->hwpwm, TWL4030_PWMX_ENABLE);
>> +
>> +	ret =3D twl_i2c_write_u8(TWL4030_MODULE_INTBR, val, TWL4030_GPBR1_=
REG);
>> +	if (ret < 0)
>> +		dev_err(chip->dev, "%s: Failed to enable PWM\n", pwm->label);
>> +
>> +	return ret;
>> +}
>=20
> Does this perhaps need some locking to make sure the read-modify-writ=
e
> sequence isn't interrupted?

I'll add locking (mutex) to both drivers.

>=20
>> +static void twl4030_pwm_disable(struct pwm_chip *chip, struct pwm_d=
evice *pwm)
>> +{
>> +	int ret;
>> +	u8 val;
>> +
>> +	ret =3D twl_i2c_read_u8(TWL4030_MODULE_INTBR, &val, TWL4030_GPBR1_=
REG);
>> +	if (ret < 0) {
>> +		dev_err(chip->dev, "%s: Failed to read GPBR1\n", pwm->label);
>> +		return;
>> +	}
>> +
>> +	val &=3D ~TWL4030_PWM_TOGGLE(pwm->hwpwm, TWL4030_PWMX_ENABLE);
>> +
>> +	ret =3D twl_i2c_write_u8(TWL4030_MODULE_INTBR, val, TWL4030_GPBR1_=
REG);
>> +	if (ret < 0)
>> +		dev_err(chip->dev, "%s: Failed to disable PWM\n", pwm->label);
>> +
>> +	val &=3D ~TWL4030_PWM_TOGGLE(pwm->hwpwm, TWL4030_PWMXCLK_ENABLE);
>> +
>> +	ret =3D twl_i2c_write_u8(TWL4030_MODULE_INTBR, val, TWL4030_GPBR1_=
REG);
>> +	if (ret < 0)
>> +		dev_err(chip->dev, "%s: Failed to disable PWM\n", pwm->label);
>> +}
>=20
> Same here.
>=20
>> +static int twl4030_pwm_request(struct pwm_chip *chip, struct pwm_de=
vice *pwm)
>> +{
>> +	struct twl_pwm_chip *twl =3D container_of(chip, struct twl_pwm_chi=
p,
>> +						chip);
>=20
> This could use a macro like to_twl(chip).

Does the macro really makes it more readable?

>=20
>> +	int ret;
>> +	u8 val, mask, bits;
>> +
>> +	ret =3D twl_i2c_read_u8(TWL4030_MODULE_INTBR, &val, TWL4030_PMBR1_=
REG);
>> +	if (ret < 0) {
>> +		dev_err(chip->dev, "%s: Failed to read PMBR1\n", pwm->label);
>> +		return ret;
>> +	}
>> +
>> +	if (pwm->hwpwm) {
>> +		/* PWM 1 */
>> +		mask =3D TWL4030_GPIO7_VIBRASYNC_PWM1_MASK;
>> +		bits =3D TWL4030_GPIO7_VIBRASYNC_PWM1_PWM1;
>> +	} else {
>> +		/* PWM 0 */
>> +		mask =3D TWL4030_GPIO6_PWM0_MUTE_MASK;
>> +		bits =3D TWL4030_GPIO6_PWM0_MUTE_PWM0;
>> +	}
>> +
>> +	/* Save the current MUX configuration for the PWM */
>> +	twl->twl4030_pwm_mux &=3D ~mask;
>> +	twl->twl4030_pwm_mux |=3D (val & mask);
>> +
>> +	/* Select PWM functionality */
>> +	val &=3D ~mask;
>> +	val |=3D bits;
>> +
>> +	ret =3D twl_i2c_write_u8(TWL4030_MODULE_INTBR, val, TWL4030_PMBR1_=
REG);
>> +	if (ret < 0)
>> +		dev_err(chip->dev, "%s: Failed to request PWM\n", pwm->label);
>> +
>> +	return ret;
>> +}
>=20
> Again, more read-modify-write without locking.
>=20
>> +
>> +static void twl4030_pwm_free(struct pwm_chip *chip, struct pwm_devi=
ce *pwm)
>> +{
>> +	struct twl_pwm_chip *twl =3D container_of(chip, struct twl_pwm_chi=
p,
>> +						chip);
>> +	int ret;
>> +	u8 val, mask;
>> +
>> +	ret =3D twl_i2c_read_u8(TWL4030_MODULE_INTBR, &val, TWL4030_PMBR1_=
REG);
>> +	if (ret < 0) {
>> +		dev_err(chip->dev, "%s: Failed to read PMBR1\n", pwm->label);
>> +		return;
>> +	}
>> +
>> +	if (pwm->hwpwm)
>> +		/* PWM 1 */
>> +		mask =3D TWL4030_GPIO7_VIBRASYNC_PWM1_MASK;
>> +	else
>> +		/* PWM 0 */
>> +		mask =3D TWL4030_GPIO6_PWM0_MUTE_MASK;
>=20
> I'm not sure how useful these comments are. You have both an explicit
> check for pwm->hwpwm to make it obvious that it isn't 0 and the mask
> macros contain the PWM0 and PWM1 substrings respectively.
>=20
> You could make it even more explicit perhaps by turning the check int=
o:
>=20
> 	if (pwm->hwpwm =3D=3D 1)
>=20
> But either way I think you can drop the /* PWM 1 */ and /* PWM 0 */
> comments.

OK will drop the comment.

>=20
>> +
>> +	/* Restore the MUX configuration for the PWM */
>> +	val &=3D ~mask;
>> +	val |=3D (twl->twl4030_pwm_mux & mask);
>> +
>> +	ret =3D twl_i2c_write_u8(TWL4030_MODULE_INTBR, val, TWL4030_PMBR1_=
REG);
>> +	if (ret < 0)
>> +		dev_err(chip->dev, "%s: Failed to free PWM\n", pwm->label);
>> +}
>> +
>> +static int twl6030_pwm_enable(struct pwm_chip *chip, struct pwm_dev=
ice *pwm)
>> +{
>> +	struct twl_pwm_chip *twl =3D container_of(chip, struct twl_pwm_chi=
p,
>> +						chip);
>> +	int ret;
>> +	u8 val;
>> +
>> +	val =3D twl->twl6030_toggle3;
>> +	val |=3D TWL6030_PWM_TOGGLE(pwm->hwpwm, TWL6030_PWMXS | TWL6030_PW=
MXEN);
>> +	val &=3D ~TWL6030_PWM_TOGGLE(pwm->hwpwm, TWL6030_PWMXR);
>> +
>> +	ret =3D twl_i2c_write_u8(TWL6030_MODULE_ID1, val, TWL6030_TOGGLE3_=
REG);
>> +	if (ret < 0) {
>> +		dev_err(chip->dev, "%s: Failed to enable PWM\n", pwm->label);
>> +		return ret;
>> +	}
>> +
>> +	twl->twl6030_toggle3 =3D val;
>> +
>> +	return 0;
>> +}
>> +
>> +static void twl6030_pwm_disable(struct pwm_chip *chip, struct pwm_d=
evice *pwm)
>> +{
>> +	struct twl_pwm_chip *twl =3D container_of(chip, struct twl_pwm_chi=
p,
>> +						chip);
>> +	int ret;
>> +	u8 val;
>> +
>> +	val =3D twl->twl6030_toggle3;
>> +	val |=3D TWL6030_PWM_TOGGLE(pwm->hwpwm, TWL6030_PWMXR);
>> +	val &=3D ~TWL6030_PWM_TOGGLE(pwm->hwpwm, TWL6030_PWMXS | TWL6030_P=
WMXEN);
>> +
>> +	ret =3D twl_i2c_write_u8(TWL6030_MODULE_ID1, val, TWL6030_TOGGLE3_=
REG);
>> +	if (ret < 0) {
>> +		dev_err(chip->dev, "%s: Failed to read TOGGLE3\n", pwm->label);
>> +		return;
>> +	}
>> +
>> +	val |=3D TWL6030_PWM_TOGGLE(pwm->hwpwm, TWL6030_PWMXS | TWL6030_PW=
MXEN);
>> +
>> +	ret =3D twl_i2c_write_u8(TWL6030_MODULE_ID1, val, TWL6030_TOGGLE3_=
REG);
>> +	if (ret < 0) {
>> +		dev_err(chip->dev, "%s: Failed to disable PWM\n", pwm->label);
>> +		return;
>> +	}
>> +
>> +	twl->twl6030_toggle3 =3D val;
>> +}
>> +
>> +static struct pwm_ops twl_pwm_ops =3D {
>> +	.config =3D twl_pwm_config,
>> +};
>=20
> It might actually be worth to split this into two pwm_ops structures,
> one for 4030 and one for 6030. In that case you would still be able t=
o
> make them const, which probably outweighs the space savings here.
>=20
> Actually, I think this is even potentially buggy since you may have m=
ore
> than one instance of this driver. For instance if you have a TWL6030 =
and
> a TWL4030 in a single system this will break horribly since you'll ov=
er-
> write the pwm_ops of one of them.

True, I will split them. However the twl4030 and twl6030 can not be on =
the
same system. twl4030 is for OMAP3 systems and twl6030 is used only on O=
MAP4
based devices. But you are right.

>=20
>> +	if (twl_class_is_4030()) {
>> +		twl_pwm_ops.enable =3D twl4030_pwm_enable;
>> +		twl_pwm_ops.disable =3D twl4030_pwm_disable;
>> +		twl_pwm_ops.request =3D twl4030_pwm_request;
>> +		twl_pwm_ops.free =3D twl4030_pwm_free;
>=20
> This would become:
>=20
> 		twl->chip.ops =3D &twl4030_pwm_ops;
>=20
>> +	} else {
>> +		twl_pwm_ops.enable =3D twl6030_pwm_enable;
>> +		twl_pwm_ops.disable =3D twl6030_pwm_disable;
>=20
> and:
> 		twl->chip.ops =3D &twl6030_pwm_ops;
>=20
>> +static struct of_device_id twl_pwm_of_match[] =3D {
>> +	{ .compatible =3D "ti,twl4030-pwm" },
>> +	{ .compatible =3D "ti,twl6030-pwm" },
>> +};
>> +
>> +MODULE_DEVICE_TABLE(of, twl_pwm_of_match);
>=20
> Nit: I think the blank line between "};" and "MODULE_DEVICE_TABLE(...=
)"
> can go away.

True.

> And you might want to protect this with an "#ifdef
> CONFIG_OF" since you don't depend on OF.

The of.h already takes care of this when we do not have CONFIG_OF.

Thank you,
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
