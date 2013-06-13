From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [GIT PULL] omap dss board clean-up for v3.10 merge window
Date: Thu, 13 Jun 2013 10:56:24 +0300
Message-ID: <51B97B28.3060609@ti.com>
References: <20130418033936.GC10155@atomide.com> <20130419184518.GA30836@quad.lixom.net> <51AC89F6.1050308@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2KKCWXTUQVIPKQKHFQUIH"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38724 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755473Ab3FMH4x (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Jun 2013 03:56:53 -0400
In-Reply-To: <51AC89F6.1050308@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

------enig2KKCWXTUQVIPKQKHFQUIH
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On 03/06/13 15:20, Tomi Valkeinen wrote:

Any feeback about the below? I'm currently aiming for the option 2, and
pushing only the driver changes for the next merge window, as that
allows me to go forward without any arch/arm changes.

 tomi

> I have a somewhat similar situation again for 3.11 (or possibly for
> 3.12). I hope to hear from you what you think would be the best approac=
h.
>=20
> The background is that the omap display subsystem has a bunch of panel
> drivers, and these drivers have used an OMAP DSS specific bus and drive=
r
> model. For various reasons I'm now converting the panel drivers to be
> based on the panel's control bus, i.e. a panel controlled via i2c would=

> be an i2c device/driver, a panel not controlled at all would be a
> platform device/driver, etc.
>=20
> The work involves changing the omapdss driver, converting the panel
> drivers to the new driver model, and changing the board files that use
> the panel.
>=20
> I see two main approaches to this:
>=20
> 1) Convert the panel drivers "in-place", i.e. have a commit which
> changes a panel driver to the new model. This would mean that the
> instant the commit is in, the boards using the panel do not work until
> the board file has been changed.
>=20
> 2) Convert the panel to a new file, i.e. basically make a copy of the
> panel driver while converting it. This way the boards using the old
> panel drivers will continue working. (This is how I have my patches
> currently organized).
>=20
> Option 1) feels more natural, but if the arch and driver changes go
> through separate trees, there's a piece of history during the merge
> window where the displays won't work on the OMAP boards.
>=20
> Option 2) allows us to keep the boards always functional if the new
> panel drivers are merged in 3.11, and the board file changes are merged=

> in 3.12.
>=20
> The downside is that it takes two kernel versions to get this in, and a=

> third kernel version to finally remove all the old code. 3.11 and 3.12
> would contain unused code, some of which will be in the kernel image
> (omapdss side changes) and some of which won't be compiled at all (the
> new panel drivers).
>=20
> Do you think option 2 and splitting the work into three kernel versions=

> is the way to go? Do you have some other ideas how to organize the merg=
e
> of these kind of changes?
>=20
>  Tomi
>=20
>=20



------enig2KKCWXTUQVIPKQKHFQUIH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRuXsoAAoJEPo9qoy8lh718L8P/iZeqo/bnEstFIKR2N7YnWDl
mAzZ9n7k9ZQgczJNPPDkfjgEaLnB7Pq5ineqFrH6HFK3r5YXYUjrBzmTxpyBt+5Q
vV6AUXudXFL08FlbLvZpYxmLSzzbKNPorT4WPLEbrWhtQ25am7lWKxKpaQOU59t4
TUIPsPP1Jq+zOHQzS9EGhPfMiYaWvI9vZpc6LstiQ3Q3METOdHNZQV0INPXN2asy
scDzcUoIsbMKMp+z4do3kFakPsH+4c0e/Rbh3H2W6YZhttTNKS91rruk5XAHSkwx
HacvvtAEKe7HAzQVICBjVUYHIYONghS9CkMtWXoK9GcUzHpCUfoQrkX1iK2HpDQT
wju+6IbgjIlVPEi7e2bx8QX8t43ibrLADff9QTq/q0wvK4q+TgW/hlNPOoV8LPui
hQvJI1rV2hQ3wg/lsaGhoYdlUB5ORZ/oMH8FYlRz429fFjwXBv1XWzGeQblUj/P4
1C8fNoOTpch788wXFNJOOdTLCZ93FKG3nQJeHGVUSjKyojOI1biWLPdMV3ujDmA3
kLpxISRV051tVYuEXt46XOpk1L6SJ4SDSNCl0rkukZBrIVeXoStP0lxe6Dpn2ruD
v762BJRt6rzvZhAGCJrEaXpMP7YJitrGN/nSj9FtjIkz2aSm/tSIoyHzyWiCUJ05
2pC9OUs+xJ84PoFou4mx
=7Vkr
-----END PGP SIGNATURE-----

------enig2KKCWXTUQVIPKQKHFQUIH--
