From: Sebastian Reichel <sre@kernel.org>
Subject: Re: ARM errata 430973 on multi platform kernels (was: OMAP3-N900:
 Add microphone bias voltages)
Date: Sun, 5 Apr 2015 15:00:45 +0200
Message-ID: <20150405130045.GB9186@earth>
References: <1425236828-28349-1-git-send-email-jarkko.nikula@bitmer.com>
 <55197A12.1050009@bitmer.com>
 <20150330164237.GJ10805@atomide.com>
 <55198BA4.5010207@bitmer.com>
 <20150330175051.GK10805@atomide.com>
 <20150331123233.GA15103@earth>
 <20150401194734.GT10805@atomide.com>
 <20150403163553.GA16247@earth>
 <20150403183942.GV10805@atomide.com>
 <CAOCHtYjCtmJNrkD0x78bm9b7hNvTKsZD2C2m5N=nR7p73R4zcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37603 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320AbbDENBQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 5 Apr 2015 09:01:16 -0400
Content-Disposition: inline
In-Reply-To: <CAOCHtYjCtmJNrkD0x78bm9b7hNvTKsZD2C2m5N=nR7p73R4zcg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Nelson <robertcnelson@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 03, 2015 at 02:21:48PM -0500, Robert Nelson wrote:
> >> And yes, for armhf userland one gets random oopses at least on the
> >> Nokia N900. AFAIK this is not true for all ARMv7 processors
> >> (especially non omaps), though.
> >>
> >> > http://www.spinics.net/lists/linux-omap/msg108511.html
> >> >
> >> > See also 5c86c5339c56 ("ARM: omap2plus_defconfig: Enable ARM erratum
> >> > 430973 for omap3").
> >>
> >> For me the random oopses occur without this config flag and are
> >> fixed by it. The workaround is not very suitable for multi platform
> >> kernels, though, since its enabled also for unaffected platforms.
> >>
> >> As far as I can see the CONFIG_ARM_ERRATA_430973 flag is checked
> >> in proc-v7.S and in proc-v7-2level.S. I think the first file is
> >> irrelevant, since it can be fixed later (see workaround in
> >> nokia_n900_legacy_init in pdata-quirks.c).
> >
> > Yes so it seems, and the bootloaders should really set it. It's
> > also disabled for multiplatform builds.
>=20
> These are now done in u-boot as of: v2015.04-rc4
>=20
> http://git.denx.de/?p=3Du-boot.git;a=3Dcommit;h=3Dc6f90e1418a84fe5fa463b3=
8403bd1845cb6a59c

Seems like "include/configs/nokia_rx51.h" has been forgotten. Note,
that the kernel must still be able to enable the bit itself (in case
NOLO is used without u-boot).

-- Sebastian

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVITH4AAoJENju1/PIO/qasyEQAKWthjmiiVMom6bRj4WEZ5qx
oK/eniMLl6geoc4Dm0q1NOrOFPAqXN639sq09gYJh+SMBhigMz/0Z1pUaeUj6SS1
iruxN4arWkS9GHhHgEwRvwvvARuYT1wlX22D3p9N+HUAHiAYN5ExWYrBIWc9X5mh
+JIhVTRzXPbpDDaXnNG1Hw4KiqvmmnIBHFoecqdAnnnZoHGZk0yqmvRNVtLitYv+
Q4eA/5w2kSQrbPKp14Ai5NEEt44Prj/xUSGCJcF3bsmtnIqGmobiL7BYOpGq0VlB
pdo968ZU61jX/xlngsIzG4FH3xw355gjeMdSfGMLMc8qaLjnQoGPOLjtiHpBL8Qc
6kiPEeQN5O2SYC+oEfo5LYepiFHVgr33fisoC2M1Y0R9EVq7DlzTQtlJOk2DBPTQ
A3Ix5v8gLDIeDYAjaHNJHt0Shs+9YDa37ZuFe6fDtCHqNxjLPGL2LUyqgnG4mhwo
glOTXPISw38GywG98dSQg8dkaXEPjau+5X6X3Vh8K2z1Xj992Lsd96ybVrW9V2lV
SRR1mS7R/3yPC/j/uVth3VU6c/Fhcxqy+0qioeCJc/Oq4F0hQiWnChoBgIQcvsKV
r4blzD5EH2B/EUCIKJug9o3b9h7zy/cMz7+YyA6Ca83EK+42RjgnU+Y7y9caLVPg
PJO0VWBCuE7mzAnR7Yoh
=ZnRq
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
