From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 2/2] PWM: EHRPWM: PWM driver support for EHRPWM.
Date: Mon, 23 Jul 2012 09:42:21 +0200
Message-ID: <20120723074221.GB23797@avionic-0098.mockup.avionic-design.de>
References: <1342172102-30363-1-git-send-email-avinashphilip@ti.com>
 <1342172102-30363-3-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:57240 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753926Ab2GWHm2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jul 2012 03:42:28 -0400
Content-Disposition: inline
In-Reply-To: <1342172102-30363-3-git-send-email-avinashphilip@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Philip, Avinash" <avinashphilip@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 13, 2012 at 03:05:02PM +0530, Philip, Avinash wrote:
> Enhanced high resolution PWM module (EHRPWM) hardware can be used to
> generate PWM output over 2 channels. This commit adds PWM driver support
> for EHRPWM device present on AM33XX SOC. Current implementation supports
> simple PWM functionality.
>=20
> Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
> Reviewed-by: Vaibhav Bedia <vaibhav.bedia@ti.com>

So this driver is very similar to the ECAP one and pretty much all the
comments apply to this as well. Some additional comments below.

> ---
> :100644 100644 f20b8f2... ad62d7a... M	drivers/pwm/Kconfig
> :100644 100644 7dd90ec... 636a1d6... M	drivers/pwm/Makefile
> :000000 100644 0000000... 985d334... A	drivers/pwm/pwm-ehrpwm.c
>  drivers/pwm/Kconfig      |   10 +
>  drivers/pwm/Makefile     |    1 +
>  drivers/pwm/pwm-ehrpwm.c |  476 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 487 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index f20b8f2..ad62d7a 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -95,4 +95,14 @@ config  PWM_ECAP
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm_ecap.
> =20
> +config  PWM_EHRPWM
> +	tristate "EHRPWM PWM support"
> +	depends on SOC_AM33XX
> +	help
> +	  PWM driver support for the EHRPWM controller found on AM33XX
> +	  TI SOC
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-ehrpwm.
> +

Maybe it would be useful to prefix the names with AM33XX here. ECAP and
EHRPWM are sort of generic and may have name clashes in the future.

> +#define PWM_CHANNEL		2	/* EHRPWM channels */

I'd say you can just replace the one occurrence of this with the literal
2. If you still want to have the symbolic name, then I'd suggest to call
it something like NUM_PWM_CHANNELS to make its meaning more obvious.

> +static int __devexit ehrpwm_pwm_remove(struct platform_device *pdev)
> +{
> +	struct ehrpwm_pwm_chip *pc =3D platform_get_drvdata(pdev);
> +
> +	if (WARN_ON(!pc))
> +		return -ENODEV;
> +
> +	pm_runtime_disable(&pdev->dev);
> +	pwmchip_remove(&pc->chip);
> +	return 0;
> +}

I forgot to mention this for ECAP, but you need to check the return
value of pwmchip_remove() because there are situations where it can
actually fail.

Thierry

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQDQBdAAoJEN0jrNd/PrOh9G4P/2EhY70Wv+M4oZAZyZclDG2G
rmAXvIzaqxarj8D9XsJG/j+PSLqTZJqgrIRWBTIBQUyZOTQBgdpcjqi7MmSEB7He
OwEdjj+07P8XM7n8K8TmXSjT418zy62FPJEXXSbKIka1+f/rGz2kpRWsCS73ogJa
WOFVO+TdJ28W/ke7U01FF7PdZJwAbp6itSmxMxzQJbr3SL+Sb7F8CnRj1MD3/E9H
RpYm4olA+NNqGFuxO81gONXx0TsC6wstxNi0MlDKzpuHzlu/yXLttxSSUJqwRGoi
1s7TkTpAzOBAvOLg+z10OFHkA9tlPUVWJMezd9mlH0ZmQ1rdrgTgdW3PsRNR9TUW
kqHMIBK+d198kHHeYEb37cky6CXL0CQi+a8H1Q39zQs4wI9/G5XFax+iM7lqxlIc
nkHTw6D85XpAfSZuWGa5FL3owOB2wXHNYrilmdfQrV8/r5kQL1SHU4ehv92gUAm5
Qlg6FFX36P0n4OFoW59RXNGc7eNdtXgEab6uA6+5FkKPzsLcSCwXeYUKQAhNoqs+
foSmBeKr7Txh3qTEsY8favUieyjPlu9fCDVe7Q74uMYioUks8MTp1tY7K9/YSK87
JoIekvRIVnlKMykwBixt7eSsrXNKstfNQcVKjG9zP11XSWpyKML8Dn6Wes0HUFEf
OdLj0uE8n9alzrsABA2l
=Yj/h
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
