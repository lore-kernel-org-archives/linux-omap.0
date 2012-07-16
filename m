From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RFT] regulator: twl: Fix list_voltate for twl6030ldo_ops
Date: Mon, 16 Jul 2012 20:58:53 +0100
Message-ID: <20120716195853.GB10774@opensource.wolfsonmicro.com>
References: <1342434670.4717.6.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:47391 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751292Ab2GPT6z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jul 2012 15:58:55 -0400
Content-Disposition: inline
In-Reply-To: <1342434670.4717.6.camel@phoenix>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Rajendra Nayak <rnayak@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org, loml <linux-omap@vger.kernel.org>, Graeme Gregory <gg@slimlogic.co.uk>


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 16, 2012 at 06:31:10PM +0800, Axel Lin wrote:
> According to the datasheet, the voltage for twl6030ldo_ops is not linear for
> all cases. Linear mapping is only for the selection code from
> 00000001 to 00011000.

Applied, thanks.

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQBHJ0AAoJEBus8iNuMP3dXPMP/3TCVV75+l8b5h4pd/ll6h/K
ibuTd1VZdDFLW/KPumsovHMDzaJzn46HEprGfRGAujFynWz+KurC084WW2Mu+Z3+
udntO9Op5jsVfPt1ZdZouTs8+6/93HZGiPt7ZPvMyL/q1CxupQJp9Und4RjtUrrA
V+N9NlsEKxwS8af27KY2g4Rl2ox9wgpj2vFONdswUHPoY5q+oDsv8ru1P/QH20NU
p5Wa9TsRRxbgbTv0mlF25vib/cnE1CNojSSOAi4WQAwEpq2u78izZPalhroCdB14
fVOTk5IBIyKz1qlW2qpKW263hs6w6ClJy7Y2ApnRFiJ9PhI8GtJSexLrUlO9RiEQ
9yPozRU0WHd75TJZVxT3B3gmUeTo6oT648Yic59Ms6vWBx8aLYSVXQgcrFCfrF4b
DkiK/kR6w8gC/vPtGYaAg5BvlEH/bxxmyftccvApkSp8rMtE7v+M9/YjK+VV1vQ7
hXAbZOqVkvYMB1ROVF1oFsn4u09e14FEyOiWj45yZs27Mrnbuh7WlWjxL3fMB2cL
HRWp3my0YxT9Wa9gE7ORHt6tz1SjlO3cDX0w8dENtvgEnKbca90XmUeTT3xl5yEN
PFL5J4lhl7qEZ7Pa/t0FCIndqf7z6K/rboxXUXwu98hXBKYMW8FAiHD16p0EUZHL
YLuE3OFVAsk+3Y8Fu/Xe
=ECUP
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--
