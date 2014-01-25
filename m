From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 4/4] power_supply: bq24261 charger driver
Date: Sat, 25 Jan 2014 23:30:17 +0100
Message-ID: <20140125223017.GB30083@Nokia-N900>
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

> +++ b/drivers/power/Makefile
> @@ -59,4 +59,5 @@ obj-$(CONFIG_CHARGER_BQ24735)	+= bq24735-charger.o
>  obj-$(CONFIG_POWER_AVS)		+= avs/
>  obj-$(CONFIG_CHARGER_SMB347)	+= smb347-charger.o
>  obj-$(CONFIG_CHARGER_TPS65090)	+= tps65090-charger.o
> +obj-$(CONFIG_BQ24261_CHARGER)	+= bq24261_charger.o
>  obj-$(CONFIG_POWER_RESET)	+= reset/

Spot two inconsistencies.

> +			if (ret < 0)
> +				dev_err(&chip->client->dev,
> +				"Error (%d) in reading status register(0x00)\n",
> +				ret);

If you have code indented 10 levels like this, you are
doing something wrong.

Check codingstyle.

Maybe Rafael should be cced on the series?
						Pavel
