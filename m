From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC PATCH 2/2] usb: dwc3: Add chained TRB support for ep0
Date: Mon, 1 Jun 2015 13:42:36 -0500
Message-ID: <20150601184236.GH26081@saruman.tx.rr.com>
References: <1423223735-32512-1-git-send-email-kishon@ti.com>
 <1423223735-32512-2-git-send-email-kishon@ti.com>
 <20150206144841.GB16783@saruman.tx.rr.com>
 <556C2BAC.4070901@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G44BJl3Aq1QbV/QL"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37883 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752019AbbFASoq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Jun 2015 14:44:46 -0400
Content-Disposition: inline
In-Reply-To: <556C2BAC.4070901@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: balbi@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, Sekhar Nori <nsekhar@ti.com>

--G44BJl3Aq1QbV/QL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 01, 2015 at 03:23:48PM +0530, Kishon Vijay Abraham I wrote:
> >>+		transferred =3D transfer_size - length;
> >>+		buf =3D (u8 *)buf + transferred;
> >>+		ur->actual +=3D transferred;
> >
> >this is dangerous. The extra size is because you *must* align OUT to
> >wMaxPacketSize, so you cannot allow more than the original req->length
> >to be copied into buf. That bounce buffer, is really supposed to be a
>=20
> Here we are not handling bounce buffer. The bounce buffer is used only for
> the 2nd TRB which actually programs to receive data that is less than bou=
nce
> buffer size. The 1st TRB will always be max packet aligned and the data is
> directly copied to the request buffer. (However note that if the request
> length is less than bounce buffer size, we'll use 1 TRB only)
>=20
> To summarize..
> We are splitting req->length into 2 TRB's if the req->length is not align=
ed
> to wMaxPacketSize _and_ req->length is greater than bounce buffer size. By
> this way we can make the 2nd TRB to receive data lesser than or equal to
> bounce buffer size and the rest of it can be received using the 1st TRB.
>=20
> Consider the following case.
> ur->length =3D 612;
> maxp =3D 512;
>=20
> This case can't be handled by the existing bounce buffer mechanism since =
the
> size of bounce buffer is only 512. So we program 2 TRB's.
> First TRB
> trb->size =3D 512; /* We don't need bounce buffer for this TRB since it i=
s max
> packet aligned. The data is directly loaded to the request buffer. */
>=20
> Second TRB
> trb->size =3D 512 /* For the remaining 100 bytes we use bounce buffer and=
 it
> uses the same existing bounce buffer mechanism. But instead of copying the
> data to the start of the request buffer, it has to be appended to the data
> that is received due to first TRB. */

this is all fine, but you need to make sure that you only copy the
remaining 100 bytes. Never, ever, ever copy anything past that.

> >throw-away buffer and should never have data in it. You should really
> >add a big fat WARN() if transferred > req->length.
> >
> >The thing is that if host sends more data than we were expecting, this
> >could be someone trying to use our driver as an exploit vector, trying
> >to send more data than it should. We must be robust against that.
>=20
> This is handled in the existing bounce buffer mechanism and I use the same
> bounce buffer mechanism for the 2nd TRB.

ok.

--=20
balbi

--G44BJl3Aq1QbV/QL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVbKecAAoJEIaOsuA1yqREPEEP/jnQSnO8LPNtHcIpeTkHhszq
kBOziJGVnaxdb5ARbUG/fKy9kUe49bN3QqZFUtH7Tc/ZbJwFov5XOFjmKH4ez9dO
9BQr+UoCGkvXXo8fexUobcwLcgj/yqp/95fpSZ1Tys5PNeY0uWnk3Vf/a/fw2TCN
D+W4v3HYjSbbtrnG2qpST/vLIijza/jA93GNzbdYWLwuCmrwW21+tqbZqdeIG7SC
VcO0CB6cgQw7rhXphJCGZzzSTWuolgsnXnS9qvLegcLt19Bes47VuqrgyZkb+AKx
GCUo9ZohxY9SvEpappjF2XUuvvbK3DB4S2J36q9idjdcCCRACLccpahPqBSselIV
6/CnGJMqxjAYfL5OVLlTwdiMeknD/ou/0PYc+TR7hiDCJ1TgrD6qRliHn3SuYWgz
chL7LQNI453XMcfPBCctmPm7sHVi8O59UGkb3a1/wQ5weZuUZTsLJFX+Hf+BelVT
mpZm4dGww7BO8s/M45J5+y5X6+ykv5CWHfgd05J8qeOb5kCEEI2v2LjM/RllAaeD
t9vGGD5kFWLypt58kPUjzeFrMlwp3fVN8JBpGbM1K7VR/xr+1IU/JFTWocXXf8Kf
dMjcYaQI3fr+XKtU+pBO6PNDcIqA9snyfqV5qRdExznMF37g7hNsV/2YacrLxY/i
3vC1wTCsB2ckzqatG6Xo
=wafV
-----END PGP SIGNATURE-----

--G44BJl3Aq1QbV/QL--
