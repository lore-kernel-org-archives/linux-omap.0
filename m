From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regulator: cpcap: Add basic regulator support
Date: Tue, 31 Jan 2017 21:12:56 +0000
Message-ID: <20170131211256.l3e53y2mkzylfjnw@sirena.org.uk>
References: <20170131001241.5926-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x2bvj5cm7n3dkcpy"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170131001241.5926-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org


--x2bvj5cm7n3dkcpy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 30, 2017 at 04:12:41PM -0800, Tony Lindgren wrote:

> +static int cpcap_regulator_is_enabled(struct regulator_dev *rdev)
> +{
> +	unsigned int value = 0;
> +
> +	regmap_read(rdev->regmap, rdev->desc->enable_reg, &value);
> +
> +	return ((value & rdev->desc->enable_mask) == rdev->desc->enable_reg);
> +}

Use the core support for this, reulator_is_enabled_regmap().

> +	error = regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
> +				   rdev->desc->enable_mask,
> +				   rdev->desc->enable_val);
> +	if (error)
> +		return error;
> +
> +	if (rdev->desc->enable_val & CPCAP_REG_OFF_MODE_SEC) {
> +		error = regmap_update_bits(rdev->regmap, regulator->assign_reg,
> +					   regulator->assign_mask,
> +					   regulator->assign_mask);
> +		if (error)
> +			return error;
> +	}

What does this second register bit do?

> +static int cpcap_regulator_get_voltage(struct regulator_dev *rdev)
> +{
> +	struct cpcap_regulator *regulator = rdev_get_drvdata(rdev);
> +	unsigned int value = 0;
> +	int voltage;

regulator_get_voltage_sel_regmap() (the driver should just use selectors
and let the mapping happen in the core).

> +	regmap_read(rdev->regmap, rdev->desc->enable_reg, &value);
> +
> +	if (!(value & rdev->desc->enable_mask))
> +		return 0;

This is buggy, the driver should report the voltage the regulator will
have when powered.

> +static int cpcap_regulator_set_voltage(struct regulator_dev *rdev,
> +				       int min_uV, int max_uV,
> +				       unsigned int *selector)

regulator_map_voltage_iterate() and regulator_set_voltage_regmap()

> +	switch (mode) {
> +	case REGULATOR_MODE_NORMAL:
> +		value = CPCAP_BIT_AUDIO_LOW_PWR;
> +		break;
> +	case REGULATOR_MODE_IDLE:
> +	case REGULATOR_MODE_STANDBY:
> +		value = 0;
> +		break;

There should be a 1:1 mapping between modes and register values, if the
device only supports two modes so should the driver.

> +	init_data.constraints.valid_modes_mask =
> +		REGULATOR_MODE_NORMAL | REGULATOR_MODE_STANDBY;
> +	init_data.constraints.valid_ops_mask =
> +		REGULATOR_CHANGE_MODE | REGULATOR_CHANGE_STATUS;
> +	config.init_data = &init_data;

Drivers should not configure constraints, they're part of the system
integration and come from the firmware or board file.

> +		dev_info(&pdev->dev, "registering regulator %s\n",
> +			 regulator->rdesc.name);

This is needless spam, please remove it.

--x2bvj5cm7n3dkcpy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliQ/dcACgkQJNaLcl1U
h9AQAQf5ATnJMMPN0u446WksFn3IBMWY2MSd2/ltJvlX3upE3f0e9baLfQY/u8SB
r4F+o6B8V498v0ILgBD0i5kiWdm8BOPIOZ+99n7knNGUIBZDe12EAE3T1O+Ru1Jj
6vm9QE1s8EJ1F8e31VldTIAg3ujFVrXCZjw9K6iOQ24//F4kgYjJfHzkKJbs0sfj
CWkvzY3CEADoNAhxqCe2d+GfKfglDg0Ulann0KA6JVoPUVYkQ1GoGCk8WMogVE/n
dUZv7VcjlZLTSQhv6KIVNna8n/zXIpdGnuvTA1OtPEpJb+v5vw0RCY1TAttI58dI
gzBjoBxE9EycJP6VBEKGi53lDt/lRg==
=JuJc
-----END PGP SIGNATURE-----

--x2bvj5cm7n3dkcpy--
