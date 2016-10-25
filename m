From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [RFC] shutdown machine when li-ion battery goes below 3V
Date: Tue, 25 Oct 2016 13:54:45 +0200
Message-ID: <20161025115445.GN12154@pali>
References: <20161024212250.GA31336@amd>
 <20161024212932.uhjz752z2cy5hohl@atomide.com>
 <20161025112757.GC25855@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161025112757.GC25855@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org

On Tuesday 25 October 2016 13:27:57 Pavel Machek wrote:
> On Mon 2016-10-24 14:29:33, Tony Lindgren wrote:
> > * Pavel Machek <pavel@ucw.cz> [161024 14:24]:
> > > Hi!
> > > 
> > > What about something like this? N900 will drain the battery down to
> > > system crash, which is quite uncool.
> > 
> > Can't we make that generic and configurable for the voltage somehow?
> > 
> > Also, the shutdown voltage can depend on external devices connected.
> > It could be for example 3.3V depending on eMMC on some devices while
> > devices with no eMMC could have it at 3.0V.
> 
> Actually, do we need to make it configurable? It looks like we should
> respect hardware telling us battery is dead, and only use (low)
> hardcoded voltages as a fallback.
> 
> Currently patch looks like this. generic_protect() should work for
> other batteries drivers, too.

Now I checked Maemo's BME replacement code and it shutdown device 10
seconds after it read that capacity level is LOW or CRITICAL. bq27xxx
driver reports LOW when EDV1 is set and CRITICAL when EDVF is set. And
bq27xxx reports those LOW/CRITICAL based on EDV1/EDVF flags even if
battery is not calibrated.

So I would be happy if kernel does not issue emergency shutdown before
Maemo's BME replacement issue own "correct" system shutdown. As Maemo is
doing it on EDV1 flag (not EDVF as I thought!) with 10 seconds delay and
check is done every 30 seconds it means that Maemo shutdown process in
worst case is started 40 seconds after EDV1 is set. Shutdown process is
about 60 seconds (probably max.), can we ensure that kernel does not do
its own emergency shutdown earlier then 2 minutes before first see EDV1
flag? Or can test that EDVF flag is set in most cases 2 minutes after
EDV1?

It is really bad idea to start emergency kernel shutdown before even
userspace do it!

> 								Pavel
> 
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index 0fe278b..04094ad 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -46,6 +46,7 @@
>  #include <linux/delay.h>
>  #include <linux/platform_device.h>
>  #include <linux/power_supply.h>
> +#include <linux/reboot.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>
>  
> @@ -679,10 +680,10 @@ static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
>  	/* Unlikely but important to return first */
>  	if (unlikely(bq27xxx_battery_overtemp(di, flags)))
>  		return POWER_SUPPLY_HEALTH_OVERHEAT;
> -	if (unlikely(bq27xxx_battery_undertemp(di, flags)))
> -		return POWER_SUPPLY_HEALTH_COLD;
>  	if (unlikely(bq27xxx_battery_dead(di, flags)))
>  		return POWER_SUPPLY_HEALTH_DEAD;
> +	if (unlikely(bq27xxx_battery_undertemp(di, flags)))
> +		return POWER_SUPPLY_HEALTH_COLD;
>  
>  	return POWER_SUPPLY_HEALTH_GOOD;
>  }
> @@ -740,6 +741,49 @@ void bq27xxx_battery_update(struct bq27xxx_device_info *di)
>  }
>  EXPORT_SYMBOL_GPL(bq27xxx_battery_update);
>  
> +static void shutdown(char *reason)
> +{
> +	pr_alert("%s Forcing shutdown\n", reason);
> +	orderly_poweroff(true);
> +}
> +
> +static int generic_protect(struct power_supply *psy)
> +{
> +	union power_supply_propval val;
> +	int res;
> +	int mV, mA, mOhm = 430, mVadj = 0;
> +
> +	res = psy->desc->get_property(psy, POWER_SUPPLY_PROP_HEALTH, &val);
> +	if (res)
> +		return res;
> +
> +	if (val.intval == POWER_SUPPLY_HEALTH_OVERHEAT)
> +		shutdown("Battery overheat.");
> +	if (val.intval == POWER_SUPPLY_HEALTH_DEAD)
> +		shutdown("Battery dead.");

Generally this is not a good idea. On some boards with bq27xxx devices
you can have another battery device or connected power device. You could
have "dead" battery but device supplied e.g. from wallcharger.

N900 cannot be powered from wallcharger by default, but in specific
conditions (turned everything except display) you can do battery
hotswap (when wallcharger is connected; it can power system).

So this patch basically break lot of other self powered devices.

I would propose check for am_i_power_supplied() (function with such name
in power_supply interface exist) and do that only for negative response.

> +	res = psy->desc->get_property(psy, POWER_SUPPLY_PROP_VOLTAGE_NOW, &val);
> +	if (res)
> +		return res;
> +	mV = val.intval / 1000;
> +
> +	if (mV < 2950)
> +		shutdown("Battery below 2.95V.");
> +
> +	res = psy->desc->get_property(psy, POWER_SUPPLY_PROP_CURRENT_NOW, &val);
> +	if (res)
> +		return res;
> +	mA = val.intval / 1000;
> +	mVadj = mV + (mA * mOhm) / 1000;
> +
> +	if (mVadj < 3150)
> +		shutdown("Battery internal voltage below 3.15.");
> +	
> +	printk(KERN_INFO "Main battery %d mV, internal voltage %d mV\n",
> +	       mV, mVadj);

Please no printk. There is dev_info or how is that function called. And
spamming dmesg for every poll is not good idea. It should be probably
DEBUG not INFO.

> +	return 0;
> +}
> +
>  static void bq27xxx_battery_poll(struct work_struct *work)
>  {
>  	struct bq27xxx_device_info *di =
> @@ -747,6 +791,7 @@ static void bq27xxx_battery_poll(struct work_struct *work)
>  				     work.work);
>  
>  	bq27xxx_battery_update(di);
> +	generic_protect(di->bat);
>  
>  	if (poll_interval > 0)
>  		schedule_delayed_work(&di->work, poll_interval * HZ);
> 

-- 
Pali Rohár
pali.rohar@gmail.com
