From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v2 2/3] hwrng: OMAP3 ROM Random Number Generator support
Date: Wed, 16 Oct 2013 20:57:34 +0800
Message-ID: <20131016125734.GA10906@gondor.apana.org.au>
References: <1379534757-20870-1-git-send-email-pali.rohar@gmail.com>
 <1379683507-30793-1-git-send-email-pali.rohar@gmail.com>
 <1379683507-30793-3-git-send-email-pali.rohar@gmail.com>
 <20131008190408.GM8313@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131008190408.GM8313@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Matt Mackall <mpm@selenic.com>, Russell King <linux@arm.linux.org.uk>, Joe Perches <joe@perches.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Juha Yrjola <juha.yrjola@solidboot.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 08, 2013 at 12:04:09PM -0700, Tony Lindgren wrote:
> * Pali Roh=E1r <pali.rohar@gmail.com> [130920 06:33]:
> > This driver provides kernel-side support for the Random Number
> > Generator hardware found on OMAP34xx processors.
> >=20
> > This driver comes from Maemo 2.6.28 kernel and was tested on Nokia =
RX-51.
> > It is platform device because it needs board specific function for =
smc calls.
>=20
> This one is should be merged via the hw_random patches seprately:
>=20
> Acked-by: Tony Lindgren <tony@atomide.com>

Patch applied.  Thanks!
--=20
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
