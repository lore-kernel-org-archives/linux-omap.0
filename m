From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/2] gpio/omap: convert gpio irq domain to linear mapping
Date: Mon, 4 Mar 2013 20:47:56 +0200
Message-ID: <20130304184756.GA15203@arwen.pp.htv.fi>
References: <1362158568-1624-1-git-send-email-jon-hunter@ti.com>
 <1362158568-1624-2-git-send-email-jon-hunter@ti.com>
 <20130302114742.GA9965@arwen.pp.htv.fi>
 <5134D484.8070307@ti.com>
 <20130304171159.GB14507@arwen.pp.htv.fi>
 <5134E0BF.7050306@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52223 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756790Ab3CDSse (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Mar 2013 13:48:34 -0500
Content-Disposition: inline
In-Reply-To: <5134E0BF.7050306@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: balbi@ti.com, Kevin Hilman <khilman@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 04, 2013 at 11:58:23AM -0600, Jon Hunter wrote:
> >>> while (isr) {
> >>> 	unsigned long bit =3D __ffs(isr);
> >>>
> >>> 	/* clear this bit */
> >>> 	isr &=3D ~bit;
> >>>
> >>> 	generic_handle_irq(irq_find_mapping(bank->domain, bit);
> >>> }
> >>>
> >>> this way you will only iterate the amount of bits enabled in the isr
> >>> register.
> >>
> >> Definitely cleaner but I am wondering which approach would be more
> >> efficient from an instruction standpoint. This could definitely be much
> >> more efficient if there is only a couple bits set.
> >=20
> > __ffs() is done with CLZ instruction, so it's pretty fast.
>=20
> Ok, yes I see that now for ARMv5 onwards. Grant has pushed the patch,
> but may be we can update this as an optimisation separately.

sure, that was my suggestion from the beginning :-) It's clearly subject
to a separate patch.

--=20
balbi

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRNOxcAAoJEIaOsuA1yqREYpQP/112uucSNvMJ3mNcCXrCWChD
chABRCbfm19bjZpEyRA+o7fLWN4wx9kl+Q7QFxjZadstFHSbvo12SlCfPRYHj1mu
baVAeT54+v2PI18aG9D/2MD3Olp0+XU6I6mYJj4cAPNcxOA3rOUHa6bXllIdkjPp
WpHo+5hWV90CO0L0vv2bTwwlhgUFj3cDUWMLc529XYEvzp3GdQQVAAs/3MHooK8n
qhDOqHg6bES0lgBWzzSMdFTQCaHKQUP4CVLnJlsSDiSU6l+XqC3KJ6XbHpD5X3rf
9lrS3iuII5tu90/Mw69i49QHdTgGgjzfHeafB80QgvSEzAAHRdXp2yQTZ7hitqfe
w6yrGNuzdW2naokhP/hKod3/4+JfzbPwTzxg/tKDmlc47L3JiemxRffxSqqrvRV3
AXc/H8YTiC2YCLNEBwLTqwHFoNu0QKpqCyZYougWMw5wrdwKqYumW2SarJBhFzsN
nl7l2IemY3GvcXno9m6axpMfuOcxqSpP2iUVbtQrR0eGMPMT1OoH4VUbrihCNFam
wE2M2H2EIJbLIUBPs+KEdPaLBtOs6tLHvg94sRDpjDV60u+mri/6uDOmHH07lMyY
G9k1DrzkGZ+VTmRqfkwOglXb4ldHdKzy+WNkmO9l6pZqIwplCUvArURPZ11AEqxF
paaUBhFwpv5LpuQIscK1
=ckwv
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
