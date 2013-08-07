From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] usb: dwc3-pci: Ensure system sleep PM ops are defined
 only when used
Date: Wed, 7 Aug 2013 10:34:07 +0100
Message-ID: <20130807093407.GT6427@sirena.org.uk>
References: <1375804166-3205-1-git-send-email-broonie@kernel.org>
 <CAOMZO5A_M3u4A3j7pFcooZ6jVi5LikERM4CVjL4bB2z5YVeTXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lpUp1egui7PDlNtH"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:38532 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932296Ab3HGJeg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Aug 2013 05:34:36 -0400
Content-Disposition: inline
In-Reply-To: <CAOMZO5A_M3u4A3j7pFcooZ6jVi5LikERM4CVjL4bB2z5YVeTXQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-omap@vger.kernel.org, Andy Green <andy.green@linaro.org>


--lpUp1egui7PDlNtH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 06, 2013 at 10:35:52PM -0300, Fabio Estevam wrote:
> On Tue, Aug 6, 2013 at 12:49 PM, Mark Brown <broonie@kernel.org> wrote:
> > From: Andy Green <andy.green@linaro.org>
> >
> > You might have CONFIG_PM, but you might not have CONFIG_SUSPEND, in which
> > case these are unused.
> >
> > Signed-off-by: Andy Green <andy.green@linaro.org>
> > Signed-off-by: Mark Brown <broonie@linaro.org>

> What about doing this instead?

Makes sense to me - Andy?

--lpUp1egui7PDlNtH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSAhSMAAoJELSic+t+oim9oXQP/RIlQmsS484KN4b9RJvQVS7G
IMMwLqtu6ktJqDIV3P4lSaR+1vV223lstiD79RWIQXEPhOUlXKcdDX/PGF1NTgS7
8l0x7OrtI32z9McGvRkzqdELEOPZLBINRlv/+lP5NmXplXisN1sA0ong/c71LE/y
/WNwnH3tGiNtgrwdeOLvnB+AD0H+gHzhcywhEto2MBjblHFz9rkweBwFnXKy6JiO
ldbDv/jO8RqwM6e4n89WZ4IRziPfzC73ZSqQozLtk5tzAP9BvkeBp3uIc6TaFPCL
s9DP31LcIwn3tKiN2d/tM7P7FgoUTpA98C4GskNsOSCxMu77t8K/C5IUwUB7voXA
Ix4BNEZMq3GUrKZcbyNfsUylSybNkZG2Zzh/wusIN64tDWT3pRrdGGbBAx1pIAIJ
ENCSM1fdU/SS5jpii3A4usdkvhIizN74WKIQMIDM6Xg/UVAPPAQCnf2QBnpxeS6i
Cohj6j31m9MX7ZeY1cXqjeX5wfSQ/7rdtE8uLBFobYPseuqEMs5gPOZNGgmlFxY3
MStbTGaxOF+/wADrvQ34ppZz4mSoJeB9ayOGsFK/xiMruzttTlJSvqzR9awikvmV
YijrcD8VnRC+IoLo8FQbrmUR6DbEcjQjhhE6pwvASHjMR8XPenKvkWsYUbABr4M0
0ibQp7WXlJEL1xmOH1RF
=7Y/U
-----END PGP SIGNATURE-----

--lpUp1egui7PDlNtH--
