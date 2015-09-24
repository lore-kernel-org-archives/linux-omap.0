From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCHv2 2/2] power_supply: Add support for tps65217-charger.
Date: Thu, 24 Sep 2015 17:45:30 +0200
Message-ID: <20150924154529.GB3125@earth>
References: <1443079405-17813-1-git-send-email-enric.balletbo@collabora.com>
 <1443079405-17813-3-git-send-email-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1443079405-17813-3-git-send-email-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <eballetbo@gmail.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, dbaryshkov@gmail.com, dwmw2@infradead.org, tony@atomide.com, sameo@linux.intel.com, lee.jones@linaro.org, sjoerd.simons@collabora.co.uk, javier@dowhile0.org
List-Id: linux-omap@vger.kernel.org


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 24, 2015 at 09:23:25AM +0200, Enric Balletbo i Serra wrote:
> This patch adds support for the tps65217 charger driver. This driver is
> responsible for controlling the charger aspect of the tps65217 mfd.
> Currently, this mainly consists of turning on and off the charger, but
> some other features of the charger can be supported through this driver.
>
> [...]
>
> +static int tps65217_ac_get_property(struct power_supply *psy,
> +			enum power_supply_property psp,
> +			union power_supply_propval *val)
> +{
> +	struct tps65217_charger *charger =3D power_supply_get_drvdata(psy);
> +
> +	if (psp =3D=3D POWER_SUPPLY_PROP_ONLINE) {
> +		val->intval =3D charger->ac_online;
> +		charger->prev_ac_online =3D charger->ac_online;

I think this is no longer needed at this place.

> +		return 0;
> +	}
> +	return -EINVAL;
> +}
>=20
> [...]
>
> +static int tps65217_charger_remove(struct platform_device *pdev)
> +{
> +	struct tps65217_charger *charger =3D platform_get_drvdata(pdev);
> +
> +	kthread_stop(charger->poll_task);
> +
> +	power_supply_unregister(charger->ac);

This is not needed with devm_power_supply_register() and actually
it's wrong, since it would be called again by managed resources
infrastructure.

> +	return 0;
> +}

-- Sebastian

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWBBqWAAoJENju1/PIO/qaxiIP/0Csj1bzNW2L89UKfcpJ0EMw
3oTVetihz8Ik30cHtMasj9Djjg1oJRmhFBfs1pol6trSDb1/8A9VTXSVCi0NPNpt
Bf/kWMxYSsS4QOkqJ+EYqyz+in1Qa6etTuA/fPx4nQU/ID/4PZan1NwznjeMLxRp
CU0zjzKXFyyTRWS5aaAVRUg8yCIW+E/YlnM3BWcX2sH39aTUGZxJhElwk7JN0v4G
Me+NtlYUZCCXmk1uA8xqqo3M5YgOe0buRdQ6VzAkN4L+1ZKkRxBFQdCHwB1fcyFE
3DFjj9+PBPCCfFBvs5qrR3XNkHdv8i54i/5KA9lgp4LxkCvf1EM/kN39lv3Vxdi0
1njYug45oa2poGeCtjxhVVHm+r9+ec0oggHYQdnPWFkyOCMw7a6jQhzelpP7RTpN
zqbIWmTyeB0whl7U1dJHSi8xCkqjhFY6OjiZpZiWgVZONb8BX3RZKiac3njMGpRz
ze/9c2MWBcyv8OAy/Ns9som/QK4i0HevWxqrjWhHYcgdncHxmu63vClDag8lnb4A
TnkBGw2IWvZUJnWpLWF3aGCEugFy/h6RHmSJ/Dhqyg/xHCOeRfkb/cZNItTM7Qku
f62hKaUNU6mbwA1pB7sfoEXUuPP7dRa7LuJA8x/Ch96wHCa/z5IuI6F1Z0jGxEhV
nk/jTODGhWINOXk9WFhQ
=OCfL
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
