From: Mark Greer <mgreer@animalcreek.com>
Subject: Re: [PATCH] bq24190_charger: Fix PM runtime use for
 bq24190_battery_set_property
Date: Tue, 15 Nov 2016 10:29:10 -0700
Message-ID: <20161115172910.GA32729@animalcreek.com>
References: <20161115033831.7620-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161115033831.7620-1-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 14, 2016 at 07:38:31PM -0800, Tony Lindgren wrote:
> There's a typo, it should do pm_runtime_get_sync, not put.
> 
> Cc: Mark A. Greer <mgreer@animalcreek.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/power/supply/bq24190_charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -1141,7 +1141,7 @@ static int bq24190_battery_set_property(struct power_supply *psy,
>  
>  	dev_dbg(bdi->dev, "prop: %d\n", psp);
>  
> -	pm_runtime_put_sync(bdi->dev);
> +	pm_runtime_get_sync(bdi->dev);
>  
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_ONLINE:
> -- 
> 2.10.2

Oops, sorry about that.

Reviewed-by: Mark Greer <mgreer@animalcreek.com>
