From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 12/15] twl4030_charger: add software controlled linear
 charging mode.
Date: Mon, 2 Mar 2015 22:09:26 +0100
Message-ID: <20150302210926.GP13270@amd>
References: <20150224043341.4243.23291.stgit@notabene.brown>
 <20150224043352.4243.11227.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150224043352.4243.11227.stgit@notabene.brown>
Sender: linux-pm-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue 2015-02-24 15:33:52, NeilBrown wrote:
> Add a 'continuous' option for usb charging which enabled
> the "linear" charging mode of the twl4030.

Documentation/ :-).

> Linear charging does a good job with not so reliable power sources, since
> several voltage controlling is then often too intelligent.

Parse error.

> It was used with a bike hub dynamo since a year or so. In that case there
> are automatically charging stops when the cyclist needs a break.
> 
> Orignal-by: Andreas Kemnade <andreas@kemnade.info>
> Signed-off-by: NeilBrown <neilb@suse.de>


> +			ret = twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE, 0x33,
> +					       TWL4030_BCIWDKEY);
> +			/* 0x24 + EKEY6:  off mode */

"  " -> " "

> +			ret = twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE, 0x2a,
> +					       TWL4030_BCIMDKEY);
> +			/* EKEY2: Linear charge: usb path */

USB

> +			ret = twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE, 0x26,
> +					       TWL4030_BCIMDKEY);
> +			/* WDKEY5: stop watchdog count */
> +			ret = twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE, 0xf3,
> +					       TWL4030_BCIWDKEY);
> +			/* enable MFEN3 access */
> +			ret = twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE, 0x9c,
> +					       TWL4030_BCIMFKEY);
> +			 /* ICHGEOCEN - end-of-charge monitor (current < 80mA)
> +			  *                      (charging continues)
> +			  * ICHGLOWEN - current level monitor (charge continues)
> +			  * don't monitor over-current or heat save

Heat save? Is ignoring over-current good idea?

> @@ -650,6 +684,8 @@ twl4030_bci_mode_store(struct device *dev, struct device_attribute *attr,
>  		mode = 0;
>  	else if (sysfs_streq(buf, modes[1]))
>  		mode = 1;
> +	else if (sysfs_streq(buf, modes[2]))
> +		mode = 2;

Time for loop?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
