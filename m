From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 4/4] power_supply: bq24261 charger driver
Date: Tue, 28 Jan 2014 15:14:45 +0100
Message-ID: <20140128141445.GC8713@xo-6d-61-c0.localdomain>
References: <1390411194-21410-1-git-send-email-jenny.tc@intel.com>
 <1390411194-21410-5-git-send-email-jenny.tc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1390411194-21410-5-git-send-email-jenny.tc@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jenny TC <jenny.tc@intel.com>
Cc: linux-kernel@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Anton Vorontsov <anton.vorontsov@linaro.org>, Kim Milo <Milo.Kim@ti.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jg1.han@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Rupesh Kumar <rupesh.kumar@stericsson.com>, Lars-Peter Clausen <lars@metafoo.de>, Pali Roh?r <pali.rohar@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Rhyland Klein <rklein@nvidia.com>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Sebastian Reichel <sre@ring0.de>, aaro.koskinen@iki.fi, freemangordon@abv.bg, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi!

> +#define BQ24261_ICHRG_MASK		(0x1F << 3)
> +#define BQ24261_ICHRG_100ma		(0x01 << 3)
> +#define BQ24261_ICHRG_200ma		(0x01 << 4)
> +#define BQ24261_ICHRG_400ma		(0x01 << 5)
> +#define BQ24261_ICHRG_800ma		(0x01 << 6)
> +#define BQ24261_ICHRG_1600ma		(0x01 << 7)

First, its mA, not ma.

And second:

> +#define BQ24261_VINDPM_320MV		(0x01 << 2)
> +#define BQ24261_VINDPM_160MV		(0x01 << 1)
> +#define BQ24261_VINDPM_80MV		(0x01 << 0)

(Same here).

> +u16 bq24261_iterm[][2] = {
> +	{0, 0x00}
> +	,
> +	{50, BQ24261_ITERM_50ma}
> +	,
> +	{100, BQ24261_ITERM_100ma}
> +	,
> +	{150, BQ24261_ITERM_100ma | BQ24261_ITERM_50ma}

...this is very obscure way to do with table what can be done with

(x/50) << 3, right ?
 

> +u16 bq24261_cc[][2] = {
> +
> +	{500, 0x00}
> +	,
> +	{600, BQ24261_ICHRG_100ma}
> +	,
> +	{700, BQ24261_ICHRG_200ma}
> +	,
> +	{800, BQ24261_ICHRG_100ma | BQ24261_ICHRG_200ma}
> +	,
> +	{900, BQ24261_ICHRG_400ma}

I suspect you can get rid of this, too, if you expand macros.

> +static inline bool is_bq24261_enabled(struct bq24261_charger *chip)
> +{
> +	if (chip->cable_type == PSY_CHARGER_CABLE_TYPE_NONE)
> +		return false;
> +	else if (!chip->is_charger_enabled)
> +		return false;

No need to do elses if all you do is return...

> +		return -EINVAL;
> +
> +	ret = psy->get_property(psy, POWER_SUPPLY_PROP_CURRENT_NOW, &val);
> +	if (!ret)
> +		*cur = val.intval;
> +
> +	return ret;

You can merge two very similar functions here, AFAICT.


> +	if (verify_recovery) {
> +		if ((bat_volt) <= (bat_volt_max_des / 1000 *
> +				BQ24261_OVP_RECOVER_MULTIPLIER))
> +			return true;
> +		else
> +			return false;

Do this without if().

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
