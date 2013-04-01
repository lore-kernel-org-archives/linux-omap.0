From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3 ROM Random Number Generator support
Date: Mon, 1 Apr 2013 09:25:38 -0700
Message-ID: <20130401162536.GG10155@atomide.com>
References: <201302281905.48546@pali>
 <201303281854.02847@pali>
 <20130328214411.GZ10155@atomide.com>
 <201303311128.12698@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201303311128.12698@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Juha Yrjola <juha.yrjola@solidboot.com>, Russell King <linux@arm.linux.org.uk>, Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, =?utf-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?= <freemangordon@abv.bg>
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [130331 02:32]:
> On Thursday 28 March 2013 22:44:11 Tony Lindgren wrote:
> >=20
> > You can use regular clk_get if you add the alias to
> > struct omap_clk omap3xxx_clks table.
>=20
> Tony, can you show me how?

Take a look at the omap3xxx_clks in cclock3xxx_data.c.
Note how some entries have things like "omap_hsmmc.0" and
"ick". By adding those your driver can request the clock
with clk_get(&pdev->dev, "ick").

Regards,

Tony
