From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 08/15] twl4030_charger: distinguish between USB current
 and 'AC' current
Date: Mon, 2 Mar 2015 22:05:10 +0100
Message-ID: <20150302210509.GK13270@amd>
References: <20150224043341.4243.23291.stgit@notabene.brown>
 <20150224043351.4243.50342.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150224043351.4243.50342.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi!

> The twl4030 charger has two current sources, 'USB' and 'AC' (which is
> really DC of course...).
> 
> If 'AC' is providing current, we should set the current limit
> differently to when it isn't (and so USB is used).
> So split 'cur' into 'usb_cur' and 'ac_cur' and use accordingly.
> 
> Now we must review the current setting on any interrupt or USB
> event which might indicate that the charger-source has changed.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>

> @@ -103,7 +104,9 @@ struct twl4030_bci {
>  	/* ichg values in uA. If any are 'large', we set CGAIN to

ichg/_cur values

>  	 * '1' which doubles the range for half the precision.
>  	 */
> -	int			ichg_eoc, ichg_lo, ichg_hi, cur;
> +	int			ichg_eoc, ichg_lo, ichg_hi;
> +	int			usb_cur, ac_cur;

> +	/* If VAC exceeds 4.5V (MADC 11) and ac is enabled, set current
> +	 * for 'ac'

	/*
	 * If AC voltage exceeds 4.5V (MADC 11) and AC is enabled, set current
	 * for 'ac'.


Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
