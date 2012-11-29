From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: omap DSS fails with tft410 driver panel?
Date: Thu, 29 Nov 2012 16:56:35 +0200
Message-ID: <50B777A3.1080803@ti.com>
References: <CAFqH_50PVJdbX0CMwo9t3RuAhzi3q6jcBwzq2R3UFighkrF7iw@mail.gmail.com> <CAGDS+nmx8qFSx932TudMN6ikmZ=OGkbvrZuCV=Ump+HETkU-tw@mail.gmail.com> <50ADE6A5.3030001@ti.com> <CAGDS+nm2YVNyq+eAF-VSq785KAKWC2GM4v5U7N1vLGTNNDfa7Q@mail.gmail.com> <50AF37EA.3080400@ti.com> <CAGDS+nncx71OL7tiwEot6RcyFxipj_SVg=z5Sg-Qdv2n4iyL2A@mail.gmail.com> <50B4A4D7.2070203@ti.com> <CAGDS+nmaGK1igkYnz0EQEycUU=LsD5yz9wxmipSnWohKvAPTXA@mail.gmail.com> <50B74592.3020308@ti.com> <CAGDS+n=oQYr+24mX6bdgtW=fzvfvfX5rAvNXXpxM4YKPxHDodQ@mail.gmail.com> <50B771D3.8050907@ti.com> <CAGDS+n=dbuEQgdw9nJ_mYQpuJr5huSgX6e3sBDcvy0+C6T5hFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA0EAC8A330CD95694F845421"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39371 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407Ab2K2O4k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Nov 2012 09:56:40 -0500
In-Reply-To: <CAGDS+n=dbuEQgdw9nJ_mYQpuJr5huSgX6e3sBDcvy0+C6T5hFQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Enric Balletbo Serra <eballetbo@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>

--------------enigA0EAC8A330CD95694F845421
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-29 16:53, Steve Sakoman wrote:
> On Thu, Nov 29, 2012 at 6:31 AM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
>=20
>>> It is stock Linux 3.6 (i.e. commit a0d271cbfed1dd50278c6b06bead3d00ba=
0a88f9)
>>
>> Still can't reproduce. So does the null pointer deref happen at boot
>> time? What display related kernel boot options do you have? This looks=

>> funny, considering lcd43 is a bit smaller lcd:
>=20
> Yes, it happens at boot time.
>=20
> The boot options:
>=20
> [    0.000000] Kernel command line: console=3DttyO2,115200n8 mpurate=3D=
500
> vram=3D12M omapfb.mode=3Ddvi:1024x768MR-16@60 omapdss.def_disp=3Dlcd43
> root=3D/dev/mmcblk0p2 rw rootfstype=3Dext3 rootwait

Ok, now I see it. It happens because DVI is not configured to be used,
but you have DVI video mode specified in the command line.

I'll study this further and make a fix.

 Tomi




--------------enigA0EAC8A330CD95694F845421
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQt3ejAAoJEPo9qoy8lh71ILcQAIHnzdochwzwxvdepBvLtHPe
WG7CLBSAEWSabXj6+Nv4xie27Pnpkt3ZyK1fqRvNOZOErqpfmPMsQVtPi3D7/hOI
aN23FLtEvsz7EMlLZrV8kZSmm11ryy4o+DnaJKZ7SK6sxpbq/51VhkTMrK1D1Xvh
E16hCMDv/sYjaXe6QY4sddVlNCPs0pN6uD2LAzvi5uVa2j5X1sUCdkS2YDKiNX0k
576+OFLIWBAcYCUOiSV16cneBpksmpM13N+e8N+Ig5tco+Ja37I6d1emkM2wPB81
KwN9FcU+CnDIdzeyek2uzf9IdsJDrpFdIX7MuDqJ9mK9PTs6lBkKDwDXunkJ+oA3
sj3PtY8soHf2ewQqFdq1TyawTenigk+l0+K7yAbdz1lMzWWtmyW2hMF4+XDFcmFO
YxRBsgeXmrR7Bj7boqaSD4hZ+TygM0o1LUznEHFs1Z4YxPHPSWAnCNGEZTUIUGo0
egtBHySsyY+ctjki8TZkw8t8ez1ONbYjjvfaTs1DO+2tN0USAw7dV657n0yYqMoF
Z8E9dr83nMR+UmJO3sBpYumRHa/T39egGFHh6euX65xq/DobTlGlT1Lzl3Egs6oQ
zPeyFfn+yb6a+7yay2Ixia9M9vRhB2zdGXt4pcCBEvdb1shieUC24ORPuPycdjZN
qQ1Ez08Wh+mQ+ALupjNL
=Z0do
-----END PGP SIGNATURE-----

--------------enigA0EAC8A330CD95694F845421--
