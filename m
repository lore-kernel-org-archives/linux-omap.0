From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 07/13] twl4030_charger: distinguish between USB current
 and 'AC' current
Date: Thu, 6 Aug 2015 20:11:16 -0700
Message-ID: <20150807031116.GH4215@atomide.com>
References: <20150730001113.4012.18086.stgit@noble>
 <20150730001124.4012.48552.stgit@noble>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150730001124.4012.48552.stgit@noble>
Sender: linux-pm-owner@vger.kernel.org
To: NeilBrown <neil@brown.name>
Cc: Sebastian Reichel <sre@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, linux-pm@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, real GTA04 owners <gta04-owner@goldelico.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org

* NeilBrown <neil@brown.name> [150729 17:28]:
> --- a/drivers/power/twl4030_charger.c
> +++ b/drivers/power/twl4030_charger.c
>  static int twl4030_charger_update_current(struct twl4030_bci *bci)
>  {
>  	int status;
> +	int cur;
>  	unsigned reg, cur_reg;
>  	u8 bcictl1, oldreg, fullreg;
>  	bool cgain = false;
>  	u8 boot_bci;
>  
> +	/*
> +	 * If AC (Accessory Charger) voltage exceeds 4.5V (MADC 11)
> +	 * and AC is enabled, set current for 'ac'
> +	 */
> +	if (twl4030_get_madc_conversion(11) > 4500) {
> +		cur = bci->ac_cur;
> +		bci->ac_is_active = true;
> +	} else {
> +		cur = bci->usb_cur;
> +		bci->ac_is_active = false;
> +	}
> +
>  	/* First, check thresholds and see if cgain is needed */
>  	if (bci->ichg_eoc >= 200000)
>  		cgain = true;

Neil, you need a stub or something for twl4030_get_madc_conversion
if madc is not selected. Now at least omap2plus_defconfig and
ARM allmodconfig fails in Linux next.

Regards,

Tony
