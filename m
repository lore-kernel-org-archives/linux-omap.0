From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/2] power: bq24190_charger: Check the interrupt status
 on resume
Date: Sun, 22 Jan 2017 02:54:41 +0100
Message-ID: <20170122015441.wzsbigozefzr5wzw@earth>
References: <20170120220440.1971-1-tony@atomide.com>
 <20170120220440.1971-2-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5oj5rz4rt5eaaxr2"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170120220440.1971-2-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Liam Breck <kernel@networkimprov.net>, "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>
List-Id: linux-omap@vger.kernel.org


--5oj5rz4rt5eaaxr2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tony,

I think your runtime_resume is missing runtime_pm_get/put_sync, see
below:

On Fri, Jan 20, 2017 at 02:04:39PM -0800, Tony Lindgren wrote:
> [...]
> +static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
> +{
> +	struct bq24190_dev_info *bdi =3D data;
> +
> +	bdi->irq_event =3D true;
> +	pm_runtime_get_sync(bdi->dev);
> +	bq24190_check_status(bdi);
> +	pm_runtime_put_sync(bdi->dev);

bq24190_check_status is called with runtime_pm enabled.

> +	bdi->irq_event =3D false;
> =20
>  	return IRQ_HANDLED;
>  }
>
> [...]
>
> +static int bq24190_runtime_resume(struct device *dev)
> +{
> +	struct i2c_client *client =3D to_i2c_client(dev);
> +	struct bq24190_dev_info *bdi =3D i2c_get_clientdata(client);
> +
> +	if (!bdi->initialized)
> +		return 0;
> +
> +	if (!bdi->irq_event) {
> +		dev_dbg(bdi->dev, "checking events on possible wakeirq\n");
> +		bq24190_check_status(bdi);

bq24190_check_status is called without runtime_pm enabled.

> +	}
> +
> +	return 0;
> +}
>
> [...]

-- Sebastian

--5oj5rz4rt5eaaxr2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliEEOEACgkQ2O7X88g7
+pqE6w//ZrHPASCMIwpmLoY4n9YwEH2DhIo6diGE8CBqhYCYbuyXF+smFZr+PK+N
igeChWck5Xr4+5TatHJPmv1cKBIf3vxCIW+bPY+bWDnN1TFczwTZYc7mvw1kTbAA
izZ/6ermXgBh05gGW6DjWirM/Jx448ZKor8aTLyAeNuTwvkgDA7xz0kAWYMCnLMO
w5WbyIqaX2OE59ZMyA4++/o1tCo3Y56s9s8BLnCo3Ju+yWB6iM5MAnQ4A6ujOd+k
tGH4J/J81grg/0rn+/NLBbugVwFDKJ/S+cU3XGTgQR0/qPKdUTANKxZkk2CSt1sb
OGrwABrp+vavOWzK4beKYZtWudADSAZQ6GgYfGyd5+tMOfsXi8KKarvvdBW08auB
G9hzJKEuxjNYDCsj5Jw1K8zbrwYfLHEEQK4XFwzH/jOG4S6EVRxtw9PAsEyVzwyq
rLT3RlEdfZjE5slU0h5ggM59j+k9WLnyrLrQmNDMAE01KzDatyDEOWRcuGP01DiA
eACS81j98cl5LubwWAfO1DQmUcKHHSvXaghiWEzlW9sFjPIL97/hHkOTqc7vDy55
V/cnjD//MHAnYP3HooyVKHPuFQho+tV0qHYKDnyigq4QmFJiiXweSMQgMeOSe5WD
MuQSOE9IYwHgELX8NV8+fiP2C7NPkbG5l5SzhIIVPEeK2MLnrUk=
=OEVS
-----END PGP SIGNATURE-----

--5oj5rz4rt5eaaxr2--
