From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: v4.10-rc4 to v4.10-rc5: battery regression on Nokia N900
Date: Tue, 24 Jan 2017 15:06:39 +0800
Message-ID: <20170124070639.GA5068@rzhang1-surface>
References: <20170123124058.GA17134@amd>
 <20170123141331.GA11402@amd>
 <da1f1b45-3ae5-ffe8-62c6-9ec7c3a1505b@roeck-us.net>
 <20170123144031.GA7870@amd>
 <20170123232654.GA19342@amd>
 <20170123234912.GA2460@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170123234912.GA2460@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, fabio.estevam@nxp.com
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 23, 2017 at 03:49:12PM -0800, Guenter Roeck wrote:
> On Tue, Jan 24, 2017 at 12:26:54AM +0100, Pavel Machek wrote:
> > Hi!
> > 
> > > > >I'll try to revert it on the top of v4.10-rc5 now... and yes, it fixes
> > > > >the issue.
> > > > >
> > > > >Any idea what went wrong and how to fix that?
> > > > >
> > > > >Anyway as we are at -rc5 and this is warning fix that caused a
> > > > >regression on different hardware... it should be reverted.
> > > > >
> > > > Agreed.
> > > > 
> > > > What exactly does "stopped working" mean ? That might help understanding
> > > > what went wrong.
> > > 
> > > /sys files related to battery no longer appear. I beieve this has
> > > something to do with it:
> > > 
> > > [    2.374877] of_get_named_gpiod_flags: parsed 'reset-gpios' property
> > > of node '/ocp@68000000/spi@48098000/tsc2005@0[0]' - status (0)
> > > [    2.375946] input: TSC2005 touchscreen as
> > > /devices/platform/68000000.ocp/48098000.spi/spi_master/spi1/spi1.0/input/input5
> > > [    2.392120] rx51-battery: probe of n900-battery failed with error
> > > -22
> > 
> > Mystery solved:
> > 
> > diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> > index 3932f92..fe5ec82 100644
> > --- a/drivers/hwmon/hwmon.c
> > +++ b/drivers/hwmon/hwmon.c
> > @@ -545,8 +545,10 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
> >  	int i, j, err, id;
> >  
> >  	/* Do not accept invalid characters in hwmon name attribute */
> > -	if (name && (!strlen(name) || strpbrk(name, "-* \t\n")))
> > +	if (name && (!strlen(name) || strpbrk(name, "-* \t\n"))) {
> > +		printk("hwmon: Invalid character detected: %s\n", name);
> >  		return ERR_PTR(-EINVAL);
> > +	}
> >  
> >  	id = ida_simple_get(&hwmon_ida, 0, 0, GFP_KERNEL);
> >  	if (id < 0)
> > 
> > 
> > pavel@n900:~$ dmesg | grep -5 Invalid
> > [    0.829650] of_get_named_gpiod_flags: parsed 'gpio-reset' property
> > of node '/ocp@68000000/i2c@48072000/tlv320aic3x@19[0]' - status (0)
> > [    0.833831] tsl2563 2-0029: model 7, rev. 0
> > [    0.837768] of_get_named_gpiod_flags: parsed 'enable-gpio' property
> > of node '/ocp@68000000/i2c@48072000/lp5523@32[0]' - status (0)
> > [    1.921417] omap_i2c 48072000.i2c: controller timed out
> > [    2.056823] lp5523x 2-0032: lp5523 Programmable led chip found
> > [    2.064147] hwmon: Invalid character detected: bq27200-0
> 
> So the problem is really that the thermal driver needs to create a valid name.
>
Right.

Before reverting, can you please try if this patch works or not?

thanks,
rui

>From 79320ea3721314ec29ed6cdd6987ff922b11d6f9 Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Tue, 24 Jan 2017 14:11:03 +0800
Subject: [PATCH] thermal: fix parameter when registering hwmon

commit 7611fb68062f ("thermal: thermal_hwmon: Convert to
hwmon_device_register_with_info()") converts thermal core to use
hwmon_device_register_with_info() to register to hwmon instead of
deprecated hwmon_device_register().
But at the same time, the name of the hwmon device created is changed to
the thermal zone device name in this commit, which may contain
incompatible characters for hwmon.

Fixes it by using exactly the same parameters as before this commit.

Fixes: 7611fb68062f ("thermal: thermal_hwmon: Convert to hwmon_devce_register_with_info()")
Reported-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_hwmon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index c4a508a..0c6789f 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -157,8 +157,8 @@ int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 
 	INIT_LIST_HEAD(&hwmon->tz_list);
 	strlcpy(hwmon->type, tz->type, THERMAL_NAME_LENGTH);
-	hwmon->device = hwmon_device_register_with_info(NULL, hwmon->type,
-							hwmon, NULL, NULL);
+	hwmon->device = hwmon_device_register_with_info(NULL, NULL, NULL,
+							NULL, NULL);
 	if (IS_ERR(hwmon->device)) {
 		result = PTR_ERR(hwmon->device);
 		goto free_mem;
-- 
2.7.4

 
> Guenter
> 
> > [    2.064544] bq27xxx-battery 2-0055: failed to register battery
> > [    2.064605] bq27xxx-battery: probe of 2-0055 failed with error -22
> > [    2.065368] of_get_named_gpiod_flags: parsed 'power-gpio' property
> > of node '/ocp@68000000/i2c@48072000/tpa6130a2@60[0]' - status (0)
> > [    2.083221] bq2415x-charger 2-006b: automode supported, waiting for
> > events
> > [    2.084442] bq2415x-charger 2-006b: driver registered
> > --
> > [    2.369842] g_ether gadget: g_ether ready
> > [    2.377197] tsc2005 spi1.0: GPIO lookup for consumer reset
> > [    2.377227] tsc2005 spi1.0: using device tree for GPIO lookup
> > [    2.377288] of_get_named_gpiod_flags: parsed 'reset-gpios' property
> > of node '/ocp@68000000/spi@48098000/tsc2005@0[0]' - status (0)
> > [    2.378936] input: TSC2005 touchscreen as
> > /devices/platform/68000000.ocp/48098000.spi/spi_master/spi1/spi1.0/input/input5
> > [    2.395111] hwmon: Invalid character detected: rx51-battery
> > [    2.402587] rx51-battery: probe of n900-battery failed with error
> > -22
> > [    2.410247] omap_hsmmc 4809c000.mmc: GPIO lookup for consumer cd
> > [    2.410247] omap_hsmmc 4809c000.mmc: using device tree for GPIO
> > lookup
> > [    2.410278] of_get_named_gpiod_flags: can't parse 'cd-gpios'
> > property of node '/ocp@68000000/mmc@4809c000[0]'
> > [    2.410278] of_get_named_gpiod_flags: can't parse 'cd-gpio'
> > property of node '/ocp@68000000/mmc@4809c000[0]'
> > 
> > 									Pavel
> > 
> > 
> > -- 
> > (english) http://www.livejournal.com/~pavelmachek
> > (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> 
> 
