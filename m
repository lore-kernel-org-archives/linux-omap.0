From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/4] power_supply: Introduce generic psy charging driver
Date: Tue, 4 Feb 2014 12:36:30 +0100
Message-ID: <20140204113630.GC2450@amd.pavel.ucw.cz>
References: <1391490780-6141-1-git-send-email-jenny.tc@intel.com>
 <1391490780-6141-3-git-send-email-jenny.tc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1391490780-6141-3-git-send-email-jenny.tc@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jenny TC <jenny.tc@intel.com>
Cc: linux-kernel@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Anton Vorontsov <anton.vorontsov@linaro.org>, Kim Milo <Milo.Kim@ti.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jg1.han@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Rhyland Klein <rklein@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Sebastian Reichel <sre@ring0.de>, aaro.koskinen@iki.fi, Pallala Ramakrishna <ramakrishna.pallala@intel.com>, freemangordon@abv.bg, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi!

> +Throttling configuration example:
> +
> +struct psy_throttle_state my_throttle_states[] = {
> +
> +	/* Level 0:  Limit charge current to 1500mA. Normal Level */
> +	{
> +		.throttle_action = PSY_THROTTLE_CC_LIMIT,
> +		.throttle_val = 1500,
> +	},
> +
> +	/* Level 1: Limit charge current to 500mA */
> +	{
> +		.throttle_action = PSY_THROTTLE_CC_LIMIT,
> +		.throttle_val = 500,
> +	},
> +
> +	/*
> +	* Level 2: Disable charging: Stop charging, charger supply power to
> +	* platform.
> +	*/
> +	{
> +		.throttle_action = PSY_THROTTLE_DISABLE_CHARGING,
> +	},
> +
> +	/* Level 3: Disable charger: Battery start discharging */
> +	{
> +		.throttle_action = PSY_THROTTLE_DISABLE_CHARGER,
> +	},
> +
> +};


Does it make sense to have throttling description as a data, as
opposed to normal C code?

> +struct psy_charger_context {
> +	bool is_usb_cable_evt_reg;
> +	int psyc_cnt;
> +	int batt_status;
> +	/*cache battery and charger properties */

Comment coding style. Please run you patches through checkpatch.

> +	struct list_head evt_queue;
> +	struct mutex evt_lock;
> +	struct list_head event_queue;
> +	struct psy_batt_chrg_prof batt_property;

Again, please use full words in variable names. How am I supposed to
know what evt_queue is? Especially when you have event_queue, also?!

And please do it globally.

> +static void __power_supply_trigger_charging_handler(struct power_supply *psy)
> +{
> +	int i;
> +	struct power_supply *psb = NULL;
> +
> +
> +	if (is_trigger_charging_algo(psy)) {
> +		if (psy_is_battery(psy)) {
> +			if (trigger_algo(psy))
> +				enable_supplied_by_charging(psy, false);
> +			else
> +				enable_supplied_by_charging(psy, true);
> +		} else if (psy_is_charger(psy)) {
> +			for (i = 0; i < psy->num_supplicants; i++) {
> +				psb =
> +				    power_supply_get_by_name(psy->
> +							     supplied_to[i]);
> +
> +				if (psb && psy_is_battery(psb) &&
> +							psy_is_present(psb)) {
> +					if (trigger_algo(psb)) {
> +						psy_disable_charging(psy);
> +						break;
> +					} else if
> +						(psy_is_charging_can_be_enabled
> +								(psy)) {
> +						psy_enable_charging(psy);
> +						wait_for_charging_enabled(psy);
> +					}
> +				}
> +			}
> +		}
> +		update_sysfs(psy);
> +		power_supply_changed(psy);
> +	}
> +}

See coding style about excessive nesting. Please fix it globally.

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
