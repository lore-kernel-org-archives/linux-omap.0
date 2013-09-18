From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/2] hwrng: OMAP3 ROM Random Number Generator support
Date: Wed, 18 Sep 2013 13:22:43 -0700
Message-ID: <1379535763.1787.63.camel@joe-AO722>
References: <201303281854.02847@pali>
	 <1379534757-20870-1-git-send-email-pali.rohar@gmail.com>
	 <1379534757-20870-2-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1379534757-20870-2-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Juha Yrjola <juha.yrjola@solidboot.com>
List-Id: linux-omap@vger.kernel.org

On Wed, 2013-09-18 at 22:05 +0200, Pali Roh=E1r wrote:
> This driver provides kernel-side support for the Random Number
> Generator hardware found on OMAP34xx processors.

[]

> diff --git a/drivers/char/hw_random/omap3-rom-rng.c b/drivers/char/hw=
_random/omap3-rom-rng.c

trivial note:

It produces smaller overall code to add
#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
before any #include and use

> +static void omap3_rom_rng_idle(unsigned long data)
> +{
> +	int r;
> +
> +	r =3D omap3_rom_rng_call(0, 0, RNG_RESET);
> +	if (r !=3D 0) {
> +		printk(KERN_ERR "%s: reset failed: %d\n",
> +		       omap3_rom_rng_name, r);

		pr_err("reset failed: %d\n", r);

> +static int omap3_rom_rng_get_random(void *buf, unsigned int count)
> +{
[]
> +		if (r !=3D 0) {
> +			clk_disable_unprepare(rng_clk);
> +			printk(KERN_ERR "%s: HW init failed: %d\n",
> +			       omap3_rom_rng_name, r);

			pr_err("HW init failed: %d\n", r);

etc...
