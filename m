From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv3 0/5] OMAP: VRFB: convert to platform device
Date: Thu, 18 Oct 2012 15:45:26 +0300
Message-ID: <507FF9E6.6010509@ti.com>
References: <1350469102-24888-1-git-send-email-tomi.valkeinen@ti.com> <507E87B7.3070707@ti.com> <20121017182926.GW15569@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF5423CF0E1F8212AAA6478ED"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52034 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755015Ab2JRMpd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Oct 2012 08:45:33 -0400
In-Reply-To: <20121017182926.GW15569@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com

--------------enigF5423CF0E1F8212AAA6478ED
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-10-17 21:29, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [121017 03:27]:
>> Hi Tony,
>>
>> I have pushed this vrfb series and the omapdss version series to:
>>
>> git://gitorious.org/linux-omap-dss2/linux.git 3.8/dss-version
>=20
> I used this branch up to commit 35f70935c64ae229ebd1fc65398ec68d4d80371=
2,
> but left out the x86 compile changes as those seem unrelated to the pla=
t
> issue.

Ok, you're right.

>> git://gitorious.org/linux-omap-dss2/linux.git 3.8/vrfb-conversion
>=20
> And then I merged in this branch. I have the merged branch at
> omap-for-v3.8/cleanup-headers-dss.

Ok.

>> If they look ok to you and we don't get any other comments, I think
>> these branches can be considered stable and you can pull them.
>=20
> Thanks yes let's consider those frozen and if something needs to
> be fixed it should be done on top of those commits.
> =20
>> After these are merged:
>>
>> $ git grep -E "(plat/)|(mach/)" drivers/video/omap2/
>> drivers/video/omap2/omapfb/omapfb-ioctl.c:#include <plat/vram.h>
>> drivers/video/omap2/omapfb/omapfb-main.c:#include <plat/vram.h>
>> drivers/video/omap2/vram.c:#include <plat/vram.h>
>>
>> So the vram stuff should be the only omap dependency left in omapdss a=
nd
>> omapfb. I'll start working on that soon.
>=20
> OK thanks a lot. Then there's also the two vout files that
> you may already have patches for:
>=20
> drivers/media/platform/omap/omap_vout.c
> drivers/media/platform/omap/omap_voutlib.c

No yet. I hope I find time for those at some point soon =3D).

 Tomi



--------------enigF5423CF0E1F8212AAA6478ED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQf/nmAAoJEPo9qoy8lh71uXUP+wTYlrjimklHUYci6H2BNam4
JEvoFucJALQ4Uh4k82fMRHglqk7MkH6NHC3c5Y02sSstZ/KcpcsBkGRAnj18B79A
0PpPwNZfvBlgXiB2o0sBvQW3QPI5JuxWPu/CXshQRSyPqYIuyXmY43vGoictTcXa
vKHKBZrjwVzJz+r2rnlm66zq+fVM8OW9rqenAW23iwdn7E+aAqCXrS3x4JdZkB9H
7BiCvQdtRTV98co2KB85yJbxkhIsxAqbY0yFgReBMFJ+7LGeMNahWbfVZPAdwBiV
NI3ndIJpJINs3KlQWkrfbqbI/WLZpNa9keIxqjU8eCZbjYf7GXkCsnsSHFK4kSFY
A+cwkm7FJJrvK6WPjhgXqYTf4Vgnf3DI+rlZ2R9TzsBk8n7YktLfajJSLncnPE3i
DW6ZfNvzftWnZdOGilTib1sOb510HIx4MFEPYeictXi3/0iWhsMqy/Se3wja4dAf
YaJ3NkVOx8j6fJ0V80J871VYik2VTWsFAJPuhPaWS/G29x/+t9igyeqnBuLI3WyF
BizIius+RG1v3tRlE0DQVn5XpdLOaZKGsdS9oWKFylkY3P2sN3fBDNq/kok6bEjN
ZgEGLSdryfItoVxe2nAP5Sdh1HaQzJrDs3zI5EP6IgXgsbCH9sBFVyjmUPz3Z4x8
ONTcCZTLNp/y6O/IMKls
=3ZTM
-----END PGP SIGNATURE-----

--------------enigF5423CF0E1F8212AAA6478ED--
