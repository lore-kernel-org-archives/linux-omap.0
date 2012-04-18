From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] ARM: OMAP: Revert "ARM: OMAP: ctrl: Fix CONTROL_DSIPHY
 register fields"
Date: Wed, 18 Apr 2012 11:06:26 +0300
Message-ID: <1334736386.1886.8.camel@deskari>
References: <1333955479-2675-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-cr71e4OkXDD/lygAtl8l"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:34729 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751062Ab2DRIGc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Apr 2012 04:06:32 -0400
Received: by lahi5 with SMTP id i5so6823907lah.11
        for <linux-omap@vger.kernel.org>; Wed, 18 Apr 2012 01:06:29 -0700 (PDT)
In-Reply-To: <1333955479-2675-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux@arm.linux.org.uk, tony@atomide.com, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, paul@pwsan.com, b-cousson@ti.com


--=-cr71e4OkXDD/lygAtl8l
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 2012-04-09 at 12:41 +0530, Archit Taneja wrote:
> This reverts commit 46f8c3c7e95c0d30d95911e7975ddc4f93b3e237.
>=20
> The commit above swapped the DSI1_PPID and DSI2_PPID register fields in
> CONTROL_DSIPHY to be in sync with the newer public OMAP TRMs(after versio=
n V).
>=20
> With this commit, contention errors were reported on DSI lanes some OMAP4=
 SDPs.
> After probing the DSI lanes on OMAP4 SDP, it was seen that setting bits i=
n the
> DSI2_PPID field was pulling up voltage on DSI1 lanes, and DSI1_PPID field=
 was
> pulling up voltage on DSI2 lanes.
>=20
> This proves that the current version of OMAP4 TRM is incorrect, swap the
> position of register fields according to the older TRM versions as they w=
ere
> correct.

Are we sure the bits are the same for all OMAP4 versions? I'm just
wondering why the change was made to TRM...

 Tomi


--=-cr71e4OkXDD/lygAtl8l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPjnYCAAoJEPo9qoy8lh71pPMP/0n+4ifvPjYp/8UDSV7BP17r
E1q/z4jX1GfamRLV6gC4b7kVzwdF7eG+3d5emJXxSkb8boPzKhb29mBJAf+i5dgE
ylEknTyrD+qOY2h9h+JenTjsdpvqonWZPu1dqG1wfMXyyn1es+/Ufhml6/QQyWli
NxABjvsCI15E/C7u+HB4bDxe42YQS7T7fM3cJMLu/CjdB4+bwp0/aARrYFfZW0BF
ntXs5zVUPQDEkfCzzDC9feolEI4dbl3YNq3MkmB4WcIG0JsHLibrTjoR5Bocx6Hv
c3yk1ZVCCsr2bnroYEggZtbme9y8oD5uOyfDWniORj0H8QHx8W9dqlCWOee/qWd7
QWjMeopVvRFA3h3xLFYc18zLasc49Uh3oS/HSTLG73JcKV1JSm/SedRDaAkhdnha
tPTNe7h3JhbftzMb5VhK00zXWJqqCUt/66t6Hv7f9S8cU1q/xSlN55m2NTXW2FEQ
Q8TUJcAmKXgIi+t72wuOF+5XuHgGYtSn5UBHt7vyMz3aViaP/CQxmeIy3LRxFhDn
pk6Lf9aZ76R9zTEdSLMjh1wGKcydfMefPX3bVS2LupNj2lhFesPJuwof84NJ6kdg
bOYlssEVD/AEeWh3PcC2RazOPWWTlCgE2synKAxsKfAfc0G3jNtjXYG4UFvCVVxs
5Z9sH26pqiWPIwZHBiDK
=e49E
-----END PGP SIGNATURE-----

--=-cr71e4OkXDD/lygAtl8l--

