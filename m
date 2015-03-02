From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 14/15] twl4030_charger: Increase current carefully while
 watching voltage.
Date: Mon, 2 Mar 2015 22:29:45 +0100
Message-ID: <20150302212945.GT13270@amd>
References: <20150224043341.4243.23291.stgit@notabene.brown>
 <20150224043353.4243.32335.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150224043353.4243.32335.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue 2015-02-24 15:33:53, NeilBrown wrote:
> The USB Battery Charging spec (BC1.2) suggests a dedicated
> charging port can deliver from 0.5 to 5.0A at between 4.75 and 5.25
> volts.
> 
> To choose the "correct" current voltage setting requires a trial
> and error approach: try to draw current and see if the voltage drops
> too low.
> 
> Even with a configure Standard Downstream Port, it may not be possible
> to reliably pull 500mA - depending on cable quality and source

"configured"?

> quality I have reports of charging failure due to the voltage dropping
> too low.
> 
> To address both these concern, this patch introduce incremental

concerns.

> current setting.
> The current pull from VBUS is increased in steps of 20mA every 100ms
> until the target is reached or until the measure voltage drops below
> 4.75V.  If the voltage does go too long, the target current is reduced

"too low"?

> by 20mA and kept there.
> 
> This applies to currents selected automatically, or to values
> set via sysfs.  So setting a large value will cause the maximum
> available to be used - up to the limit of 1.7mA imposed by the
> hardware.

1.7A?


> @@ -249,8 +261,14 @@ static int twl4030_charger_update_current(struct twl4030_bci *bci)
>  		cur = bci->ac_cur;
>  		bci->ac_is_active = 1;
>  	} else {
> -		cur = bci->usb_cur;
> +		cur = bci->usb_cur_actual;

usb_cur_actual is not a really great variable name...

>  		bci->ac_is_active = 0;
> +		if (cur > bci->usb_cur) {
> +			cur = bci->usb_cur;
> +			bci->usb_cur_actual = cur;
> +		}
> +		if (cur < bci->usb_cur)
> +			schedule_delayed_work(&bci->current_worker, USB_CUR_DELAY);
>  	}
>  
>  	/* First, check thresholds and see if cgain is needed */
> @@ -379,6 +397,38 @@ static int twl4030_charger_update_current(struct twl4030_bci *bci)
>  	return 0;
>  }
>  
> +static void twl4030_current_worker(struct work_struct *data)
> +{
> +	int v;
> +	int res;
> +	struct twl4030_bci *bci = container_of(data, struct twl4030_bci,
> +					       current_worker.work);
> +
> +	res = twl4030bci_read_adc_val(TWL4030_BCIVBUS);
> +	if (res < 0)
> +		v = 0;
> +	else
> +		/* BCIVBUS uses ADCIN8, 7/1023 V/step */
> +		v = res * 6843;
> +
> +	printk("v=%d cur=%d target=%d\n", v, bci->usb_cur_actual,
> +	       bci->usb_cur);
> +
> +	if (v < USB_MIN_VOLT) {
> +		/* Back up and stop adjusting. */
> +		bci->usb_cur_actual -= USB_CUR_STEP;
> +		bci->usb_cur = bci->usb_cur_actual;
> +	} else if (bci->usb_cur_actual >= bci->usb_cur ||
> +		   bci->usb_cur_actual + USB_CUR_STEP > USB_MAX_CURRENT) {
> +		/* Reach target and volts are OK - stop */

Reached ... and the voltage is OK - stop.


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
