From: Felipe Balbi <balbi@ti.com>
Subject: Re: PM related performance degradation on OMAP3
Date: Fri, 13 Apr 2012 12:13:39 +0300
Message-ID: <20120413091338.GP4343@arwen.pp.htv.fi>
References: <CANOLnOP5gq4Vtt00SgRNW-3GZDWk0sukBgJx4V6rkMLL+b6G-w@mail.gmail.com>
 <4F859C5D.3090400@mlbassoc.com>
 <87hawqt6vt.fsf@ti.com>
 <4F86B227.90802@mlbassoc.com>
 <87aa2hjavi.fsf@ti.com>
 <4F86F4B2.3080101@mlbassoc.com>
 <87aa2ganwj.fsf@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vzUQzca511KWT6Hk"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:56053 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932720Ab2DMJOc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Apr 2012 05:14:32 -0400
Received: by lagv3 with SMTP id v3so3724116lag.27
        for <linux-omap@vger.kernel.org>; Fri, 13 Apr 2012 02:14:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87aa2ganwj.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Gary Thomas <gary@mlbassoc.com>, Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>, Govindraj Raja <govindraj.raja@ti.com>, Keshava Munegowda <keshava_mgowda@ti.com>


--vzUQzca511KWT6Hk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 12, 2012 at 09:57:32AM -0700, Kevin Hilman wrote:
> +Felipe for EHCI question
>=20
> Gary Thomas <gary@mlbassoc.com> writes:
>=20
> [...]
>=20
> > This worked a treat, thanks.  My network performance is better
> > now, but still not what it was.  The same TFTP transfer now takes
> > 71 seconds, so about 50% slower than on the 3.0 kernel.  Applying the
> > second [unnamed] patch (arch/arm/mach-omap2/cpuidle34xx.c) made no diff=
erence.
>=20
> And does a CONFIG_PM=3Dn kernel get you back to your v3.0 performance?
>=20
> > I am interested in having PM working as I'm designing a battery powered
> > portable unit, so I need to keep pursuing this.
>=20
> So do I. :)

we all are :-p

> > Note: I noticed that when I built with CONFIG_PM off and no other
> > changes, my EHCI USB didn't work properly.  Should this be the case?
>=20
> Probably not, but haven't tested EHCI USB.  I've Cc'd Felipe to see if
> he has any ideas why EHCI wouldn't work with CONFIG_PM=3Dn.

Govind, Keshava... can you look into this at some point next week ? Or
maybe give us a good reason why it doesn't work without PM ;-)

--=20
balbi

--vzUQzca511KWT6Hk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPh+5CAAoJEIaOsuA1yqREsFcP/jhizFoobEjCQkpPZuCYKLey
znDqbKCfFJFAEhsxUvWwOk6KY26We5x5WGp9KZKM85bJx4bjyTuT/DMXbiiILaLV
XicB0Y0s6QotR/+u6AaSSAQStHeYkHe1IvA9ivt/yH0f/VxF900npQ6HoXjA4NdD
StJCFCCPAJ8Kb3RDr1wVAhX7vclzRJvgRwiqRXVROgi/xgqRx2jeDNJ1UAHWD9d4
UiC2IEPdNXW/UMKPkEPKANjumgAByHCrhXZjZb5FcSD4bCyaFR9fYO0d5b4KDQY7
bwV+zfBAsNK+wccrHXJFo625WuRnjR3n13/AmJlx7qu8nfgRgIrnfRpUZxLuiumo
mmvoJvtEO92ADpdq+8MMD4fu6AvlQx4ClSXz1QMbtefkSeqH+yAYHq9i0V3HCJXX
pnl6CtNmGamq82gRyblqHkopZhx87EvKc+3e+TgKpiZI02xyiyDNA7Bh3IQlhKo/
pzKBe56siVGO3yOXif3bKqwXd6gQvcdUz3FQt471lI6qE2fP+v7jhY5OpG1fU/o6
Ung0I+H3ItZqwWrks1kww+jdhYPKijPgBZ2WWZU0hpac9S0h2Iyyd6eRcqVF8plr
VWkuY/ZVvW9914zSYrLmSezpcr8eTk3crsO3/2LSBbgtpnxBUrXwbptQr4HhfT6O
q42UGn4xExeFHJQHNPzm
=jQ6o
-----END PGP SIGNATURE-----

--vzUQzca511KWT6Hk--
