From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC PATCH 6/6 V2] hwmon: OMAP4: On die temperature sensor driver
Date: Mon, 22 Aug 2011 12:24:31 +0300
Message-ID: <20110822092431.GB26191@legolas.emea.dhcp.ti.com>
References: <1313664735-8917-1-git-send-email-j-keerthy@ti.com>
 <1313664735-8917-7-git-send-email-j-keerthy@ti.com>
 <20110818113702.GU14514@legolas.emea.dhcp.ti.com>
 <CAJ6a13ZKnKbZHsnLxjHWCr3TbVq0QbpBU3g1qq3KCDJybzR+Fg@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:54062 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756532Ab1HVJYg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Aug 2011 05:24:36 -0400
Received: by bkbzs2 with SMTP id zs2so5556338bkb.11
        for <linux-omap@vger.kernel.org>; Mon, 22 Aug 2011 02:24:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJ6a13ZKnKbZHsnLxjHWCr3TbVq0QbpBU3g1qq3KCDJybzR+Fg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, lm-sensors@lm-sensors.org


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 22, 2011 at 09:59:46AM +0530, J, KEERTHY wrote:
> >> +static const struct dev_pm_ops omap_temp_sensor_dev_pm_ops =3D {
> >> + =A0 =A0 .suspend =3D omap_temp_sensor_suspend,
> >> + =A0 =A0 .resume =3D omap_temp_sensor_resume,
> >> + =A0 =A0 .runtime_suspend =3D omap_temp_sensor_runtime_suspend,
> >> + =A0 =A0 .runtime_resume =3D omap_temp_sensor_runtime_resume,
> >> +};
> >
> > this is not enough... you need to populate the other fields. You might
> > want to use something like:
> >
> > static const struct dev_pm_ops omap_temp_sensor_dev_pm_ops =3D {
> > =A0 =A0 =A0 =A0SET_SYSTEM_SLEEP_PM_OPS(omap_temp_sensor_suspend,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_temp_sensor_resume)
> > =A0 =A0 =A0 =A0SET_RUNTIME_PM_OPS(omap_temp_sensor_runtime_suspend,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_temp_sensor_runtime_resume, omap_te=
mp_sensor_idle)
> > };
>=20
> omap_temp_sensor_idle is undefined for temperature sensor as of now. So i=
 will
> populate these fields once the idle function is defined.

make a nop idle function. Those other fields _must_ be populated. Use
something like:

static int omap_temp_sensor_idle(struct device *dev)
{
	/* nothing to do here */
	return 0;
}

--=20
balbi

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOUiBPAAoJEAv8Txj19kN1xnMH/2yIErv7x2bIDUj2l/In1R9j
77MpVegAJDBYJBjPzOAH/XdksFefXhRJqvNCpzb+TSmBUpQx6dlm4R8Y+6HVncd8
2OeO40J+YOdnXyRI1bjiiqRifLqjUy+IPScMPRnszVASGoaqbPyk6RTDmJ7M5YXI
EPageVApp5SSElHNggEs3Kn2PsNdYh1SgHbEfV+RzcghMq0PLQHkT54MyrqopZoY
WF73ae+zNTQLJrEjG6agrOI8aofuyw1L9k2Bd4zgrghJ1YojDvdCw4/v4tA0K6bD
jVvYTqukwGmT3S81Nwh9VfAcj2cp0fHvI/ciuWDvEA2LjU7b1xhrxczY4BBB1Y8=
=VnNK
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
