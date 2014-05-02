From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Display not working if omapdrm is builtin with 3.15rc
Date: Fri, 2 May 2014 15:00:49 +0300
Message-ID: <536388F1.7050304@ti.com>
References: <3A6485D2-7FEA-4C7E-9541-B814DFEE17A2@dominion.thruhere.net> <CABxcv==fYi6fhTj9_qdoozooi6Su7KCao+GY9cx242_BwvC+Ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="XQm9nvNSWUVIqqHoOddb5Hqc0GH6HLRg3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58489 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763AbaEBMAw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 May 2014 08:00:52 -0400
In-Reply-To: <CABxcv==fYi6fhTj9_qdoozooi6Su7KCao+GY9cx242_BwvC+Ew@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>, Koen Kooi <koen@dominion.thruhere.net>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

--XQm9nvNSWUVIqqHoOddb5Hqc0GH6HLRg3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/05/14 14:25, Javier Martinez Canillas wrote:
> Hello Koen,
>=20
> On Fri, May 2, 2014 at 12:47 PM, Koen Kooi <koen@dominion.thruhere.net>=
 wrote:
>> Hi,
>>
>> I've been trying to get DVI on my beagleboard XM to output a picture w=
ith mainline and with 3.15rc it still doesn't work. If I statically build=
 in everything the drm encoders and connectors all go into deferred probe=
 mode and fail, falling back to 1024x768. I with omapdrm and encoders/out=
puts/etc as modules deferred probe is avoided, far fewer error messages a=
nd a 1280x1024 resolution is being used. But still the monitor still says=
 'no signal' detected.
>>
>> So what's the magic to get an actual signal on the hdmi connector?
>>
>> regards,
>>
>> Koen--
>=20
> This is a known issue as far as I know. You need [0] to correctly set
> the display PLL clock rates.
>=20
> Best regards,
> Javier
>=20
> [0]: http://permalink.gmane.org/gmane.linux.ports.arm.kernel/295077

Different board, different problem. The link talks about beaglebone,
Koen about beagleboard.

 Tomi




--XQm9nvNSWUVIqqHoOddb5Hqc0GH6HLRg3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTY4jxAAoJEPo9qoy8lh71iq4P/RyhR96iYejoZVxbxradfGVw
VrTLg53GR/WXErk/rjYNXY0Tdf2x+684A1aDSdAgb8a1XFj5QssPFEuT6tIlTxl7
nweb4+eOh791wKA2PR2kNl0g5dvGHOapAErseHD/cWHgkkqltEbLZqh4sz7KCBir
PXLwD/16wiVfikqJ7wRbW2FnYxUQfAvicJSlUnO7am8YoPvTpdsWZjVSdNY6q0Kf
5DKkrFrYvrtI/NhKLpQnj+3MM4R2B2uh8psWPtV+sw8LK5beCPLxRdCbrpGMk1xA
gtMv5gCp5LNOSAgnjHhJGhvl/nbwycvYKFPOPsFhau7OGN9ktmb8vlBn9ydO/vAK
t8BCl2Zu+ap10ZD7QrevExSTVAV8hdDYO3WfFhKIuDsfBLmRxY7ToXDWql8O+fUR
m7eQIuBLkT5ulDY+0eTgnbewz8FL2zlbeit9uik2vL/U4kzMdpJjkbeGSxWNexeS
gVJbhmC3NrbOgMxCoLA+qc2ZqRminskGEQmk6xwDSnsWqABDRIZFjLCTtoOfyHNd
zY29CtVIN4qpEvw7aebIs+bvemw4pM7rw40N/zqDsrGEseWehoIT5O76K3oM006D
91ibor+CXG5WnlmiLor9xjXCi9XFddJx76NNHOyzgeyYfRC1i292vfkxyMQcBV/2
GWEzCJE2RFG5Vu+ZdJL5
=PxsY
-----END PGP SIGNATURE-----

--XQm9nvNSWUVIqqHoOddb5Hqc0GH6HLRg3--
