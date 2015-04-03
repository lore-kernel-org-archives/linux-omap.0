From: Sebastian Reichel <sre@kernel.org>
Subject: ARM errata 430973 on multi platform kernels (was: OMAP3-N900: Add
 microphone bias voltages)
Date: Fri, 3 Apr 2015 18:35:54 +0200
Message-ID: <20150403163553.GA16247@earth>
References: <1425236828-28349-1-git-send-email-jarkko.nikula@bitmer.com>
 <55197A12.1050009@bitmer.com>
 <20150330164237.GJ10805@atomide.com>
 <55198BA4.5010207@bitmer.com>
 <20150330175051.GK10805@atomide.com>
 <20150331123233.GA15103@earth>
 <20150401194734.GT10805@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41050 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751617AbbDCQgZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Apr 2015 12:36:25 -0400
Content-Disposition: inline
In-Reply-To: <20150401194734.GT10805@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 01, 2015 at 12:47:36PM -0700, Tony Lindgren wrote:
> > > OK I think debian is using v3.16 kernel
> >=20
> > Yes. It will be used for Debian jessie (not yet released) and the
> > N900 related drivers are enabled in the armmp flavour. Unfortunately
> > it does not work together with thumb using userland because the
> > errata 430973 workaround is not enabled.
> >=20
> > See https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D768890
>=20
> Hmm I believe many ARMv8 boards will be randomly oopsing
> with armhf without that. I sort of recall random oopses just
> with running apt-get update on ARMv8 omaps on armhf without that:

Since I don't know of any ARMv8 omaps, I will read ARMv8 as ARMv7.

And yes, for armhf userland one gets random oopses at least on the
Nokia N900. AFAIK this is not true for all ARMv7 processors
(especially non omaps), though.

> http://www.spinics.net/lists/linux-omap/msg108511.html
>=20
> See also 5c86c5339c56 ("ARM: omap2plus_defconfig: Enable ARM erratum
> 430973 for omap3").

For me the random oopses occur without this config flag and are
fixed by it. The workaround is not very suitable for multi platform
kernels, though, since its enabled also for unaffected platforms.

As far as I can see the CONFIG_ARM_ERRATA_430973 flag is checked
in proc-v7.S and in proc-v7-2level.S. I think the first file is
irrelevant, since it can be fixed later (see workaround in
nokia_n900_legacy_init in pdata-quirks.c).

So basically the problem comes down to proc-v7-2level.S

> I wonder if the ARMv8 revision range might be wrong 430973 in
> kernel or errata?

what revision range? I think the errata is enabled unconditionally
or disabled completly.

> Also I recall that 430973 change to the
> arch/arm/mm/proc-v7-2level.S fixed the issue, this should be
> verified though.

If I understand the errata correctly the BTAC/BTB flushing is
important. It would be nice if it could be limited to affected
devices, though.

> > I guess it should be tried to change the workaround, so that it does
> > only change the behaviour of affected platforms. Otherwise its a
> > hard decision for distributions to enable the workaround.
>=20
> Well we should figure out first why flush BTAC/BTB is needed in
> cpu_v7_switch_mm.. And if what I'm describing above is still
> reproducable.

Reading the help text in the kernel the flushing is the actual
workaround. The other changes only make it possible to do the
flushing.

Maybe an option would be to provide two cpu_v7_switch_mm
implementations (one with the errata and one without). Then
the system can start with the simple implementation. Once
the boot as progressed far enough to know, that the hardware
is affected by the errata, it could switch to the implementation
with the flushing.

-- Sebastian

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVHsFnAAoJENju1/PIO/qaM10QAITsKf2AOVPcUXQ6LzJW7rVq
GI/mNf7rGFETZHWVZ6kjbz4tOxVaHW7dcOdHdzo0usSYKJPG3YQBoppXi7ZEjRvF
GCnu5IipQv4F72B5aKHKwRSbUkpCTdFj67oI3/15VvlgQ6J3MdMLLhtkqoZUl8wU
A1ihvv7hYu+GYPAdMgOtypofeeTM/1cEvziadXN7tH92BCOSnmFkNPejH9Eefu6T
abAAp+eYs2YE81saJDPLcs+oi5teebWL2PIHVbYyc/72LFzxBecZz4TRz041p9oD
UZGxSWo1MwZi7kEc6hIPp+bZsXuca0CPdLcUtX6p0Lp4YesP31oT7DHqeeQeHW3i
3JTETNT4iNPb2cDBGgjcBY0KGnn71kgKWLVNUJNs3twVpJc54cflks3fI9SFqiVH
nQX8NZvTB5a/c1FHcVsph/dkOkR/JkaOT8jbzlI3jKBZc3nn+pSP3UMys43Aeyff
6NW3sAceDN6pv+5mUMh9oOhFHdgTP7uNWY0/wPmM+rUaj/qG/8dr+FOhBu0o1iGc
KB8LDWk+tucwTXP9p7sTsiiu9R1gSMfuc30tHglGd5s4b8UrQ3s6NMEGMpvw6Dk5
ZDtRoN/EQwVRqaHhs0Ownq69tQ8LjSIatraXMStczkQK1rwZEFKmgnaCWK6q3h7P
ArLhVsurYo+ahbtvo+Yt
=vp3e
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
