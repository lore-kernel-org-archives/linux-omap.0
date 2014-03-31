From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 00/55]: ARM: OMAP2+: PRCM move to drivers
Date: Mon, 31 Mar 2014 16:10:10 -0500
Message-ID: <20140331211010.GB20499@saruman.home>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39717 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750777AbaCaVMg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Mar 2014 17:12:36 -0400
Content-Disposition: inline
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 31, 2014 at 06:15:39PM +0300, Tero Kristo wrote:
> This set is continuation for the work started earlier to cleanup the CM/P=
RM
> and attempt to make it a separate driver. This set depends on these
> two sets:
>=20
> CM/PRM cleanup set:
> http://marc.info/?l=3Dlinux-omap&m=3D139395000918201&w=3D2
>=20
> OMAP2 clock DT set:
> http://comments.gmane.org/gmane.linux.ports.arm.omap/111257
>=20
> This set is pretty huge but the patches can be applied in stages if need =
be.
> Anyway, it would be good to get some feedback whether the driver folder
> locations etc. are good, and whether the effort taken here will be enough
> to actually move the driver. Clockdomain / powerdomain code can also be
> moved easily under the drivers/power/omap folder (or someplace else if
> requested) once this set is in. Also, clockdomain / powerdomain data
> should be possible to convert to DT format or some sort of firmware
> blob once this is done.
>=20
> Patch #55 in this set is pretty massive as it moves all the C files at
> the same time, this should probably be split up as multiple patches.
>=20
> Testing branch pushed here (contains also the CM/PRM cleanup set and OMAP2
> clock DT conversion):
>=20
> tree: https://github.com/t-kristo/linux-pm.git
> branch: 3.14-rc4-cm-prm-driver-v1
>=20
> Testing done:
> - am335x-bone: boot
> - omap3-beagle: boot, suspend-resume (ret/off)
> - omap4-panda-es: boot, suspend-resume (ret)
> - omap5-uevm: boot

150 randconfigs later, I finally have logs and here are all defconfigs
and stderr outputs of the failures only:

=3D=3D=3D am33xx-multiplatform.config =3D=3D=3D
randconfig0:
	defconfig: http://slexy.org/view/s2zdy5LV9u
	stderr: http://slexy.org/view/s2MDiGoSrx

randconfig1:
	defconfig: http://slexy.org/view/s2IxFfsaxf
	stderr: http://slexy.org/view/s20MnJB0bl

randconfig2:
	defconfig: http://slexy.org/view/s2BzbaASOq
	stderr: http://slexy.org/view/s20S65Pnj4

randconfig3:
	defconfig: http://slexy.org/view/s2Xd8cSZOH
	stderr: http://slexy.org/view/s20mf75wr0

randconfig5:
	defconfig: http://slexy.org/view/s21dZjiy5Z
	stderr: http://slexy.org/view/s2SAabweiD

randconfig6:
	defconfig: http://slexy.org/view/s20f02s9yf
	stderr: http://slexy.org/view/s2AMLLBc2c

randconfig7:
	defconfig: http://slexy.org/view/s21YMC7Fb1
	stderr: http://slexy.org/view/s21VmmcHu8

randconfig8:
	defconfig: http://slexy.org/view/s21NM3It3Z
	stderr: http://slexy.org/view/s2cg5YDZsA

randconfig9:
	defconfig: http://slexy.org/view/s2CqErrueL
	stderr: http://slexy.org/view/s21DCegKXO

=3D=3D=3D am33xx-only.config =3D=3D=3D
randconfig2:
	defconfig: http://slexy.org/view/s26Kuo34pl
	stderr: http://slexy.org/view/s20nQdrBf3

randconfig5:
	defconfig: http://slexy.org/view/s21kLO4EbJ
	stderr: http://slexy.org/view/s2MbA4q1PH

randconfig8:
	defconfig: http://slexy.org/view/s21xUPWCgh
	stderr: http://slexy.org/view/s2Mz889r6V

=3D=3D=3D am43xx-multiplatform.config =3D=3D=3D
randconfig0:
	defconfig: http://slexy.org/view/s20nOHwtyj
	stderr: http://slexy.org/view/s2PgUQG73h

randconfig1:
	defconfig: http://slexy.org/view/s2wBCQM0Wv
	stderr: http://slexy.org/view/s2sXSaLzRf

randconfig2:
	defconfig: http://slexy.org/view/s20JF7tNEv
	stderr: http://slexy.org/view/s2IFi7RDzV

randconfig4:
	defconfig: http://slexy.org/view/s21J5c88u0
	stderr: http://slexy.org/view/s2GuhgkwuI

randconfig5:
	defconfig: http://slexy.org/view/s20vRmugso
	stderr: http://slexy.org/view/s20AfVQszg

randconfig6:
	defconfig: http://slexy.org/view/s2nO7OZd9r
	stderr: http://slexy.org/view/s204vfoBIB

randconfig7:
	defconfig: http://slexy.org/view/s2k8I2YVI1
	stderr: http://slexy.org/view/s2wsGB0ubx

randconfig9:
	defconfig: http://slexy.org/view/s2u5ig7saX
	stderr: http://slexy.org/view/s28rVgHJFo

=3D=3D=3D am43xx-only.config =3D=3D=3D
randconfig0:
	defconfig: http://slexy.org/view/s2OVt1yfgy
	stderr: http://slexy.org/view/s22AU3Ex2p

randconfig1:
	defconfig: http://slexy.org/view/s25Gpu3Kr9
	stderr: http://slexy.org/view/s2uO3TnMDs

randconfig3:
	defconfig: http://slexy.org/view/s2Lf9Q5h9Q
	stderr: http://slexy.org/view/s2CRZMJAR9

randconfig6:
	defconfig: http://slexy.org/view/s21ncdem0O
	stderr: http://slexy.org/view/s20gzGaJcK

randconfig9:
	defconfig: http://slexy.org/view/s2UWL1gFqN
	stderr: http://slexy.org/view/s21S7zXfwh

=3D=3D=3D dra7xx-multiplatform.config =3D=3D=3D
randconfig0:
	defconfig: http://slexy.org/view/s20HNnv3Gf
	stderr: http://slexy.org/view/s21VztibKv

randconfig1:
	defconfig: http://slexy.org/view/s218qJ9E4x
	stderr: http://slexy.org/view/s2V28GPksP

randconfig2:
	defconfig: http://slexy.org/view/s2YcaCyUKS
	stderr: http://slexy.org/view/s20Mgzt8pa

randconfig3:
	defconfig: http://slexy.org/view/s20zE9a4dW
	stderr: http://slexy.org/view/s20Xy7r17N

randconfig4:
	defconfig: http://slexy.org/view/s21CUAW6Yz
	stderr: http://slexy.org/view/s20k6n5Gx8

randconfig5:
	defconfig: http://slexy.org/view/s21cLkzCHp
	stderr: http://slexy.org/view/s21JQfioUs

randconfig6:
	defconfig: http://slexy.org/view/s2EMvORY8U
	stderr: http://slexy.org/view/s20CetADJx

randconfig7:
	defconfig: http://slexy.org/view/s2JO5xHGgM
	stderr: http://slexy.org/view/s21sujleRC

randconfig9:
	defconfig: http://slexy.org/view/s2dz7jgBR4
	stderr: http://slexy.org/view/s20hqcdATY

=3D=3D=3D dra7xx-only.config =3D=3D=3D
randconfig3:
	defconfig: http://slexy.org/view/s20zRk0AZN
	stderr: http://slexy.org/view/s21G5p7LUQ

randconfig7:
	defconfig: http://slexy.org/view/s21FCqxaXM
	stderr: http://slexy.org/view/s278Tbgp9S

randconfig9:
	defconfig: http://slexy.org/view/s20Gfmk6lJ
	stderr: http://slexy.org/view/s20ehb1qwZ

=3D=3D=3D omap1-only.config =3D=3D=3D
randconfig0:
	defconfig: http://slexy.org/view/s2MUvMwOLs
	stderr: http://slexy.org/view/s2qZs1vTxV

randconfig1:
	defconfig: http://slexy.org/view/s27WloNxZM
	stderr: http://slexy.org/view/s2JWSJfmEd

randconfig2:
	defconfig: http://slexy.org/view/s21eKcaLyv
	stderr: http://slexy.org/view/s23rdJn5Z6

randconfig4:
	defconfig: http://slexy.org/view/s2jCoCS6bR
	stderr: http://slexy.org/view/s2BFCNCzGE

randconfig5:
	defconfig: http://slexy.org/view/s26ZOMTjY2
	stderr: http://slexy.org/view/s2tS8X3izE

randconfig7:
	defconfig: http://slexy.org/view/s20mS2BhrM
	stderr: http://slexy.org/view/s21ZhQjmyZ

=3D=3D=3D omap2-multiplatform.config =3D=3D=3D
randconfig0:
	defconfig: http://slexy.org/view/s206lY3Iu9
	stderr: http://slexy.org/view/s2VFufPUrS

randconfig1:
	defconfig: http://slexy.org/view/s2BmE32F7s
	stderr: http://slexy.org/view/s28siuKJgl

randconfig2:
	defconfig: http://slexy.org/view/s21wyH6vtV
	stderr: http://slexy.org/view/s2i5hb6R1s

randconfig3:
	defconfig: http://slexy.org/view/s211ydZ9zL
	stderr: http://slexy.org/view/s2TnjPod0j

randconfig4:
	defconfig: http://slexy.org/view/s2BKoNv98b
	stderr: http://slexy.org/view/s2VLHLTBcK

randconfig5:
	defconfig: http://slexy.org/view/s20TmPmPdE
	stderr: http://slexy.org/view/s2TNOe2h4l

randconfig6:
	defconfig: http://slexy.org/view/s2FFn9nUuj
	stderr: http://slexy.org/view/s2Ox6D9fnC

randconfig7:
	defconfig: http://slexy.org/view/s2CnsemL7b
	stderr: http://slexy.org/view/s206FpFZpJ

randconfig8:
	defconfig: http://slexy.org/view/s24W1I71zh
	stderr: http://slexy.org/view/s20TQftJBb

randconfig9:
	defconfig: http://slexy.org/view/s2I1F7c6TU
	stderr: http://slexy.org/view/s2mKIia8Sv

=3D=3D=3D omap2-only.config =3D=3D=3D
randconfig0:
	defconfig: http://slexy.org/view/s2dotWO9Ql
	stderr: http://slexy.org/view/s20hxmA4vX

randconfig1:
	defconfig: http://slexy.org/view/s2iRumb8dH
	stderr: http://slexy.org/view/s21Fw0XxqU

randconfig3:
	defconfig: http://slexy.org/view/s20QWVWG5i
	stderr: http://slexy.org/view/s21vyg1zop

randconfig4:
	defconfig: http://slexy.org/view/s21mGDCq51
	stderr: http://slexy.org/view/s20TIuj4IX

randconfig6:
	defconfig: http://slexy.org/view/s20sYfiX3d
	stderr: http://slexy.org/view/s20rPoepm3

randconfig7:
	defconfig: http://slexy.org/view/s2nvBuOuxW
	stderr: http://slexy.org/view/s20E0IdY6F

randconfig8:
	defconfig: http://slexy.org/view/s2N76xJ3X9
	stderr: http://slexy.org/view/s21VfZJhHV

randconfig9:
	defconfig: http://slexy.org/view/s2RV36kehk
	stderr: http://slexy.org/view/s2CTWr5Vpb

=3D=3D=3D omap3-multiplatform.config =3D=3D=3D
randconfig0:
	defconfig: http://slexy.org/view/s20VtHyvBH
	stderr: http://slexy.org/view/s2kBg5HvhD

randconfig1:
	defconfig: http://slexy.org/view/s20ypZW2Ko
	stderr: http://slexy.org/view/s21OUz1Xzn

randconfig2:
	defconfig: http://slexy.org/view/s21GjiKHkk
	stderr: http://slexy.org/view/s20asYuGKI

randconfig3:
	defconfig: http://slexy.org/view/s21O5wypd0
	stderr: http://slexy.org/view/s2IkuBLuZP

randconfig4:
	defconfig: http://slexy.org/view/s2ENuvZIYn
	stderr: http://slexy.org/view/s2S9qPIR0A

randconfig5:
	defconfig: http://slexy.org/view/s20nPLMlgQ
	stderr: http://slexy.org/view/s2m4JwHSM8

randconfig6:
	defconfig: http://slexy.org/view/s2DGcTkHkC
	stderr: http://slexy.org/view/s20AspBOww

randconfig7:
	defconfig: http://slexy.org/view/s20kCMwUU7
	stderr: http://slexy.org/view/s2z6D9QvQJ

randconfig8:
	defconfig: http://slexy.org/view/s20I1AOSQk
	stderr: http://slexy.org/view/s2q01zO9Iy

randconfig9:
	defconfig: http://slexy.org/view/s204fkNHxb
	stderr: http://slexy.org/view/s21qriyPF3

=3D=3D=3D omap3-only.config =3D=3D=3D
randconfig0:
	defconfig: http://slexy.org/view/s2abbP39Uk
	stderr: http://slexy.org/view/s29usoI8Nl

randconfig1:
	defconfig: http://slexy.org/view/s204hCXm6K
	stderr: http://slexy.org/view/s2kNZV9uAp

randconfig3:
	defconfig: http://slexy.org/view/s20vqEhTiO
	stderr: http://slexy.org/view/s205S2pZNA

randconfig6:
	defconfig: http://slexy.org/view/s20TycQLjY
	stderr: http://slexy.org/view/s20HC7hhns

randconfig7:
	defconfig: http://slexy.org/view/s2aw70jjPn
	stderr: http://slexy.org/view/s20isfqiL2

randconfig9:
	defconfig: http://slexy.org/view/s2MZFMURBn
	stderr: http://slexy.org/view/s2XoYqLhu9

=3D=3D=3D omap4-multiplatform.config =3D=3D=3D
randconfig0:
	defconfig: http://slexy.org/view/s2vidWfwTH
	stderr: http://slexy.org/view/s2HTOgfMmF

randconfig1:
	defconfig: http://slexy.org/view/s2Dt05nhkT
	stderr: http://slexy.org/view/s2Gj8YvAVs

randconfig2:
	defconfig: http://slexy.org/view/s25AhJw365
	stderr: http://slexy.org/view/s20beEPCwC

randconfig3:
	defconfig: http://slexy.org/view/s2dewbdjz7
	stderr: http://slexy.org/view/s20HGxzWpE

randconfig4:
	defconfig: http://slexy.org/view/s21WJUmCW0
	stderr: http://slexy.org/view/s2LRgFFbGA

randconfig5:
	defconfig: http://slexy.org/view/s2xGTl58jP
	stderr: http://slexy.org/view/s21aJCo6xK

randconfig6:
	defconfig: http://slexy.org/view/s20lpLX6Lu
	stderr: http://slexy.org/view/s21a4HxCyS

randconfig7:
	defconfig: http://slexy.org/view/s21AT1lTJf
	stderr: http://slexy.org/view/s21FaPb3xR

randconfig8:
	defconfig: http://slexy.org/view/s2CgY5DQQG
	stderr: http://slexy.org/view/s25VUF6wMD

randconfig9:
	defconfig: http://slexy.org/view/s2QiYHO40h
	stderr: http://slexy.org/view/s2t2wYKX0q

=3D=3D=3D omap4-only.config =3D=3D=3D
randconfig1:
	defconfig: http://slexy.org/view/s21qSK8EGJ
	stderr: http://slexy.org/view/s21srzKlAT

randconfig3:
	defconfig: http://slexy.org/view/s20QbcE067
	stderr: http://slexy.org/view/s27LksMVGl

randconfig5:
	defconfig: http://slexy.org/view/s21S8MLzbl
	stderr: http://slexy.org/view/s26IKp0DOJ

randconfig7:
	defconfig: http://slexy.org/view/s28VWw4Oh2
	stderr: http://slexy.org/view/s20RGLZjqY

randconfig8:
	defconfig: http://slexy.org/view/s2vwTsPqZa
	stderr: http://slexy.org/view/s21G96fSWU

=3D=3D=3D omap5-multiplatform.config =3D=3D=3D
randconfig0:
	defconfig: http://slexy.org/view/s20Bamou4U
	stderr: http://slexy.org/view/s208AsoX7s

randconfig1:
	defconfig: http://slexy.org/view/s21XKs3Q5G
	stderr: http://slexy.org/view/s21gtUSLml

randconfig2:
	defconfig: http://slexy.org/view/s2wvw3iOkG
	stderr: http://slexy.org/view/s208uF3SGG

randconfig3:
	defconfig: http://slexy.org/view/s2fagfl6tb
	stderr: http://slexy.org/view/s21YdRf46l

randconfig4:
	defconfig: http://slexy.org/view/s20eitFSpQ
	stderr: http://slexy.org/view/s21NNgKKun

randconfig5:
	defconfig: http://slexy.org/view/s2vmxZxslV
	stderr: http://slexy.org/view/s20u5IlZIL

randconfig6:
	defconfig: http://slexy.org/view/s23ba5vjtP
	stderr: http://slexy.org/view/s20KHhbgjO

randconfig7:
	defconfig: http://slexy.org/view/s2AiHp902I
	stderr: http://slexy.org/view/s2d2LK0QDi

randconfig8:
	defconfig: http://slexy.org/view/s2U1JNwOcK
	stderr: http://slexy.org/view/s2ftX1ECVO

randconfig9:
	defconfig: http://slexy.org/view/s2fqXgF0tG
	stderr: http://slexy.org/view/s21HrxjCq1

=3D=3D=3D omap5-only.config =3D=3D=3D
randconfig0:
	defconfig: http://slexy.org/view/s2hS1gplYB
	stderr: http://slexy.org/view/s20Zjhtbyz

randconfig2:
	defconfig: http://slexy.org/view/s2XMMPIHmK
	stderr: http://slexy.org/view/s22fG8VCFk

randconfig3:
	defconfig: http://slexy.org/view/s2LSrPTIho
	stderr: http://slexy.org/view/s20Zzv2Jb5

randconfig8:
	defconfig: http://slexy.org/view/s20ftaOa2H
	stderr: http://slexy.org/view/s21JmD1FZ3


--=20
balbi

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTOdmyAAoJEIaOsuA1yqREyZoP/1XIZOGiIBnqshKBi35VuM1o
rmD6jZRbbQGQn0QODjUOotk8EcNSCxyanlQwqX9mp9UqVLwMwsLJc8rwXu4dpiNZ
FibztGMJZgMmppUEY1u8Gvx4R6Qe2MO0Vi01/QYboxep/5EFRhBFb+KncXvV48On
ittPyWVlX5+WpIWXTILWmGZ1sUazYKiWZ8MNfqmqcDfJX5S1q/if9okpW6Nisoov
ydv5NUAXJa5Z99xPWoRI63Kknpdfn7iycY25rKslgzCmQvkKhVayPhXE7qfBkW0o
BACipEeCb3fzNzEsF57gYTq5fwRanVpsk2kA2UTnDaMOr+/fNsHrfOLdQxDRN/e2
/Lf1msFOlmdf0VcUAUpLzgs9LeNb7MwJDqks3H18Iixkr1ibahyHMbX8mfpoXalo
sJYd2RUpKdjCBd0/ljj9QjSY58js6X4gkrrXDTpEHfyiyjH7ZBrukiGBavxld2EF
ayD+a1tYws+3GjZWZOAl3wqEe4SUe5Aofj99CnlwXx5z5Ys7kc2L5bzMg9y8pIeN
UhhlEYuTEJEwpu4PF+7k8RLl5otrVeNWzLNy0Zd+dfrNa8hxbh6B27i16W+g6Oof
su6jRagHde0v/5Bmi3d88tnQj5lpuHDOUbLiQti8SiBC95yAKr5Dz45CSorYzgSc
SVH8mh1TJTL/QxNF42xR
=Y/n4
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--
