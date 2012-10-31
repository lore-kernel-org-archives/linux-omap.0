From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 01/12] OMAPFB: remove use of extended edid block
Date: Wed, 31 Oct 2012 08:23:11 +0200
Message-ID: <5090C3CF.2040004@ti.com>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com> <1351613409-21186-2-git-send-email-tomi.valkeinen@ti.com> <5090C0CD.7070104@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE284BED85DB8D526C84E1F71"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40349 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752817Ab2JaGXR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Oct 2012 02:23:17 -0400
In-Reply-To: <5090C0CD.7070104@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com

--------------enigE284BED85DB8D526C84E1F71
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-10-31 08:10, Archit Taneja wrote:
> On Tuesday 30 October 2012 09:39 PM, Tomi Valkeinen wrote:
>> It seems that using the second EDID block causes more problems than is=

>> of any help. The first mode in the extended block will get
>> FB_MODE_IS_FIRST set, which will override the first mode from the firs=
t
>> EDID block, thus making the default videomode selection not to work
>> properly.
>>
>> This patch removes the use of the extended edid block for now.
>=20
> Looks like you had posted this one(and also the next one)in the previou=
s
> cleanup/fixes series also.

Ah, so I did. Too many work branches =3D). Thanks for pointing it out.

 Tomi




--------------enigE284BED85DB8D526C84E1F71
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQkMPTAAoJEPo9qoy8lh71StgP/1pWCixgvgElMIo18axKKgH9
gF+meYjnnpd74VSoDPYHkhzI9CbDtZuv4SBSoaGlJyZ/GmotCW08whZOnRDzNILG
4hnX1ZEVfeWprwLhXIXsq7q9wVdwww4AWX0GvCVPF/BfQy8yhQyGe5Sn1r7Zz2zI
uh/HrRVy58y5wSKKptIwAMiyqkE/Y1tLuvfyIrPqe62LfBGJcGsvf7v86Bj6zk+F
fF0I3RpC0R/waiEgRJrKqQS/pf/7P6bST3tQ51LgMPsn6eja7L9uDoyW2Hm3nmfX
JJz7gPM2Q6sWBX5Fo6vHIN+JzN/i13GDELHb3pMIEAdjzTaJAC6pc+YJ5/WjJF8D
WBAJkaE7/APDdwcZ91/SFSMNG1N54skiBZXAhm6Jm5p5AOPYkxzRSiVVmlhsCd3D
wH3oF7CU69S6PfvUina7VpGvD+ve1OxyNofGK5qYls512SNJ8Xh4F3EeSY9lKHoW
45yNaydSEkO8M9vpKzVFUKgmdF5bqvs0VsjHlnj0UOI+98aHfwZQFPCzAnozAvh1
FAHf0cM0U635Qj4AlEeKEC2KGgdcPoSq81/lOMAIQVC/Ee4T/FXY4Yu9jAJ6GkDv
2SYC0aZJGdSKGNPfIO16FSouPZqItX3rjNuprPu/AufrazX9Uh/Jfgm0IEZXSgV1
nsagogOpbmtC2+hT28NH
=VRSb
-----END PGP SIGNATURE-----

--------------enigE284BED85DB8D526C84E1F71--
