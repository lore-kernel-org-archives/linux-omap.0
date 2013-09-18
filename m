From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 1/2] hwrng: OMAP3 ROM Random Number Generator support
Date: Wed, 18 Sep 2013 23:50:25 +0300
Message-ID: <20130918205025.GC30568@blackmetal.musicnaut.iki.fi>
References: <201303281854.02847@pali>
 <1379534757-20870-1-git-send-email-pali.rohar@gmail.com>
 <1379534757-20870-2-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1379534757-20870-2-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Juha Yrjola <juha.yrjola@solidboot.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, Sep 18, 2013 at 10:05:56PM +0200, Pali Roh=E1r wrote:
> +	if (IS_ERR(rng_clk)) {
> +		printk(KERN_ERR "%s: unable to get RNG clock\n",
> +		       omap3_rom_rng_name);
> +		return IS_ERR(rng_clk);

This should be PTR_ERR().

A.
