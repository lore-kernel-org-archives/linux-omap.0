From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/4] power_supply: Introduce PSE compliant algorithm
Date: Sat, 25 Jan 2014 23:29:29 +0100
Message-ID: <20140125222929.GA30083@Nokia-N900>
References: <1390411194-21410-1-git-send-email-jenny.tc@intel.com>
 <1390411194-21410-4-git-send-email-jenny.tc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1390411194-21410-4-git-send-email-jenny.tc@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jenny TC <jenny.tc@intel.com>
Cc: linux-kernel@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Anton Vorontsov <anton.vorontsov@linaro.org>, Kim Milo <Milo.Kim@ti.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jg1.han@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Rupesh Kumar <rupesh.kumar@stericsson.com>, Lars-Peter Clausen <lars@metafoo.de>, Pali Roh?r <pali.rohar@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Rhyland Klein <rklein@nvidia.com>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Sebastian Reichel <sre@ring0.de>, aaro.koskinen@iki.fi, freemangordon@abv.bg, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi!


> +config POWER_SUPPLY_CHARGING_ALGO_PSE
> +	bool "PSE compliant charging algorithm"
> +	help
> +	  Say Y here to select PSE compliant charging algorithm. As per PSE
> +	  standard the battery characteristics and thereby the charging rates

It would be good to explain PSE here.

> +#define MAINT_EXIT_OFFSET 50  /* mv */

mV

> +/* PSE Modified Algo Structure */
> +/* Parameters defining the charging range */
> +struct psy_ps_temp_chg_table {
> +	/* upper temperature limit for each zone */
> +	short int temp_up_lim;
> +	/* charge current and voltage */
> +	short int full_chrg_vol;
> +	short int full_chrg_cur;

It would be good to add units here. And vowels.

> +	/* type of battery */
> +	u16 battery_type;
> +	u16 capacity;
> +	u16 voltage_max;
> +	/* charge termination current */
> +	u16 chrg_term_ma;
> +	/* Low battery level voltage */
> +	u16 low_batt_mv;
> +	/* upper and lower temperature limits on discharging */
> +	u8 disch_tmp_ul;
> +	u8 disch_tmp_ll;

tmp sounds like temporary, not temperature. just use full words.

Add units. And u8 is probably not right type for temperature.


> +	/* number of temperature monitoring ranges */
> +	u16 temp_mon_ranges;
> +	struct psy_ps_temp_chg_table temp_mon_range[BATT_TEMP_NR_RNG];
> +	/* Lowest temperature supported */
> +	short int temp_low_lim;

Add units.

Also check multiline comment codingstyle.
						Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
