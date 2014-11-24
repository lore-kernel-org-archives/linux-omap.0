From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7.1 00/19] Rework OMAP4+ HDMI audio support
Date: Mon, 24 Nov 2014 17:39:20 +0000
Message-ID: <20141124173920.GL7712@sirena.org.uk>
References: <cover.1415803064.git.jsarha@ti.com>
 <20141112222344.GU3815@sirena.org.uk>
 <54646648.5030807@ti.com>
 <546DC9A0.8060700@ti.com>
 <20141121112317.GQ3815@sirena.org.uk>
 <546F317B.9030004@ti.com>
 <20141121161435.GS3815@sirena.org.uk>
 <5472E9D7.7000908@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j3olVFx0FsM75XyV"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:36997 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754253AbaKXRl2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Nov 2014 12:41:28 -0500
Content-Disposition: inline
In-Reply-To: <5472E9D7.7000908@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com


--j3olVFx0FsM75XyV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 24, 2014 at 10:18:31AM +0200, Tomi Valkeinen wrote:
> On 21/11/14 18:14, Mark Brown wrote:

> > But in what way is it broken and how did this happen?  Why are none of

> I don't have a clear answer, but it probably involves lack of use, and
> buggy and hard to use implementation. Things have changed around the
> original HDMI audio implementation, and it stopped working at some point.

> As the original implementation was found rather lacking, and with some
> fundamental issues, it was deemed better to have a fresh approach.

OK...  this is all telling me that I *really* need to scrub this in
detail.  It's all sounding very vague, it's an area which seems to cause
lots of problems and I don't want to be sitting here next time around
trying to figure out if another rewrite makes things better or worse or
if another driver should look similar or different.

> > the patches which look like they're supposed to be bug fixes early on in
> > the series getting applied?  I had thought this was just a lack of
> > interest on the video side but it seems there's some other problems
> > since the series has apparently been discussed off-list and still it's
> > just as big as it was initially.

> The whole series is about HDMI audio, not video.

You know exactly what I mean - the early patches are in drivers/video,
don't touch anything outside of that and have no obvious dependencies.

> This series only touch the parts about HDMI audio, so the fixes early on
> don't really fix anything without the rest of the series (as the current
> HDMI audio doesn't work).

> And in any case, I don't like applying individual patches from a series.
> Usually that just complicates things. If I would apply some of the early
> patches to fbdev, then this series would no longer work on plain
> mainline kernel, and would instead depend on fbdev tree. The situation

But I thought everyone was saying this hardware doesn't work anyway and
that you want to apply all these changes to fbdev?

> would be ever worse if you'd also pick some of the audio patches to
> sound tree, creating a dependency to two subsystem trees.

> So if there's no particular important reason to pick patches from a
> series, I rather keep it as a whole to simplify merging and testing.

This means we're all then stuck reading reposts of the same enormous
series over and over again - as a reviewer a really big series that
appears from the subject lines to be mostly about another system is
really offputting.  If you're going to do something like this please at
least reply to the messages, that way it's clearer that there's not
going to be a dependency problem getting the patches applied (which is
part of what makes things offputting).

--j3olVFx0FsM75XyV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc21IAAoJECTWi3JdVIfQkQEH/0TwF2YImsmrtx8xGeglQDK4
uFQDuTDQJ+qbmmRMHcS3aqqb6D4SsUYbMBL+M9VMJWwek6cxQbyTbNQGNHSaBT3h
t9ex3GkqeapUbvT2Vn8yxJmG0gyA4wuOna9gDYuFP3TXjcTtnEZa9zkWGewOv2r9
OFGCXku8L3AGF8SWRFmjQHlX1QS50BD+CDtrhcVuiU0EE1kBwc482Zt4SR1SCHda
RpmazBIVBW5v/nX0oiQSvRxqcLgwmZ4+n+aXOp2trVYDupMcNV0Rx562Op5K6y6Y
wlD3vn41TvM6Bk4Mj1+L/H5qegwvwtfZVMxf+5Z1KE8LpEJzWtP/T6BfjavWzYY=
=ipBV
-----END PGP SIGNATURE-----

--j3olVFx0FsM75XyV--
