From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 1/2 v2] ARM: OMAP: board-4430sdp: Provide regulator to
 pwm-backlight
Date: Wed, 13 Mar 2013 21:59:14 +0100
Message-ID: <20130313205914.GB29025@avionic-0098.mockup.avionic-design.de>
References: <1363126934-8754-1-git-send-email-achew@nvidia.com>
 <1363126934-8754-2-git-send-email-achew@nvidia.com>
 <51403DFC.90609@ti.com>
 <643E69AA4436674C8F39DCC2C05F7638629CA519E4@HQMAIL03.nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:57902 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933178Ab3CMU7T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Mar 2013 16:59:19 -0400
Content-Disposition: inline
In-Reply-To: <643E69AA4436674C8F39DCC2C05F7638629CA519E4@HQMAIL03.nvidia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew Chew <AChew@nvidia.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Alex Courbot <acourbot@nvidia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2013 at 01:38:31PM -0700, Andrew Chew wrote:
> > > +/* Dummy regulator for pwm-backlight driver */ static struct
> > > +regulator_consumer_supply backlight_supply =3D
> > > +	REGULATOR_SUPPLY("enable", NULL);
> >=20
> > 'enable' is just too generic, the device name should be also provided:
> > 	REGULATOR_SUPPLY("enable", "pwm-backlight");
>=20
> You're right.  I don't like how generic it is as well.  But I don't think
> "pwm-backlight" works...at least, not for me when I test it.  What
> does work is "backlight.x" where x is some number (for me, it's 1).
> Problem is, I don't know what it would be for you.  If only there
> was a way to wildcard that...
>=20
> Would it be better if we called the regulator something other than
> "enable"?  Maybe "backlight-enable", or "bl-enable" for brevity?

The second parameter needs to match the device name. For the 4430sdp
board this should be "pwm-backlight" since the name will be generated
=66rom the .name and .id fields of the struct platform_device. .id =3D -1
will result in no .<id> suffix being attached, so the device should be
named "pwm-backlight". The first parameter needs to match the name of
the supply that the driver requests, so "enable" is correct since the
call to regulator_get() uses that.

Thierry

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRQOiiAAoJEN0jrNd/PrOhVCwQAIe7ZaT3jnVm/jumiSrPT231
rX5MtsaBP8t+vBifKXkVvyUHGE5PeefflG239KsBSV7G7iIOKza2+BYrbGODPXZo
iJxZe+UR9RwbOxntct09iOhLvP7IMJo0XSe0KVxWkz5QS/K3Kp7U4mUg9MZugQGS
fI5JyvAjzdYjrGPb92C3tBELoCVeSq5ao0FhtUZIGOHoLex/1gdd0PjjOMBlgalm
sFy1WVbohCQGBUs3jbH2VM9CRJMpyeG1evtd2/9dQS/1l8Q1rKy/8CCF7R3YyNJn
/+hzyTnSgQUahml8jwC9EOKlKmj3zDYJ4z6tJqcJQfGQlHpUjLDRZbsGkzvO0V35
i13y6PYQoKsbS42pr2ZdDPWCjfXZk1i2jbYQHVJPWfRPJi1eQJOUHNq4WMZrkFYh
Crjbaeq74WNJpcgRLR734T7bm/k2xUcuulyuBxOJij7ZrTXiyiGBryL80kj8i15g
FA31a3hunlmDpeZvw4R8Ui1mn8F1BPUS+hBidoENtrD1M52iJKnvVY/FOgCQy+PF
BWOHEopM4lMqc8WGz3bLF5FDK+pAsdYAOTAJAkC0EADYCwRX3LGzCk6wP7ZKTH8h
KTKFcJTOmsorNGuFBQOJ+FrjEvkUNjHatmJ8QTlqRlu+QpSDdtzMrllEYtrQOgbu
g6hAa9yBt1KXeDrzzcbV
=6apa
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
