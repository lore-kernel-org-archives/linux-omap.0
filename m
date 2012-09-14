From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/21] OMAPDSS: DISPC changes for writeback pipeline
Date: Fri, 14 Sep 2012 13:53:16 +0300
Message-ID: <1347619996.2559.83.camel@deskari>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
	 <1347611263.2559.44.camel@deskari> <50530367.5030303@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-EmQvhPtJMjJ/Fm2WctMQ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:51852 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751221Ab2INKxY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Sep 2012 06:53:24 -0400
Received: by lbbgj3 with SMTP id gj3so2649948lbb.19
        for <linux-omap@vger.kernel.org>; Fri, 14 Sep 2012 03:53:19 -0700 (PDT)
In-Reply-To: <50530367.5030303@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-EmQvhPtJMjJ/Fm2WctMQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-09-14 at 15:43 +0530, Archit Taneja wrote:
> On Friday 14 September 2012 01:57 PM, Tomi Valkeinen wrote:

> I initially kept all of this the same, but I changed my mind at some=20
> point, not totally sure why. Even if we stick to the dispc_ovl_* names,=
=20
> we would still need to create q common function which dispc_ovl_setup()=
=20
> and dispc_wb_setup() could call. I called this dispc_plane_setup(), and=
=20
> then it felt weird to call everything else ovl specifuic, hence renamed=
=20
> all of them to dispc_plane_*.
>=20
> Could you suggest a better name than dispc_plane_setup?

Well... dispc_ovl_setup_common?

The function is also quite big, with huge number of arguments. Makes me
wonder if we could split it up to some sensible parts. Would it be
possible to have functions to setup, say, input related parameters
(base-address, pix format, etc.), output related parameters (ovl
position, ...).

Well, it could just make it more confusing, as some things are shared
between input and output, like scaling related things. But just an idea.

>=20
> >
> >> functions. The next few patches change how overlay caps are used withi=
n the
> >> dispc functions, this helps reusing more functions between overlays an=
d
> >
> > I dislike this a bit, I think dispc driver should know what HW it has,
> > you shouldn't need to pass caps to it. So I'd prefer the dispc driver t=
o
> > to have this information in dispc_features. I believe all OVL_CAPS
> > should be there, and then exported to other drivers via some means. I
> > guess this means could for now be just initializing ovl->caps with data
> > from dispc.c.
>=20
> Currently, we pass the plane id to these low level functions, it=20
> extracts out the ovl struct usingthe plane id, and checks the ovl caps.
>=20
> What I'm doing now is just passing the caps directly to these low level=
=20
> functions. So that I don't need to have complicated checks in every=20
> function to extract caps between overlays or writeback.

Yep, I see. It's ok.

My main dislike is the use of omap_dss_get_overlay() in dispc.c. I'd
like dispc.c to be self-contained, so what I mean is that instead of
initializing the caps in dss_features.c, and calling the above function
in dispc.c, we should have a dispc.c internal table for dispc's HW,
which would contain the caps and other necessary information.

But that's not really related to this series.

 Tomi


--=-EmQvhPtJMjJ/Fm2WctMQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQUwycAAoJEPo9qoy8lh71BdAP/AuKSplf6mMRD3HXsfeiDWvA
xM131F7MiKTBsADpV73tdhUEkqEE7MUlVBjTeoGNG/mNlbIoTm1Xu8ZklgMRGMsh
tMwv8TEdfHG+ud/5jm8DGXXQ8JGxHgVhaMpfgZxuR2wOrv+Xk3Kc7iZUDIiJYrk9
NbkDPgtgHfh4pGhQNPUkYEUJ7piezO+SJrpTYfZU9LxZ+CiBqHjyCkclFkoBkn2i
yK/WpMnLjT7wQkWvpCNx9X98dyY+jakC4mha24fXw/uN4NdROSVq8ZS5MSOx9QDC
2AcbjK1DYibJoCsECnxarcduFFmXni4OdnMkzWHshh8MKLfqK/vmse52zspYs96J
OEAUfHdIu9dPlLNue/nSlyHuvGt3wvptEfLXNTToR3ZRSsEGgog9M76fPM6TKmvz
+AMukB4IUZbyVAJy5m6+L+ENTHNlRaQfj//puw2/p2FoFymoUrMFDMmxzuSy1MSv
VJ4tZVkBL8En3fhQYGd9auguC/kvauytlyZv7bdBsWNPw2yF6g0GdRF3c3xz5tWK
pGDcOglQOY0+2qx7wGQCMj7Elysc9rud+PAkredv7gTiMZ0u8iuxKxpbfj3QxyAQ
OTptQnnnxh08hvK9jVqCrQoiujhn30dmSc2PfwamP/k7GGU5Pu40O9Tmp4RjcsVu
gLRxPrOKWRd+fDzneA3+
=M+lZ
-----END PGP SIGNATURE-----

--=-EmQvhPtJMjJ/Fm2WctMQ--

