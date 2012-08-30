From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC PATCH 0/5] cbus/retu drivers to mainline
Date: Thu, 30 Aug 2012 18:39:43 +0300
Message-ID: <20120830153941.GJ1754@arwen.pp.htv.fi>
References: <1346189667-32330-1-git-send-email-aaro.koskinen@iki.fi>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XigHxYirkHk2Kxsx"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:35245 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751664Ab2H3Pny (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Aug 2012 11:43:54 -0400
Received: by lagy9 with SMTP id y9so1646385lag.19
        for <linux-omap@vger.kernel.org>; Thu, 30 Aug 2012 08:43:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1346189667-32330-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org


--XigHxYirkHk2Kxsx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 29, 2012 at 12:34:22AM +0300, Aaro Koskinen wrote:
> Hi,
>=20
> I would like to start converting cbus drivers from linux-omap cbus branch
> for mainline inclusion. Currently e.g. watchdog support is missing at
> least on Nokia N800, so you cannot run the mainline kernel for longer
> than ~60 seconds (and there is no way to disable the watchdog).
>=20
> My proposal is to make cbus an i2c bus driver. For other drivers, it
> should be easier to find a proper place in the tree. Here's a first
> quickly made attempt to provide watchdog driver functionality for
> N800. Please comment.
>=20
> Aaro Koskinen (5):
>   i2c: introduce i2c-cbus driver
>   mfd: introduce retu-mfd driver
>   watchdog: introduce retu_wdt driver
>   arm: omap: n8x0: add i2c-cbus platform data
>   arm: omap: n8x0: enable retu

Very good to see these going upstream :-)

--=20
balbi

--XigHxYirkHk2Kxsx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQP4k9AAoJEIaOsuA1yqREOUUP/0J8nFN7oJArVAvhHU8K77Xu
hvNWJ+ErRRb1vekyUd6530Z6I/Rpp3FAj6xRt7OdrKd9Zq5+EV2jLKuB9G4U1Ahl
KH6nCxJqWSFHeXb8XV+JUQ7bEAER17W/VuDZNEwq5wskug1ORHLThMgX+4j9NLR9
GQCg/Zv4EG40Sy6IRpX2GwS78y41BGe+7+DnY8VlrZEJqcGEf5blUWzakPApxNNX
lT4JuGRu9OwHrWh9akNJ6JvCeQxRWfkyhog0VDXQG1dZuihm22tT2G3Zu/bZ6lX9
nj2OjNC4JanIT0cqy5Uvs+s6u7ZKuneNJ+rbA5fU5jfsZdSISR8DW/E16d0I2fzO
683/XWtttNW/03Ei2LeOU+r9jvgRNjAfEg8WWoMWEymM6H2dhOVk6Rt9vKk9hbmJ
SGrsv212GDx7RC416meWCc0AZ7fZagZsbcz9Qo9atHwfTKNu7OS+Df1blP+LXsf8
cCYx1x4ehgOtQeFR975IVUq5s+086lkuAtdON8NqA2zfSnN6s05sIEgJ3Rxq5cvW
QeppFS/CR+1ZHMoho69Tnfk1sx2kZh+WUUHNrR/pZZI3e+Ra7TdkoAHSzJBayyUJ
N4klimbnc8O3sW88+Whq6UIVHiFCpv5UZ883G/TtI88qMFCMqX4Z0lN7FuN1J9t0
W0v78ll1nvwAizUN7eWu
=Fllp
-----END PGP SIGNATURE-----

--XigHxYirkHk2Kxsx--
