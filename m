From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Display related board specific boot args
Date: Fri, 22 Mar 2013 17:29:59 +0200
Message-ID: <514C78F7.5050906@ti.com>
References: <514C1599.7080803@ti.com> <20130322151838.GB25575@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5D3DE6B1508D12415F439A5F"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47745 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932548Ab3CVPaC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Mar 2013 11:30:02 -0400
In-Reply-To: <20130322151838.GB25575@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

--------------enig5D3DE6B1508D12415F439A5F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-22 17:18, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [130322 01:30]:
>> Hi Tony,
>>
>> As you probably know, Overo is a very basic omap board to which you ca=
n
>> attach different add-on modules, like LCD module. In the current overo=

>> board file we always add multiple LCD devices, of which the user shoul=
d
>> only use one (the one on his module). This model of allowing multiple
>> LCD devices on the same video bus is causing headaches in the dss land=
,
>> and I'm removing support for it.
>=20
> OK yes sounds like they should be all selectable, and only the selected=

> one gets initialized.
> =20
>> So what we should do is add only the LCD device that you actually have=

>> attached. With DT this will probably be handled with separate dts file=
s,
>> depending on the add-on module.
>>
>> How should this be handled with board files? Is it ok to add a board
>> specific kernel boot argument, parsed in the board file, which tells t=
he
>> add-on board?
>=20
> At this point I'd stay away adding any kind of custom handling to the
> board-*.c files as that will make the task of removing them harder. And=

> a kernel boot argument is something we'd have to support in the future.=

> So if something gets added, it should be a Linux generic boot argument.=

>=20
> Some of these add on boards can be detected over i2c, but it seems as
> DT is the way to go in the long run in this case.
> =20
>> We have similar situation in some other boards also.
>=20
> Yeah. There's the capebus coming that might even allow hotplugging
> some of these add on boards eventually.
>=20
> How about just make PANEL_LGPHILIPS_LB035Q02 depends on !PANEL_XYZ_DPI
> in drivers/video/omap2/displays/Kconfig and add some comments for now?
>=20
> That way people can still select LB035Q02 but not for generic
> configurations.

Well, I don't want to disable a panel driver totally because of one
board. And it's more complex than that. For overo we have three displays
on the same DPI bus (using the names assigned in the board file): dvi,
lcd43, lcd35. So even if the LB035Q02 would be disabled, we have dvi and
lcd43 which conflict.

I also would stay away from custom boot args. So I guess that leaves us
only the compile time option. Either so that the overo board-file needs
to be modified by the user to change the add-on board, or a Kconfig
option to select the add-on board under "TI OMAP2/3/4 Specific Features"
menu.

Would the Kconfig option be acceptable?

 Tomi



--------------enig5D3DE6B1508D12415F439A5F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRTHj3AAoJEPo9qoy8lh71EGUQAIcUnhkdZokKHTp98THjgtoL
xspfPTFhA+HtsSx9k/x1ekfFB+voQzaEJxhr4SAUzQGcIyNEdViKYV/aUMHfDgfC
NHCmYldR05tePfOK0YiTyokZ/oSKPc2k/1WB+rb2VVmCXgiQ31bza0y5mCnNICmS
OaPJseHYTQTkpOOi00A0ilpDn3zeoU3pYcMAV2Amkv+vK//yucFlBq2fKadgvtLC
+c1Bj7IomykoL6dSFM1jiTyvqFkK4Zo4USmogXJYpioNM1zTEqi6FSO9Qjg1jeQE
v9MMWi7jjf1NxIU6xCSHsISLYbO8ZjPAebsMYYlbZFBfEgnZE3shsTBWRGOligMu
qMicpt9TXO8lk/P0dbsHH2tdshZRKMoWWmllkagUu0musPXYI+EK5TVzc8jP3nPQ
NcPl+M50aMlMQPVhUKHlQ+jIlshce7hWo4g0P1saV5fMS/u290R6E5uqeMgn1NKn
cSAzqUQ9PaZl7skdMMx7LYJ/XHn8Y86jzgcP8k3tEZF8Vps2Z4w4LEMRyYaKqqn/
W89FGp8U9PpaJmGMOImBbLi1xoC3Jv8tt+yQt05Ee1xsarZ3lv7W7OsvGKEHuI/K
NIQyFF1XQOlPfkujNwK6oD53+ijApS/T3blzJagyySZzXImWmgjK6N3yzfblt+a4
r5XxsDNkz/x2g2lh3SbJ
=hrGj
-----END PGP SIGNATURE-----

--------------enig5D3DE6B1508D12415F439A5F--
