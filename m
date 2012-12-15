From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] regulator: core: if voltage scaling fails, restore
 original voltage values
Date: Sat, 15 Dec 2012 23:15:20 +0900
Message-ID: <20121215141519.GA22033@opensource.wolfsonmicro.com>
References: <1355389980-5532-1-git-send-email-paolo.pisati@canonical.com>
 <1355389980-5532-2-git-send-email-paolo.pisati@canonical.com>
 <20121213094715.GA1916@arwen.pp.htv.fi>
 <20121214153943.GA3306@luxor.wired.org>
 <20121214154030.GD18233@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121214154030.GD18233@arwen.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Paolo Pisati <paolo.pisati@canonical.com>, linux-omap <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 14, 2012 at 05:40:30PM +0200, Felipe Balbi wrote:

> No no, I mean that before you SoB you should have a:

> Cc: <stable@vger.kernel.org> # v3.x v3.y ...

It's perfectly OK to omit this unless there's an awareness that the
backport won't work on some kernels.

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQzIXwAAoJELSic+t+oim9saoQAInSC8dlZVoyYw10UXMwJZ0a
GDEYalibcwOvvSxPP04MsZNM06qu4DqhTbfXFxOPb8TcHXNr0Q1oU+cOMaEeYif8
5O6imOxaY014vqkYtMBtD1EsYFpl5nVU27Voge7fW1wxMb55iYMtCIcitADUD8W8
i2okhDMG9HAfMBwiI1AB1Q0zaL62la9qQfxrNKQX7Em7ZGTXgyStmqoyP7ucKlSP
0j5dxpcZk/dtaEku5ZXxCFo7ZbqNgJ5f41FfaRuXsLwjyZGikpoeqfHBV2c0YyMa
72KIts4jIhItIAZnwiuuD1868JPaf6/80uTRw9LS6hPiTy1AWgLCPeHX7cIT9yG8
+StsbAuMgX2nmN6bH5Li1FDMFoWc2qED72UYDfpsO/OVHQFDoRM0OpPaCGFoMRNe
XldhrIfzAh64ef/txNs2fbRdGatNhgmsbuhUbkZYVyx5jFRpc5LEpVR9IDwvthNy
immo6XLkd5yoqmQsIHgcBIkdFKktL648/0hRyQ1Y6qZ+D4IUJADzI5OgEFgfDIIs
93q7ZVP9qFfuJ3dUZAvwvFufBwlFQSmkGU1+8NrES9UK6pffIZM96PWSimv2dlu4
Ea72fkjGQhWsGrPnP7Fv7DWQ65FKTIHbWhf95tx+Gyt/fTjkmQwDzEhuQj7aVopK
i+9JpZ8L+os6ZrE9cy9J
=JNW9
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
