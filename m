From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/2 V2] OMAP3+: PM: SR: add suspend/resume handlers
Date: Mon, 25 Jul 2011 11:42:38 +0300
Message-ID: <20110725084238.GC18062@legolas.emea.dhcp.ti.com>
References: <1311526357-7578-1-git-send-email-nm@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9Ek0hoCL9XbhcSqy"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:59444 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750781Ab1GYImm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jul 2011 04:42:42 -0400
Received: by mail-fx0-f43.google.com with SMTP id 17so7639260fxg.30
        for <linux-omap@vger.kernel.org>; Mon, 25 Jul 2011 01:42:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311526357-7578-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Kevin <khilman@ti.com>, Colin <ccross@google.com>, l-a <linux-arm-kernel@lists.infradead.org>, l-o <linux-omap@vger.kernel.org>, felipe <balbi@ti.com>


--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jul 24, 2011 at 11:52:37AM -0500, Nishanth Menon wrote:
> SmartReflex should be disabled while entering low power mode due to
> the following reasons:
> a) SmartReflex values are not defined for retention voltage.
> b) With SmartReflex enabled, if the CPU enters low power state, FSM
>    will try to bump the voltage to current OPP's voltage for which
>    it has entered low power state, causing power loss and potential
>    unknown states for the SoC.
> Since we are sure to attempt entering the lowest possible power state
> during suspend operation, SmartReflex needs to be disabled for the
> voltage domains in suspend path before achieving auto retention voltage
> on the device.
>=20
> Traditionally, this has been done with interrupts disabled as part of
> the common code which handles the idle sequence. Instead, by using the
> fact that we have to disable SmartReflex for sure during suspend
> operations, we can opportunistically disable SmartReflex in device
> standard pm ops, instead of disabling it as part of the code which
> executes with interrupts disabled and slave CPU{s} shutdown. This
> allows the system to do other parallel activities(such as suspending
> other devices in the system using slave CPU{s}) and save the time
> required to achieve suspend and resume from suspended state as a
> sequential activity.
>=20
> However, by being opportunistic as described above, we also increase
> the likelihood of SmartReflex library access functions being invoked in
> parallel contexts *after* SmartReflex driver's suspend handler (during
> suspend operation) or *before* resume handler (during resume operation)
> have been invoked (Example: DVFS for dependent devices, cpufreq for
> MPU etc.). We prevent this by using a flag to reject the callers in
> the duration where SmartReflex has been disabled.

while at that, SR's IRQ is never freed on exit path, could fix it while
you're already there ?

> @@ -998,10 +1020,75 @@ static int __devexit omap_sr_remove(struct platfor=
m_device *pdev)
>  	return 0;
>  }
> =20
> +static int omap_sr_suspend(struct device *dev)
> +{
> +	struct omap_sr_data *pdata;
> +	struct omap_sr *sr_info;
> +
> +	pdata =3D dev_get_platdata(dev);

I'm not sure you need to use platform data here...

> +	if (!pdata) {
> +		dev_err(dev, "%s: platform data missing\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	sr_info =3D _sr_lookup(pdata->voltdm);

this field is held on struct omap_sr. Can't you:

	struct omap_sr	*info =3D dev_get_drvdata(dev);

?? I see that a platform_set_drvdata() is missing from the driver, but
maybe you should add that instead of accessing platform_data.

>  static struct platform_driver smartreflex_driver =3D {
>  	.remove         =3D omap_sr_remove,
>  	.driver		=3D {
>  		.name	=3D "smartreflex",
> +		.pm	=3D &omap_sr_dev_pm_ops,

this should not be valid in case CONFIG_PM isn't enabled.

--=20
balbi

--9Ek0hoCL9XbhcSqy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOLSx+AAoJEAv8Txj19kN18ZYH/2Hg5eXXw0b5o2W4qCO5Hu2V
uHHvAhaPsDeQSRXQrpkdScYel8ZedANW3LE8C2y1JtIkUqPyQk1dtMfJTZhoPMN2
58RC0P6fUflaSnSjtUHAiHqedlmI3vzWoyRFt4eRysFk31Z/m216NyA+p2dliwm1
FDk22XlP7qJlcf/ZSMfmxCfX2SKFCeG7BldIboxT22EOzDzGTSFi72gfn5yVZ6XZ
2NH49tbb17RH2APiti4IRPyGM4s3RboNZPHr8hZYoRQzGpTkNAJiXSH0PmR0F89m
/2D1Cigd6Z5Zi1B9KSAKM3h/OBRH5jqXOJpb3QwqCiiaXtS+cvTUIvusH4ozAuI=
=IQfU
-----END PGP SIGNATURE-----

--9Ek0hoCL9XbhcSqy--
