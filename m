From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 07/18] ASoC: codecs/hdmi: Mark the maximum significant
 bits to HDMI codec
Date: Wed, 15 Oct 2014 12:25:54 +0200
Message-ID: <20141015102553.GA27755@sirena.org.uk>
References: <cover.1413306131.git.jsarha@ti.com>
 <9d3aa456eb4d753c38fc642bf0a8cd5fdc5af54a.1413306131.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EkX7vcqEIssJSBlq"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:55512 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbaJOK0P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2014 06:26:15 -0400
Content-Disposition: inline
In-Reply-To: <9d3aa456eb4d753c38fc642bf0a8cd5fdc5af54a.1413306131.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com


--EkX7vcqEIssJSBlq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 14, 2014 at 08:29:26PM +0300, Jyri Sarha wrote:
> HDMI audio can not have more than 24 bits even if on i2s bus there
> would be 32 bit samples. Mark this by adding .sig_bits = 24 to
> playback stream definition.

Applied, thanks.  Please use subject lines matching the style for the
subsystem (no codecs/).

--EkX7vcqEIssJSBlq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUPkuxAAoJECTWi3JdVIfQjjwH/RzFFl4tVHtgWGCDi7sCOnnp
lFyPVeSgYzloEHfXhVp57wzf6KXyBJkTlifVRJTViPfHwTuRw+cV5OdrdJztITRy
6XwA6MJZCgCwu0e0x924nAmTQ653od5H0DpNaKiYq67entzVsILZ85iEVwAC5Aew
KfuqZHq0p7n/lZIqVIpZF+Go4kGFVhr3QFUvCt9Pzc8b2Byb/AeF8uKYpadBC4q9
jGYa6xbTpDliMRvWof+mx+xLEIDqXLQcAaSenmkRq2y/lhPXe6bRjolD4vGda48p
kW5qS258V3Y1uq6tczUS0Wk/UKAmTmyN75YNeiy578SsYunLo+LNZS+xrMso2+0=
=rvsH
-----END PGP SIGNATURE-----

--EkX7vcqEIssJSBlq--
