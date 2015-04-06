From: Mark Brown <broonie@kernel.org>
Subject: Re: LDP: next-20150402: twl4030 regression?
Date: Mon, 6 Apr 2015 16:01:27 +0100
Message-ID: <20150406150127.GF6023@sirena.org.uk>
References: <5522886D.5050409@ti.com>
 <20150406134541.GE6023@sirena.org.uk>
 <55228FE0.2040702@ti.com>
 <20150406135829.GH4027@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NG5rUlMnWRrIcOiS"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:52040 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbbDFPBk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Apr 2015 11:01:40 -0400
Content-Disposition: inline
In-Reply-To: <20150406135829.GH4027@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nishanth Menon <nm@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-next@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--NG5rUlMnWRrIcOiS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 06, 2015 at 02:58:29PM +0100, Russell King - ARM Linux wrote:
> On Mon, Apr 06, 2015 at 08:53:36AM -0500, Nishanth Menon wrote:

> > > at least a description of the problem you're seeing and some attempt at

> > Test was a simple boot test. There seems to be a lockdep reported at the
> > very least in the log provided (see
> > https://github.com/nmenon/kernel-test-logs/blob/next-20150402/omap2plus_defconfig/ldp.txt#L488
> > ).

> I think what Mark is trying to say is to include a fuller description of
> the problem, and don't expect people to fire up their web browser to get
> a basic overview of what the problem is.

Yes, indeed.  I hadn't actually opened the links, I might've got round
to it later on.

> My guess is that the problem _appears_ to be that someone's added a call
> to debug_check_no_locks_held() into schedule_hrtimeout_range_clock()
> without considering what this means.

> What it means is that you can't now use usleep_range() from within any
> driver probe function - which is absolutely absurd.

I can't think of any regulator side changes which might be relevant in
that period.  It's possible that there might be something in the MFD I
guess.

--NG5rUlMnWRrIcOiS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVIp/GAAoJECTWi3JdVIfQ/t8H/ReOCUFDx/UYLs39HXX7ZEzx
ZGKZ+KM/rMIK5coTB5izIAuZ37Y+6b5kJTK8LFTGO2l7PNNoIaGZLB+lshZORCmu
cM6DF5Ukw1CT0jqVTWdAU42YmkYCpC78bs+Ofjj6NTdokGsaU6nuTlFKAiqpntft
5EHSiPM3hPw4OreOO8FeiiUWI/F1qyc9GNVURaw0RkakcbZXJ2WjXyeHX1fbUmoj
mXZcS5gocqSLctrqT2keKHHhRH/4DeVCZ4X8q6bj6D2hMjPSrs5gaB0da8ovbXlM
83Ls7XEZFciaBLLpNddjDeYpiXqIERpLAdYJEIfnPwqi1am1EhFhl+V7jCpypMU=
=x9pQ
-----END PGP SIGNATURE-----

--NG5rUlMnWRrIcOiS--
