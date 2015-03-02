From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 07/15] twl4030_charger: allow fine control of charger
 current.
Date: Mon, 2 Mar 2015 22:05:01 +0100
Message-ID: <20150302210501.GJ13270@amd>
References: <20150224043341.4243.23291.stgit@notabene.brown>
 <20150224043351.4243.88962.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150224043351.4243.88962.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi!

> +	/* ichg values in uA. If any are 'large', we set CGAIN to
> +	 * '1' which doubles the range for half the precision.
> +	 */
> +	int			ichg_eoc, ichg_lo, ichg_hi, cur;

We should really get uA_t.

[Plus, this is not kernel comment style, but...]

> +	/* For ichg_eoc, reg value must be 100XXXX000, we only
> +	 * set the XXXX in high nibble.
> +	 */

Confused. High nibble is 0xf0, right?

> +	/* And finally, set the current.  This is stored in
> +	 * two registers. */
> +	reg = ua2regval(bci->cur, cgain);
> +	/* we have only 10 bit */

bits

> @@ -562,6 +698,14 @@ static int __init twl4030_bci_probe(struct platform_device *pdev)
>  	if (!pdata)
>  		pdata = twl4030_bci_parse_dt(&pdev->dev);
>  
> +	bci->ichg_eoc = 80100; /* Stop charging when current drops to here */
> +	bci->ichg_lo = 241000; /* low threshold */

Low

> +	bci->ichg_hi = 500000; /* High threshold */

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
