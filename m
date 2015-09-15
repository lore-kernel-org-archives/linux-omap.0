From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 10/13] twl4030_charger: add software controlled linear
 charging mode.
Date: Tue, 15 Sep 2015 13:28:25 +0200
Message-ID: <20150915112825.GA10704@amd>
References: <20150730001113.4012.18086.stgit@noble>
 <20150730001124.4012.27784.stgit@noble>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150730001124.4012.27784.stgit@noble>
Sender: linux-pm-owner@vger.kernel.org
To: NeilBrown <neil@brown.name>
Cc: Sebastian Reichel <sre@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, real GTA04 owners <gta04-owner@goldelico.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Thu 2015-07-30 10:11:24, NeilBrown wrote:
> 
> Add a 'continuous' option for usb charging which enables
> the "linear" charging mode of the twl4030.
> 
> Linear charging does a good job with not-so-reliable power sources.
> Auto mode does not work well as it switches off when voltage drops
> momentarily.  Care must be taken not to over-charge.

Can you explain how the user can "care not to over-charge"?

> @@ -750,6 +784,17 @@ static int twl4030_bci_get_property(struct power_supply *psy,
>  		is_charging = state & TWL4030_MSTATEC_USB;
>  	else
>  		is_charging = state & TWL4030_MSTATEC_AC;
> +	if (!is_charging) {
> +		u8 s;
> +		twl4030_bci_read(TWL4030_BCIMDEN, &s);
> +		if (psy->desc->type == POWER_SUPPLY_TYPE_USB)
> +			is_charging = s & 1;
> +		else
> +			is_charging = s & 2;
> +		if (is_charging)
> +			/* A little white lie */
> +			state = TWL4030_MSTATEC_QUICK1;

I'm not sure... can't this white lie turn into black smoke?

Like.. normally, when battery is below something (like 3.5V) it must
not be quick-charged (because something is very wrong with it). Are
you just forcing the quick charge here?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
