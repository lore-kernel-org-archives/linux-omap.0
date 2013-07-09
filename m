From: Felipe Balbi <balbi@ti.com>
Subject: Re: Boot hang regression 3.10.0-rc4 -> 3.10.0
Date: Tue, 9 Jul 2013 10:40:05 +0300
Message-ID: <20130709074005.GG5552@arwen.pp.htv.fi>
References: <B5906170F1614E41A8A28DE3B8D121433EE94489@DBDE04.ent.ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EE94520@DBDE04.ent.ti.com>
 <20130708112553.GU5523@atomide.com>
 <51DAB394.3050104@ti.com>
 <20130708131033.GA5523@atomide.com>
 <51DABC81.3080409@ti.com>
 <20130708133512.GD31221@arwen.pp.htv.fi>
 <51DBA0C2.6030003@ti.com>
 <20130709064212.GB5552@arwen.pp.htv.fi>
 <51DBB96E.90600@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8S1fMsFYqgBC+BN/"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51804 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751960Ab3GIHk7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Jul 2013 03:40:59 -0400
Content-Disposition: inline
In-Reply-To: <51DBB96E.90600@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: balbi@ti.com, Tony Lindgren <tony@atomide.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Jackson <mpfj-list@newflow.co.uk>, Sourav Poddar <sourav.poddar@ti.com>, Paul Walmsley <paul@pwsan.com>

--8S1fMsFYqgBC+BN/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 09, 2013 at 12:49:10PM +0530, Rajendra Nayak wrote:
> >>>> Right, but calling serial_omap_restore_context() even when the conte=
xt
> >>>> is not lost, should not ideally cause an issue.
> >>>
> >>> it does in one condition. If context hasn't been saved before. And th=
at
> >>> can happen in the case of wrong pm runtime status for that device.
> >>>
> >>> Imagine the device is marked as suspended even though it's fully enab=
led
> >>> (it hasn't been suspended by hwmod due to NO_IDLE flag). In that case
> >>> your context structure is all zeroes (context has never been saved
> >>> before) then when you call pm_runtime_get_sync() on probe() your
> >>> ->runtime_resume() will get called, which will restore context,
> >>> essentially undoing anything which was configured by u-boot.
> >>
> >> This could be a problem for drivers which do a save context in ->runti=
me_suspend()
> >> but from what I see with omap serial, there is no save context done as=
 part of
> >> ->runtime_suspend.
> >=20
> > right, because context is "saved" in set_termios. probe() will get
> > called much before set_termios() has a chance to run, right ?
> >=20
> > Same problem will trigger in that case.
> >=20
> > I still think patch below is necessary
>=20
> Right, I'll try some on those lines. Looks like a
> pm_runtime_set_active() is done for the console in the non DT case in
> omap_serial_init_port(). It seems to be missing in the DT case.

yeah, based on conversation I had with Alan Stern a while back,
pm_runtime_set_*() is best called by the underlying 'bus' and I tend to
agree with him on that.

Our HWMOD being our 'bus' (not really, but still), is the entity which
knows if the device is powered or not and should make sure to call
pm_runtime_set_*() for all devices.

> Although I feel this should fix the issue we have right now, I wonder
> if there could ever be a case with uart being suspended and having to
> resume again before a set_termios? What I mean to ask is, if the omap
> serial driver assuming a resume to happen only post a set_termios is
> always valid.

Meaning, probe() -> suspend() -> resume() ? I don't think that would
ever happen. ->set_termios() would always get called and that's actually
what triggers the resume.

--=20
balbi

--8S1fMsFYqgBC+BN/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR275VAAoJEIaOsuA1yqREdKgQAJmbYcFADr4n3IW8JVj4U5Yg
DEIueoOKJI/DrJPntQnGRBZzhvuyvpT5k1MQW8nPCMC/LDnE3FYgOIpMnIhOorlx
J9VJtS7KtI66HKgfwoGHdJmPpGsIpSBNJASWPjfWAVteLjtvarHAjVyU63uWJOO9
vUPXaIKDiTXniqn5xYXI6gsV4N671O7msw+4WcxFeOtMedqZL/bLuOtfy09xeRYL
LVNAwooHg/m04NvAfvATCb5DcDFrq0nwTge2VZrNM9asX4nElwhoMSzEfEM6RIWT
+oCktVdDRI49xCbigLOJ1G3Br22L/Holazq3Ad/Ys3RoM9FVVkuwqpBxZF2vql/g
9vLP32A4ZRv55tZfmADVSzrcZoa+fMf2qcNZFP8RwhZDIPeSx+HtRJJb8oK0RaPW
fJxBNE0mS5xEvIEqrKYcHM05ejkNFbWpwRTLDnvJ0FWH7i5uApRWuBQwJoUI03E+
8nFbfdtioU2lJeEv5MBYaaV3y5Wynt13SBG21N74xwAqUudmyhdpB7nZTO029dM8
TPmFIWtiCzQkDK6MM8xKkYuKNzmjUeprlLpckBTZSa+OEjFiAtJrz40qUUxLOJxK
3E0L6Xc7PACwSrUasaqHkxUNJWXTxfG4fQhRnHb25hnm1Tw/HA/qO1RMRG2rGNh4
sI/DLXIgEukVYa2QArER
=qMas
-----END PGP SIGNATURE-----

--8S1fMsFYqgBC+BN/--
