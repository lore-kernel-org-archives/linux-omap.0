From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAP: DSS2: TPO-TD03MTEA1: update default gamma
Date: Tue, 14 Feb 2012 15:17:52 +0200
Message-ID: <1329225472.1845.112.camel@deskari>
References: <1328573630-7348-1-git-send-email-notasas@gmail.com>
	 <1328573630-7348-2-git-send-email-notasas@gmail.com>
	 <1329222910.1845.90.camel@deskari>
	 <CANOLnONLHgRzZ-rez4p9Ou6qCtoWVhZWPXNEgsQarBRVFstTaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-fXajKhxR0BLTeee8nK4Y"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:37858 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754384Ab2BNNR4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Feb 2012 08:17:56 -0500
In-Reply-To: <CANOLnONLHgRzZ-rez4p9Ou6qCtoWVhZWPXNEgsQarBRVFstTaw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org


--=-fXajKhxR0BLTeee8nK4Y
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-02-14 at 15:14 +0200, Grazvydas Ignotas wrote:
> On Tue, Feb 14, 2012 at 2:35 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:
> > Hi,
> >
> > On Tue, 2012-02-07 at 02:13 +0200, Grazvydas Ignotas wrote:
> >> Over time better gamma has been determined and tuned with some
> >> equipment so update the defaults. From subjective point of view
> >> dark shades should be better visible.
> >
> > Is there even need for default gamma? I'd guess the panel has a default
> > gamma in its firmware, so it should work fine without setting it. And
> > there's sysfs interface to set the gamma from userspace.
> >
> > And, as you said, it's subjective, i.e. there's no right value for it,
> > so I'm a bit inclined to say that the driver shouldn't even set a
> > default gamma, and just leave it to userspace.
>=20
> Well for pandora, we encourage people to run custom Linux distros on
> the device, people reported running Debian, Arch and Slackware on the
> device, so we don't have control over everyone's userspace. To reduce
> the need for everyone to hack userspace of their distro of choice, it
> would be great to have nice display just from the kernel,
> out-of-the-box (this gamma has been tuned with some TV studio
> equipment so is not totally subjective). Still if you don't want it,
> we can keep carrying that in pandora's kernel tree too.

Ok, fair enough. It's not a problem, just a few lines of code. But I
don't want to get patches every now and that adjust the default gamma to
whatever is subjectively best at that point of time =3D).

 Tomi


--=-fXajKhxR0BLTeee8nK4Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPOl8AAAoJEPo9qoy8lh71BSUP/10XoPsHDlRi7zNH/0wwCfW9
k3ObCa49+IVRj+OkNI38ODY+m3IH1Y6M0jW/f7bi2eQCYhlGD2bkJJKJlURDB4TO
h1SCU9NnDHsLLQLZFE/3LUEvGoOoIecm+PMc4BKRPAd7f8ko1xz2l69FIb4OpfHP
IfOzliz1klmYF838UojYJnRjAZ1b2NQrd5Q6TBPmPIYoKr0kG9VwDu9VPt7T9Rcw
ZL3RjmtKkNUcjWUaHQqMyT6kzIyo3JiKNtrRuRqMVY0QdlpeZLPgI/0Pyz1oPF1u
zglpkSb1556nyFkEJ9YONl/p8sXxZyRVUpbKE62+N93+cxpnj/Mv3CuPAchE9N7N
CexHB3zi3KoeBJjHlLC1hjU32jYqpvpnkrlh3qHZZfs9pnZgtvN3ztYwz6N+ba2O
oNfoqRIQ0O888jSJzQyvljpIZ7t3RW/kpuvyx9dyWBxZ9iAyuYK+9zuH0wb0j5v7
xg8KXG1NQvmoFHoSoQyOpWhT8tOlErYOMvszvpXe1mqh4eliChuYkInwaSLSQ6R8
jhlYg8dRsPjwTbiB04Be2B58NkO/7NFmkJvTE0nm1UESBwqRryfuRBwUoUj/Mt6M
uiOuXrQKisDue/RAXE8/g08f1/aWOA5Rkj4EEpkAJM6gC03L/UfabYUfjOvx5vb0
vDxmd7xuWEeGQRPW0D0G
=gIq+
-----END PGP SIGNATURE-----

--=-fXajKhxR0BLTeee8nK4Y--

