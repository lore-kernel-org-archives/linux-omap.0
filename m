From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 4/4] power_supply: bq24261 charger driver
Date: Thu, 30 Jan 2014 18:01:54 +0100
Message-ID: <20140130170154.GA16503@amd.pavel.ucw.cz>
References: <1391103052-10954-1-git-send-email-jenny.tc@intel.com>
 <1391103052-10954-5-git-send-email-jenny.tc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1391103052-10954-5-git-send-email-jenny.tc@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jenny TC <jenny.tc@intel.com>
Cc: linux-kernel@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Anton Vorontsov <anton.vorontsov@linaro.org>, Kim Milo <Milo.Kim@ti.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jg1.han@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Rhyland Klein <rklein@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Sebastian Reichel <sre@ring0.de>, aaro.koskinen@iki.fi, freemangordon@abv.bg, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi!

> diff --git a/drivers/power/Makefile b/drivers/power/Makefile
> index 77535fd..6d184c8 100644
> --- a/drivers/power/Makefile
> +++ b/drivers/power/Makefile
> @@ -59,4 +59,5 @@ obj-$(CONFIG_CHARGER_BQ24735)	+= bq24735-charger.o
>  obj-$(CONFIG_POWER_AVS)		+= avs/
>  obj-$(CONFIG_CHARGER_SMB347)	+= smb347-charger.o
>  obj-$(CONFIG_CHARGER_TPS65090)	+= tps65090-charger.o
> +obj-$(CONFIG_BQ24261_CHARGER)	+= bq24261_charger.o
>  obj-$(CONFIG_POWER_RESET)	+= reset/

I believe I commented on this one before. Spot two inconsistencies.

> +	int (*set_inlmt) (int val);
> +	int (*set_iterm) (int val);

And stop using cryptic names.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
