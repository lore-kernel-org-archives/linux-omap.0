From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 09/23] OMAPDSS: Create links between managers,
 outputs and devices
Date: Mon, 03 Sep 2012 12:35:31 +0300
Message-ID: <1346664931.12645.5.camel@lappyti>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
	  <1346326845-16583-1-git-send-email-archit@ti.com>
	  <1346326845-16583-10-git-send-email-archit@ti.com>
	  <1346422242.7508.18.camel@lappyti> <5040C907.5090000@ti.com>
	  <1346424344.16067.39.camel@deskari> <1346425698.16067.52.camel@deskari>
	 <504477CD.10901@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-L6+AQfkKVd+0tWTLNO57"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:59795 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756085Ab2ICJfh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Sep 2012 05:35:37 -0400
Received: by lagy9 with SMTP id y9so3421346lag.19
        for <linux-omap@vger.kernel.org>; Mon, 03 Sep 2012 02:35:34 -0700 (PDT)
In-Reply-To: <504477CD.10901@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-L6+AQfkKVd+0tWTLNO57
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-09-03 at 14:56 +0530, Archit Taneja wrote:
> On Friday 31 August 2012 08:38 PM, Tomi Valkeinen wrote:
> > On Fri, 2012-08-31 at 17:45 +0300, Tomi Valkeinen wrote:
> >
> >> So I'm not really against having the enum. It just would've been neat =
to
> >> have the output type and instance number encoded into this enum, so th=
at
> >> it'd be easy to extract either one. But that kinda ruins the possibili=
ty
> >> to use it in a bit mask.
> >
> > Hmm, this is just a non-finished idea (and it's late Friday... =3D) tha=
t
> > came to my mind:
> >
> > I had a brief look at TRMs for different OMAPs (omap4/5/6), and it look=
s
> > like the maximum output options for one manager is 4 (LCD2 on omap4460)=
.
> > Usually there are just 2 or 3.
> >
> > So, we could trust that the above holds and do this so that we use a u3=
2
> > field to hold four 8 bit output options. In 8 bits we can combine two
> > values from 0 to 15. 15 should be more than enough for output display
> > types and output instances.
> >
> > Then with helpers like these:
> >
> > /* second DSI instance */
> > #define DSI1 ((1 << 4) | DISPLAY_TYPE_DSI)
> > /* first DPI instance */
> > #define DPI0 ((0 << 4) | DISPLAY_TYPE_DPI)
>=20
> Okay, so DISPLAY_TYPE_DSI / DPI can't be a number left shifted any=20
> more(that would limit us to have only 4 types of output display types),=
=20
> like we have right now, they would need to be 0, 1, 2, 3 and so on. So=
=20
> with this approach, we could extract the instance number quickly, but we=
=20
> may not be able to check if the manager supports the output display type=
=20
> in constant time.

True, it wouldn't be constant. But it'd be checking between one to four
bytes, so I think it's quite fast =3D).

> > an example output options for a manager that can be connected to DSI1
> > and DPI0 could be:
> >
> > (DSI1 << 8) | (DPI0)
> >
> > This could be parsed with a for loop, going though the 4 bytes of the
> > u32 value. This would allow us to avoid managing a real list, and we
> > could extract the instance and the type from the value. Of course we
> > could also extend the field to u64 to hold 8 outputs if need be.
>=20
> Probably we could have a u64, and 2 bytes for each output, and a bit=20
> mask for both output instance and output display type. We could have=20
> display type enums as:
>=20
> DISPLAY_TYPE_DPI	1 << 5
> DISPLAY_TYPE_DSI	1 << 6
> DISPLAY_TYPE_VENC	1 << 7
> DISPLAY_TYPE_HDMI	1 << 8
> DISPLAY_TYPE_SDI	1 << 9
> DISPLAY_TYPE_RFBI	1 << 10
> ...
>=20
> >
> > Whether this would be worth it compared to simple bitmask, I'm not sure
> > =3D). Depends how much we need to extract the ID and type.
>=20
> Anyway, I don't think I'll try to implement this in this series. I'll=20
> stick to the output instance enums for now.

Sure. And as I said, I'm not sure if it's worth it. We currently have
multiple instances only for DSI, and only two instances there. And I
think we need to handle the instance number only in a few places. It's
not too much to do:

if (type =3D=3D DSI1) ... else if (type =3D=3D DSI2) ...

 Tomi


--=-L6+AQfkKVd+0tWTLNO57
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQRHnjAAoJEPo9qoy8lh71EmkP/2HCiDmiS7gf/4UylFYLus6b
HlqMNDYpmDqw5s/B1FpXvVwQnKdh1762Na8BnL/Mc4u6diR6mWNMsKk8WaUpYVyN
LrcRFDAodEgvAwajXNbqms3m4wq+ovtTxdPhR7GevdWpMYZkOB5TfkykEU56Hrr3
6sD8fmaoLLlZ/R4eTpx7y5L4dnABBtCohlZUp9xisj3v6zwphm9vi/vp+K5BWBrG
2Ya7xPkQh8YkXVEb24cHN67i3GijCAyXj2FJzcoNGVr4LWanU2oF6VX/2BS5dvaQ
e1ls0mvRCH4G1FDkQuoXfBkKgxAQqz5SQ4oISFi8r030gvYpxj2bWsIJdjqAbuDU
ZnNSgxVc7fTyy6KNCFJgN6QSP5SZPF9ripFcs87I/pkGr2biQAPtAFJNAXorznfH
tewo18FuiJjXbXSkXfhnOGJCPtJ/+/NR38GJRhFFRP6PB1DLSQpE2I5md3CgvsjI
bre5IIiZOQIrN9o8G/yZGHk8y55vf0igC8/4i0vtilTF0axvSA5H9s0+vN3JBaEq
6vz4Ze9T3nijT+j4wIBFTGcOBAM7so7i9LoV5txDCkjRGiLZIAkhl4UPxGsT6Qmp
A8cRhsp9F0YBeHvtNjXzMc5Lt6zDhhk88scs2mOSGsDLbPw23LHWZYlahupxOXFg
QbckNlEozGMWJy2pLARe
=bVQ5
-----END PGP SIGNATURE-----

--=-L6+AQfkKVd+0tWTLNO57--

