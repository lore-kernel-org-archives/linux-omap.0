From: Mark Brown <broonie@kernel.org>
Subject: Re: [RESEND PATCH v3 03/11] ASoC: davinci-mcasp: Add DMA register
 locations to DT
Date: Tue, 8 Oct 2013 01:46:41 +0100
Message-ID: <20131008004641.GV21581@sirena.org.uk>
References: <cover.1379590035.git.jsarha@ti.com>
 <66bdda0c0b75d737d649260b9ec10f9f870c20cd.1379590036.git.jsarha@ti.com>
 <20131007214718.GA2976@kartoffel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VpY0yS1BYpNZumir"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:49756 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591Ab3JHAqw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Oct 2013 20:46:52 -0400
Content-Disposition: inline
In-Reply-To: <20131007214718.GA2976@kartoffel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: jsarha@ti.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "joelf@ti.com" <joelf@ti.com>, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, Darren Etheridge <detheridge@ti.com>


--VpY0yS1BYpNZumir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 07, 2013 at 10:47:18PM +0100, Mark Rutland wrote:
> On Thu, Sep 26, 2013 at 08:18:28PM +0100, Jyri Sarha wrote:

> >  - interrupts : Interrupt number for McASP

> The device also seems to be able to generate multiple interrupts -- which
> interrupt does this actually cover?

> The driver doesn't seem to use it (by a grep of irq|interrupt). Have I missed
> something?

No, they're not actually of much practical use to us at the minute but
it was generally felt better to include the information and not use it
so that if someone does come up with a use for them then the trees for
deployed systems already have the information.

--VpY0yS1BYpNZumir
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSU1XuAAoJELSic+t+oim9KgIQAJ4V4Z9TOmQTvNCxb7I4Jm5C
SZIGIiA5GCJCQ1XMrbFzBTU9vbeHELOJxIx13TIafi0+YcXIVceatPnHYzM7DCFy
APnIVWEN8SJs+nN5ZDklCb57wF+SkZ/xuPCf8A2eL6SigLMn8dAcIYU7gXsxHObd
BNfYmLWH75wnJKUm3a1eFbykPtBLrW5yNSCfiOggjgOp/2XmYTlDrmex6MtjoApL
U4OBqwJ3BRhyLnQknvG9/kc/04Pmke+PTywju0hiyWo9WfrCcZHBeG/5h5igs62N
BegoX8cPLAGH45DYq6sFfG0S4afc6iurWS5Ypd2cQWj4E9Vv0mjxZo42LTAQnHWy
JjiLLPqwVJ523ktzHgPG9dplKIC3eUCBVewr9c54Y1tm3c0TcqTK06AbPS2HCj9e
6bFxVHjZAeAMFHWY3NNNzqb08KF0guDYvfIiP+POfOrBat+AMxS1YUhAwbCTWBoM
mzeJsolJQSt5TMXp2teoKPN+vUc3DQsX08+RWv+kMg9qHaX/wMgedaCoyWMrL7WK
tfCMmQ3uJFKyVDBPOon4biZc9IX+TuivQZ5+WcElowuWzfvXv74YTbTH3vw2p0L2
kz6FmRP7hW9Ydie9rpFqnbdFtBhtO+tOinzyFv27wmN7lA54cG9+KvT+p0+WNbz9
UIMo7SzkmdCYrG/AYEY1
=KeRW
-----END PGP SIGNATURE-----

--VpY0yS1BYpNZumir--
