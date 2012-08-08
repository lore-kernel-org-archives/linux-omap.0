From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFC 00/17] OMAPDSS: Change way of passing timings from panel
 driver to interface
Date: Wed, 08 Aug 2012 09:25:58 +0300
Message-ID: <1344407158.17575.21.camel@lappyti>
References: <1343817088-29645-1-git-send-email-archit@ti.com>
	 <1344349948.7216.82.camel@lappyti> <502201B7.9030205@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-uSBzjyAxuvfMjD9qHKjj"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:46850 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932066Ab2HHG0E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 02:26:04 -0400
Received: by lagz14 with SMTP id z14so179633lag.4
        for <linux-omap@vger.kernel.org>; Tue, 07 Aug 2012 23:26:01 -0700 (PDT)
In-Reply-To: <502201B7.9030205@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, sumit.semwal@ti.com, rob@ti.com


--=-uSBzjyAxuvfMjD9qHKjj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-08-08 at 11:35 +0530, Archit Taneja wrote:
> On Tuesday 07 August 2012 08:02 PM, Tomi Valkeinen wrote:
> > On Wed, 2012-08-01 at 16:01 +0530, Archit Taneja wrote:
> >> This series tries to make interface drivers less dependent on omap_dss=
_device
> >> which represents a panel/device connected to that interface. The curre=
nt way of
> >> configuring an interface is to populate the panel's omap_dss_device in=
stance
> >> with parameters common to the panel and the interface, they are either=
 populated
> >> in the board file, or in the panel driver. Panel timings, number of la=
nes
> >> connected to interface, and pixel format are examples of such paramete=
rs, these
> >> are then extracted by the interface driver to configure itself.
> >
> > The series looks good. I had only a few comments to make, but obviously
> > this needs quite a bit of testing. I'll try it out.
>=20
> One thing I'm not sure about is whether these new functions should be=20
> aware of the state of the output. For example, if we call set_timings()=
=20
> with DSI video mode which is already enabled, the timings won't really=
=20
> take any impact.
>=20
> Similar issues would occur when we try to make other ops like=20
> set_data_lines() or set_pixel_format(). These need to be called before=
=20
> the output is enabled. I was wondering if we would need to add=20
> intelligence here to make panel drivers less likely to make mistakes.

Hmm, true. It'd be nice if the functions returned -EBUSY if the
operation cannot be done while the output is enabled.

We have the dssdev->state, but we should get rid of that (or leave it to
panel drivers). It'd be good if the output drivers know whether the
output is enabled or not. I think this data is already tracked by
apply.c. It's about ovl managers, but I think that's practically the
same as output.

Calling dss_mgr_enable() will set mp->enabled =3D true, which could be
returned via dss_mgr_is_enabled() or such.

Then again, it wouldn't be many lines of codes to track the enable-state
in each output driver. So if we have any suspicions that mp->enabled
doesn't quite work for, say, dsi, we could just add a private "enabled"
member to dsi. But I don't right away see why dss_mgr_is_enabled()
wouldn't work.

 Tomi


--=-uSBzjyAxuvfMjD9qHKjj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQIgZ2AAoJEPo9qoy8lh71QXcP/2yQynENmmwi8n47gOLs22Vc
yowbe4au9QeAZCErMw8dqwNAD5wImhS/G8PYsEFKcA9AKtA2Yj+0JCcSEkgYz0FH
eBi4S4zJjFHtTsbJv18lT1+Fd8Cy7WPzKWIjOcAgj99QjL+WYawNlowo85wHiSco
xpvJZgIqvqs02PQn+zeao1mvcC6MXBiYsRy5qOkF1iZuBGxSMude9Y1Q5PdHev3f
/8fqPSBJPnMCg7x6gsRrSFL3Xzs8gqJ41lgtKAfQOX8o3IxqU6qkEbJkR7l6V+ws
IV6d9u8uvwqf56dvVXHwL96iAL45ehHQgDVDyF0xx/EqRqNFq++BjLs2WhETXfeM
kr6kVb/h1UaoZabC41XDRVapDPuK69IT3cNjnKkOexcojg9x/RppoMDOKbYvKTwx
L0iVroTYhKsS6GBsIJyTGP+xNmj9mfk2hfp7cr/UE1YyXY81+2RIfvdnwZ1Ry/kI
YGDGr27zx9LRrKqbNH84rFAb9WKMn8VXBl2gOunnm1QK3ubh2Fpg07w1noTm8joN
VLGAumfj0tAgfeT9E6P73DskangwSUNt6W9TNpNCeWHlBjoDzS8+afIyXfDdNLnu
i/d1AAB/QJg1BGxVFDBXhri9Q0GkwayA6OeI1pBOt3Q8iFWtvr0vLcf0vVoRYfVH
cdfQZ/q6+RZR3cxWhLm0
=M8Vp
-----END PGP SIGNATURE-----

--=-uSBzjyAxuvfMjD9qHKjj--

