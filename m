From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/3] OMAPDSS: HDMI: Add support for audio MCLK
Date: Tue, 14 Feb 2012 14:27:59 +0200
Message-ID: <1329222479.1845.86.camel@deskari>
References: <1328757023-20543-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-vVEkCvXz3E9DOo8EZDRf"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:46057 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753611Ab2BNM2D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Feb 2012 07:28:03 -0500
Received: by mail-lpp01m010-f53.google.com with SMTP id d3so5318486lah.12
        for <linux-omap@vger.kernel.org>; Tue, 14 Feb 2012 04:28:01 -0800 (PST)
In-Reply-To: <1328757023-20543-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: mythripk@ti.com, a0393947@ti.com, molnar@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, linux-omap@vger.kernel.org


--=-vVEkCvXz3E9DOo8EZDRf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2012-02-08 at 21:10 -0600, Ricardo Neri wrote:
> Hello,
>=20
> Certain OMAP4 revisions (i.e., 4430 ES2.3, 4460, and 4470) use
> a pseudo clock (generated from the TMDS clock), MCLK, to drive the
> generation of Audio Clock Regeneration packets. Other devices
> (i.e., 4430 ES2.[0,2]) use the TMDS clock directly.=20
>=20
> This set of patches introduces functionality to enable the MCLK on the
> relevant devices. Such clock is added as new DSS feature. The dss_feature=
s
> structures are rearranged to reflect the MCLK support across several
> silicon revisions.
>=20
> These patches have been validated on OMAP 4430 ES2.2 and ES2.3 as well as
> on 4460 ES1.0. The HDMI sinks used for validation are monitor Dell ST2210=
b,
> AV receiver Onkyo TX-SR508 and AV receiver Yamaha RX-V367. Audio playback
> is functional in all of them.

One question just to be sure: are you sure this clocking difference is
based on OMAP revision, and has nothing to do with the board?

I think this looks fine. However, it doesn't apply as the dss feat stuff
has been changed. Could you rebase the patches on top of

git://gitorious.org/linux-omap-dss2/linux.git dev

 Tomi


--=-vVEkCvXz3E9DOo8EZDRf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPOlNPAAoJEPo9qoy8lh71mrYP/i5OBsM17BHpnliUDt92tSaB
xsrrrBVw3x/Qjnov7Jv4nPYdoKPtl+YaeMGhcEqA0GQbK7scRwkfb0Cv+Mgsfz5v
VUhPAJfhLEHDJ52OgcyjFYdvrjpsRgle5Kd6SRC2S7cX3Atntj1Fc/W7zEehvn0d
1YztAFvt2bIrlVU6aj1A+n8C7BTGz/DxVigOFmbVuHKVczmSASm0EpnXjid/1lzx
D2pUtiPUlhRBp/P1Pw29Mcv0gbLTZ2PnIqs67F4Jr8GsbjF5roFZkW7iMtp87DKb
IJKZG//GBpE0GjxAxi9UCvdb056SztfnghEuTefakf3LJIkagIy/Ztqib7okTUlj
03JQm9Pxe6+IE/PN8nkurVB2uqpygPfL4VJ/xw5Gdn72cPImY0VJ0egRkQE0TDY4
T1G02oxhhuPiU102L1tVmi3fW1jNlirFdZJF/zuMOtjvUt53owqkpOQlS2WgIKBy
qautHTYyCS9kSZmdX8JWCqS+7IAaSEPo82Cig+CUUqSXT6dDVpob5EhzTLvG8cKT
uy5FrDOrd1BjNftU1G6sQrbQ3gcjZvm+4NYI2if5Qvda4UEnkJpoN+Tecc2x7lWd
w1VZxZ468BmCms9ADSiPw+/mJy0Um1OppSmfkbT4VgEZf1bT6oMZm8Sr0wBP7RY7
BVBF76KEmcqmrIwy/24N
=ZdXm
-----END PGP SIGNATURE-----

--=-vVEkCvXz3E9DOo8EZDRf--

