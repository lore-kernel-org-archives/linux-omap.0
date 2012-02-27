From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 0/2] Device tree support for TWL regulators
Date: Mon, 27 Feb 2012 14:03:56 +0000
Message-ID: <20120227140356.GF3191@opensource.wolfsonmicro.com>
References: <1330338961-31765-1-git-send-email-rnayak@ti.com>
 <4F4B73C8.8070807@ti.com>
 <4F4B7798.6000300@ti.com>
 <20120227134112.GB3191@opensource.wolfsonmicro.com>
 <4F4B8A85.7060603@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SNIs70sCzqvszXB4"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:54600 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752881Ab2B0OEE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Feb 2012 09:04:04 -0500
Content-Disposition: inline
In-Reply-To: <4F4B8A85.7060603@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: tony@atomide.com, Rajendra Nayak <rnayak@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lrg@ti.com, patches@linaro.org, linaro-dev@lists.linaro.org


--SNIs70sCzqvszXB4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 27, 2012 at 02:52:05PM +0100, Cousson, Benoit wrote:
> On 2/27/2012 2:41 PM, Mark Brown wrote:
> >On Mon, Feb 27, 2012 at 06:01:20PM +0530, Rajendra Nayak wrote:

> >Please can you guys come up with a single unified series for this stuff
> >- I'll hold off on applying anything to allow you to do this.

> The issue is that the initial TWL regulator series from Rajendra
> will depend on the twl core DT support I have that depends on the
> irq_domain series from Grant...

Really?  That's the first I've heard of any such dependency here.  Is it
a build time dependency or is it just something that's required to make
the code actually spring into life?  It looks like it's the latter but
you're saying there's an actual dependency.

There's also more than that, there's also at least Tero submitting some
other stuff separately (and his stuff won't play with DT...) and I think
Peter also.  It really fees like there's a bunch of people working on
different things without talking to each other here.

> So I guess, it will be easy for us to split the regulator patches
> from the DTS ones to have at least the driver changes merged by you.
> Then Tony might be able to pull all the DTS in one series and thus
> avoid the various merge conflict that will happen since most OMAP
> drivers are hacking the same DTS files.

> Does that make sense? Or do you think it will be even worst
> separating the patches?

Unless there's a compile time dependency I don't think we need to
refactor anything here, what I'm seeing at the minute looks OK from a
merge point of view except that there appears to be a lack of
coordination between the various serieses.

--SNIs70sCzqvszXB4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPS41FAAoJEBus8iNuMP3dtBMP/15v/MN44FUlC5tFiQaNt0q+
tsH6whmnsG3HtHgrP3lck7CrFb8uQXWLQ6A8PlyLYp2EWgp4BgStfql2ThItpSkh
CnUOQaqBKEyYFVp3ceuyR4ceC1vk4LrDWans3ost73GJW/k4KDLErQEs6FHU1qqu
F1Ja8jtV4r7YCv2YTT1eSnjhno/QcMC1JRe45ewqjm5ZTP2ZwfDBALxeaFnzQTxP
QOU/9IulFz8mSJoOqwNuv2gukte386wVOGHup6QYBwCuk7NnS8Lbmi3N+JDLliHz
tQYCgCTOXraWn8Ly2bWfFNIZJNWG9cWI/5c7NXk5Qn3QDbCwd3Zmac96BxvnHOG5
5fVsXtoGGbtUTeyfNgUNi7chbik2oSiZ+Il7N5TmaYyV4BklHgv/aXgvjInEKik6
xSJiGRlupd5CgypYsOB0o9suuBjRSL7VuFkaGgqpKBuZo7A6Fv21BUK8D46M9I1C
j3Ew/nzvv9lsGyzKUBISxPeUiVAVEyIkprRGYq9rY23+N1L55rViq6AuXyfrMA6T
R4TX/dlg7OO9libLwHW6JYJeGO3xtWtpX1vK9RUubYS7mupE/+GTYon7/rOuldim
f0jLwvDIM4o1LhG0Twm2pMJoS6mFMB3wYzi2fkbpsB7qU/+X1UO19qXo2y+z2t9F
bchqwvrRJ1S4J0rQ5rg6
=9kco
-----END PGP SIGNATURE-----

--SNIs70sCzqvszXB4--
