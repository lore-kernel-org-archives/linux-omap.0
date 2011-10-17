From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 01/27] cbus: tahvo: convert spinlock into mutex
Date: Mon, 17 Oct 2011 21:26:35 +0300
Message-ID: <20111017182634.GB31828@legolas.emea.dhcp.ti.com>
References: <1318494902-13093-1-git-send-email-balbi@ti.com>
 <20111017172035.GB27515@atomide.com>
 <20111017180411.GA31828@legolas.emea.dhcp.ti.com>
 <20111017181926.GC27515@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:51790 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750750Ab1JQS0j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Oct 2011 14:26:39 -0400
Received: by mail-bw0-f51.google.com with SMTP id zs8so6501174bkb.24
        for <linux-omap@vger.kernel.org>; Mon, 17 Oct 2011 11:26:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20111017181926.GC27515@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 17, 2011 at 11:19:27AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [111017 10:30]:
> > On Mon, Oct 17, 2011 at 10:20:35AM -0700, Tony Lindgren wrote:
> > > * Felipe Balbi <balbi@ti.com> [111013 01:01]:
> > > > GPIO operations can sleep, so move to a
> > > > mutex.
> > >=20
> > > Great, seems to boot on n800 so pushing all into
> > > cbus branch.
> >=20
> > cool thanks. I think this is pretty much ready for mainline. At least
> > retu. Unless you have any other plans for these little guys.
>=20
> Well I guess they should be in drivers/mfd, but other than that yeah
> these are the last pieces of non-mainline code dragging around.

good, happy to be helping ;-) If Nokia were to open the specs it
would've been simpler, though :-p

> > They have been missing from mainline for a loooong time though. I'm
> > still concerned about the whole cbus bus implementation. Maybe we should
> > the i2c framework (which already supports a few buses) and implement
> > i2c-cbus-gpio.c ?? What do you think ?
>=20
> Heh I guess that's doable too :) Or drivers/spi maybe?

whoever accepts it :-)

--=20
balbi

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOnHNaAAoJEIaOsuA1yqRE9EkP/R0pKG/0sMrZv/O423XY5sYA
R91Vg2ViIaF5Pvk3X7u7WYs6KSREU3tf8Rdf7hfhWKhRHTUIBm7VSP0i4znWgVh6
5ETdapggoRhnyDjtSx5YjINoPf2LHD7LZD2nelKcgB1pUWn1FtY7vOI543GcvQqf
6Uu521OhuESCQPDy/C34wTdQOmXJFkg72crX0LTFeZMh996Kjo3x1cLfN20UCrhe
nPbwVWWBw5JGvmfjUoP8g0+JjR/xL2vukXpfJR4Af5QpKPfAfIomCk+lO5OrBhtp
ypd0alyNASouUO8QllppZh1RFKX7corr8DLJN8nmS6bbvYaLgt00biKy43mEAljJ
GH60yy+m1mnzSFOv0tAODkQhLkcOgHDEmT58KsiTJddA0Iso57EA1uMMRft/JsQ/
xfiE85uJOaKx0Hrq75YuywPbfLjY6JNg8km0pn0OZdJlrhZ2K9IAsPbvRtfIdNKp
7ILJdW4kstMA964DOdb7CvsmdQSZUKid8KfA9v8BLWvRqQ7U5UKGO2QplcYx+oBj
suIxKoqku50txmhDwLi62qjodCo9B/mTyCPRZJ6zKN1sfqN5wD78cvFdj9kf+dL2
plgF3a3ZIYLpi6LNJ8hYwPUskf0CdOS8NID9/31o9pjYtBwzVv6MCzFbJsXe1uLg
qz3M2bGTtNgeAoKFnCDI
=AaZW
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--
