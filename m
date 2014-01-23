From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 3/3] driver: pwmss: Disable stop clk bit during enable
 clock call.
Date: Thu, 23 Jan 2014 15:17:51 +0100
Message-ID: <20140123141750.GB6503@ulmo.nvidia.com>
References: <1387366615-23182-1-git-send-email-sourav.poddar@ti.com>
 <1387366615-23182-4-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1387366615-23182-4-git-send-email-sourav.poddar@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2013 at 05:06:55PM +0530, Sourav Poddar wrote:
> Writing to ecap register on second insmod crashes with an external
> abort. This happens becuase the STOP_CLK bit remains set(from rmmod)=20
> during the second insmod thereby not allowing the clocks to get enabled.
>=20
> So, we disable STOP clock bit while doing a clock enable.
>=20
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> ---
>  drivers/pwm/pwm-tipwmss.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-tipwmss.c b/drivers/pwm/pwm-tipwmss.c
> index 3b119bc..4749866 100644
> --- a/drivers/pwm/pwm-tipwmss.c
> +++ b/drivers/pwm/pwm-tipwmss.c
> @@ -40,6 +40,8 @@ u16 pwmss_submodule_state_change(struct device *dev, in=
t set)
> =20
>  	mutex_lock(&info->pwmss_lock);
>  	val =3D readw(info->mmio_base + PWMSS_CLKCONFIG);
> +	if (set =3D=3D PWMSS_ECAPCLK_EN)
> +		val &=3D ~PWMSS_ECAPCLK_STOP_REQ;

Should this be done for set =3D=3D PWMSS_EPWMCLK_EN as well? Also how does
this behave if somebody goes and passes:

	PWMSS_ECAPCLK_EN | PWMSS_ECAPCLK_STOP_REQ

as the "set" parameter.

I think that perhaps the pwmss_submodule_state_change() API should be
rethought. Instead of taking a value that's directly written into the
register, perhaps it should abstract away what this does.

=46rom my understanding this is used to enable (or disable) the clock for
a specific submodule (ECAP or EHRPWM). Perhaps an interface like the
following would be more intuitive:

	bool pwmss_module_enable(struct device *dev, enum pwmss_module module)
	{
		struct pwmss_info *info =3D dev_get_drvdata(dev);
		u16 value, mask, state, ack;

		switch (module) {
		case PWMSS_MODULE_ECAP:
			mask =3D PWMSS_ECAPCLK_EN | PWMSS_ECAPCLK_STOP_REQ;
			state =3D PWMSS_ECAPCLK_EN;
			ack =3D PWMSS_ECAPCLK_EN_ACK;
			break;

		case PWMSS_MODULE_EPWM:
			mask =3D PWMSS_EPWMCLK_EN | PWMSS_EPWMCLK_STOP_REQ;
			state =3D PWMSS_EPWMCLK_EN;
			ack =3D PWMSS_ECAPCLK_EN_ACK;
			break;

		default:
			return false;
		}

		mutex_lock(&info->pwmss_lock);
		value =3D readw(info->mmio + PWMSS_CLKCONFIG);
		value &=3D ~mask;
		value |=3D state;
		writew(value, info->mmio + PWMSS_CLKCONFIG);
		mutex_unlock(&info->pwmss_lock);

		value =3D readw(info->mmio + PWMSS_CLKSTATUS);
		return (value & ack) !=3D 0;
	}

	void pwmss_module_disable(struct device *dev, enum pwmss_module module)
	{
		struct pwmss_info *info =3D dev_get_drvdata(dev);
		u16 value, mask, state;

		switch (module) {
		case PWMSS_MODULE_ECAP:
			mask =3D PWMSS_ECAPCLK_EN | PWMSS_ECAPCLK_STOP_REQ;
			state =3D PWMSS_ECAPCLK_STOP_REQ;
			break;

		case PWMSS_MODULE_EPWM:
			mask =3D PWMSS_EPWMCLK_EN | PWMSS_EPWMCLK_STOP_REQ;
			state =3D PWMSS_EPWMCLK_STOP_REQ;
			break;

		default:
			return false;
		}

		mutex_lock(&info->pwmss_lock);
		value =3D readw(info->mmio + PWMSS_CLKCONFIG);
		value &=3D ~mask;
		value |=3D state;
		writew(value, info->mmio + PWMSS_CLKCONFIG);
		mutex_unlock(&info->pwmss_lock);
	}

One possible other interesting alternative would be to export this
functionality via the common clock framework, since you're essentially
exposing clk_enable() and clk_disable(). That's probably overkill,
though.

Thierry

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS4SSOAAoJEN0jrNd/PrOhlvAP/R3Gd1uX61L2cyRMvK2G0m8u
G9oB/wIK3eooVgzDGzrxxtWf4QctTeMl1l1qe453oNScX+/YVdNXHB2VLx2I91oi
TJO9h3OxAqsmU8MFuh9iIdeyuumWMdREh4Ub12MwVbv0cRGRAqthYJv7RRHzKS5+
FSoOhF6t+5S52/pgl9ptV5u5b+f1QI6sq0LsO7SsuFVhToG/09e/d+6jgJIZZifq
o1Yt4+a71z0sHAoTfwM6wWI5rdkMbGlTh2u3NZDFYNHAP4VRn08Bk+O4RXULnA85
et2xfB3TXKI0EAGOjrPwh6BIpfVhFw3Yjj38cL8H1dDLyepZ20gHtF7+Pbv9N3++
jy8rSO81kCmH7PCc3TgdeElriIMtqlPZBxBvvwl/paCqHl4unDU9Hy9seyXCp7YJ
7fPEQhAzxmThlTT12D/Tqyphj+Uf3pxXtkkIALA9VIAxjl5JEJRQSzm+46bh2yXO
XJ2b/NxG48CzVZ+tQmbfn6WVZoQ+PoWCx0jY8dhbi7VJmJx+dHKPQDesmZ19ETBu
G9dxkiSaClSohB00MkRB33RGq2yGEZzJcLI6H7uu6udAB4KWVTWXPUzOOPjv9XaX
yF5KZZ+d5oG5OHGFDTx7bT9QxU8XwOZIE/aFlInpUXVTMcowFf50A0exZ7X1cqZt
xLeYt4bXUM/70ca2RPRh
=WZll
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
