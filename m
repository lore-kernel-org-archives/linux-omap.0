From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 0/2] ARM: dts: AM4372: Add more nodes
Date: Thu, 10 Oct 2013 14:18:17 -0500
Message-ID: <20131010191817.GJ21240@radagast>
References: <1381432494-20498-1-git-send-email-lokeshvutla@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OX7PPUk8qMPP4++R"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51823 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896Ab3JJTS6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Oct 2013 15:18:58 -0400
Content-Disposition: inline
In-Reply-To: <1381432494-20498-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, mugunthanvnm@ti.com, sourav.poddar@ti.com, linux@arm.linux.org.uk, akpm@linux-foundation.org, rnayak@ti.com, afzal@ti.com, nsekhar@ti.com, r.sricharan@ti.com, balajitk@ti.com, balbi@ti.com

--OX7PPUk8qMPP4++R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 11, 2013 at 12:44:52AM +0530, Lokesh Vutla wrote:
> This patch series add nodes for l2-cache-controller, EDMA, mailbox,
> mmc, sham, and updates the properties for cpsw, i2c0, matrix-keypad.=20
>=20
> These patches are applied on top of Benoit's for_3.13/dts branch
> git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git =
for_3.13/dts
>=20
> Testing:
> Tested EDMA, mmc, sham, aes, des, i2c0, cpsw, matric-keypad on AM4372 EPO=
S EVM
> with the addition of following two series:
> -> Tero's V8 of OMAP DT clock conversion
>   http://www.mail-archive.com/linux-omap@vger.kernel.org/msg96769.html
> -> Afzal's V5 of AM43x PRCM basic support
>   http://www.mail-archive.com/linux-omap@vger.kernel.org/msg96275.html

one extra piece of info:

all these patches are fresh out of Wakeup, tested on top of v3.12-rc3.

--=20
balbi

--OX7PPUk8qMPP4++R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSVv15AAoJEIaOsuA1yqREGKUP/RqrumkwFY225CCS3NSuWfQH
8z7r3cF+4Q9Ym64e2l2hnkM1F23Y+t4SGBH1tQE70y4NZnST3kKmKGaC7Z5wNY2g
Q9PuyX7nEaxY8YK9OPU9dsQBkbYiawi81/a4acN8ELwhfL5YmYUthjMsInOuWs5L
+RfbDVR42M6dvsbx5u8dpZfG/sqVB2kokVv++U/8b+vwxSydpaSm+7oljOFucuzD
dHfupHZWmDkdP3yfLPICHCvf+5ByuJ/ny0hPAp3vPjkiVbgesorEccUKeSEEyXL0
+UzaxToaUM58fXqfqE23K9YygcffEXCYWRpKOlsNj++u+TW9/HK+L4hgy7p0zURJ
aKpfmwlz3nEHFEOrBAzvYX8g1g7DPE60wb0/uGZFSzKmV/Su0jnZnMooFsIgvsKM
N940R244fUnCs1DSj2Doxe/I7f+J6FSOkmY0obKANtUW+20g3TbLi4BMAeNtYLqr
nqm7fq75Bwzk9paHtvRrB5HscX6Xc6GhSc/WW5M+OtCP0ykiNOx0UclRQiuTlaXl
jaAPLPGFj+Jekjw0iFi8sl4AXqNAhR225fIhmPDQi/lc+kQqDA5GTzUsoMtk9eZw
/5wx8EMg67bGmlwnLDZGcas6CiccxG/mvEKn4KG0OHXfcV66DEL5OwFVw+7s3glp
xYd/opsqDQrQm2ef19in
=XrFj
-----END PGP SIGNATURE-----

--OX7PPUk8qMPP4++R--
