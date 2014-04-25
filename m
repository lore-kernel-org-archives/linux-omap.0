From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 11/23] ARM: dts: omap5-uevm.dts: add tca6424a
Date: Fri, 25 Apr 2014 17:20:19 +0300
Message-ID: <535A6F23.1070409@ti.com>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com> <1398334639-14172-12-git-send-email-tomi.valkeinen@ti.com> <53591669.7060502@cogentembedded.com> <5359209F.7000308@ti.com> <53594189.1090508@cogentembedded.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="hrwwtud2Ndf5ILrJNiwcN57L8rw2UWqOk"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55521 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbaDYOUq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Apr 2014 10:20:46 -0400
In-Reply-To: <53594189.1090508@cogentembedded.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Archit Taneja <archit@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

--hrwwtud2Ndf5ILrJNiwcN57L8rw2UWqOk
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 24/04/14 19:53, Sergei Shtylyov wrote:

>> Right. I wonder what the name should be... "gpio" is out, as the name
>> should be more specific.
>=20
>    No, it's not out. The name should be "gpio@22", I think it would be
> unique.
>=20
>> We already have gpio1-8, which are the gpio
>> banks from the SoC.
>=20
>    I don't understand why you are indexing the names while you probably=

> have the address part after @ that makes them unique already.

Ah sorry for the confusion, I misunderstood. I was talking about the
label, not the name, of the node.

So the labels for the gpio banks are 'gpio2' etc. The names are
'gpio@123456' etc. And yes, here the name should be 'gpio@22' as you said=
=2E

I didn't see any rules about the labels in the ePARP doc, so I guess
'tca6424a' would be a valid one. Maybe not a good one, though,
especially if there are multiple tca6424a chips on the board (I need to
check).

 Tomi



--hrwwtud2Ndf5ILrJNiwcN57L8rw2UWqOk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTWm8jAAoJEPo9qoy8lh71jjoP/1tnluzxcmK+M9SWyyMDc+n4
B43399t/y9faEQ48Iz4hiGeHJsFDxG/t5FHCckD9/5z0RcnxXcoyZPthRXFk4xps
DV16+Kn/biB3axQm0/9wkDnxA/mu+xA43O5QSGNkKa+rJZqcz4FpJMk69xhzzPvh
eFP3780F337/UEPLvn0RjrT1btYEEmJDmIm6/mKf6hTXIbLNxgEgqAwtgaTzxYzk
28EC2PtfW/SgTQITbLaSg1a2HeXVM++UQ7IaeGnl+VVXpLSWBzX9uVJEWjZt+Ajs
oG/0nDZHfK+HOKpiAGC8bBrfxub/2q1Gwwk5A08fUxgRACXK9CXm7yUyGL48YcK5
kYUVsaEUz+2emuVEhNTy1IWPvp/R9aRZ9jot9XcTiQGzybiLQOXRtCJKKYyumdZj
bvrkyLhXsrxxa5vu+uWWawr6OuWlJHoprGtejCPRbJDBePpJ6citHNnVEQ/eKsy+
Met2NhA3h2Rhrz2WWDJp28QTEvGRRmdxH5Xkju46KDCBuuOAYE4nb/tBGi858PwD
iWCAFlsnalh9ArceuYtX77JNAR8gczxeo53GabUdgNPneFj9y0FbP+vFy9UXzb+Z
l4LjF2rcE5m0yX3YxPlUSy5CGfMiUBgLehFnumNh+kEzyBoX52tRtg7j7OlpeBVo
cyTWYJW8AjPggHrVcrSn
=2YV/
-----END PGP SIGNATURE-----

--hrwwtud2Ndf5ILrJNiwcN57L8rw2UWqOk--
