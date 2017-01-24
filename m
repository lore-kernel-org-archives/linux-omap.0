From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: v4.10-rc4 to v4.10-rc5: battery regression on Nokia N900
Date: Tue, 24 Jan 2017 06:15:35 -0800
Message-ID: <a403081d-021c-f023-3c04-711e7091ea1e@roeck-us.net>
References: <20170123124058.GA17134@amd> <20170123141331.GA11402@amd>
 <da1f1b45-3ae5-ffe8-62c6-9ec7c3a1505b@roeck-us.net>
 <20170123144031.GA7870@amd> <20170123232654.GA19342@amd>
 <20170123234912.GA2460@roeck-us.net> <20170124073442.GA5603@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170124073442.GA5603@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, fabio.estevam@nxp.com, rui.zhang@intel.com
List-Id: linux-omap@vger.kernel.org

On 01/23/2017 11:34 PM, Pavel Machek wrote:
> Hi!
>
>>>>>> I'll try to revert it on the top of v4.10-rc5 now... and yes, it fixes
>>>>>> the issue.
>>>>>>
>>>>>> Any idea what went wrong and how to fix that?
>>>>>>
>>>>>> Anyway as we are at -rc5 and this is warning fix that caused a
>>>>>> regression on different hardware... it should be reverted.
>>>>>>
>>>>> Agreed.
>>>>>
>>>>> What exactly does "stopped working" mean ? That might help understanding
>>>>> what went wrong.
>>>>
>>>> /sys files related to battery no longer appear. I beieve this has
>>>> something to do with it:
>>>>
>>>> [    2.374877] of_get_named_gpiod_flags: parsed 'reset-gpios' property
>>>> of node '/ocp@68000000/spi@48098000/tsc2005@0[0]' - status (0)
>>>> [    2.375946] input: TSC2005 touchscreen as
>>>> /devices/platform/68000000.ocp/48098000.spi/spi_master/spi1/spi1.0/input/input5
>>>> [    2.392120] rx51-battery: probe of n900-battery failed with error
>>>> -22
>>>
>>> Mystery solved:
>>>
>>> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
>>> index 3932f92..fe5ec82 100644
>>> --- a/drivers/hwmon/hwmon.c
>>> +++ b/drivers/hwmon/hwmon.c
>>> @@ -545,8 +545,10 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
>>>  	int i, j, err, id;
>>>
>>>  	/* Do not accept invalid characters in hwmon name attribute */
>>> -	if (name && (!strlen(name) || strpbrk(name, "-* \t\n")))
>>> +	if (name && (!strlen(name) || strpbrk(name, "-* \t\n"))) {
>>> +		printk("hwmon: Invalid character detected: %s\n", name);
>>>  		return ERR_PTR(-EINVAL);
>>> +	}
>>>
>>>  	id = ida_simple_get(&hwmon_ida, 0, 0, GFP_KERNEL);
>>>  	if (id < 0)
>>>
>>>
>>> pavel@n900:~$ dmesg | grep -5 Invalid
>>> [    0.829650] of_get_named_gpiod_flags: parsed 'gpio-reset' property
>>> of node '/ocp@68000000/i2c@48072000/tlv320aic3x@19[0]' - status (0)
>>> [    0.833831] tsl2563 2-0029: model 7, rev. 0
>>> [    0.837768] of_get_named_gpiod_flags: parsed 'enable-gpio' property
>>> of node '/ocp@68000000/i2c@48072000/lp5523@32[0]' - status (0)
>>> [    1.921417] omap_i2c 48072000.i2c: controller timed out
>>> [    2.056823] lp5523x 2-0032: lp5523 Programmable led chip found
>>> [    2.064147] hwmon: Invalid character detected: bq27200-0
>>
>> So the problem is really that the thermal driver needs to create a valid name.
>
> Look down how log continues.
>
> So we really have two problematic names on one device. Plus, those
> names are exposed to userspace, AFAICT. So "just changing them" might
> not be good idea.
>
> Maybe we should just relax the check?
>

So that invalid names are reported to user space ? No. If you insist reporting
bad names to user space just because bad names have been reported to user
space before, messing up libsensors, stick with the old API that lets you do
that, but don't mess up the new API.

Guenter

> Anyway, this just confirms that original patch needs to be reverted,
> and that there will be some fun issues to solve in v4.11.
>
> 								Pavel
>
>
>>> [    2.064544] bq27xxx-battery 2-0055: failed to register battery
>>> [    2.064605] bq27xxx-battery: probe of 2-0055 failed with error -22
>>> [    2.065368] of_get_named_gpiod_flags: parsed 'power-gpio' property
>>> of node '/ocp@68000000/i2c@48072000/tpa6130a2@60[0]' - status (0)
>>> [    2.083221] bq2415x-charger 2-006b: automode supported, waiting for
>>> events
>>> [    2.084442] bq2415x-charger 2-006b: driver registered
>>> --
>>> [    2.369842] g_ether gadget: g_ether ready
>>> [    2.377197] tsc2005 spi1.0: GPIO lookup for consumer reset
>>> [    2.377227] tsc2005 spi1.0: using device tree for GPIO lookup
>>> [    2.377288] of_get_named_gpiod_flags: parsed 'reset-gpios' property
>>> of node '/ocp@68000000/spi@48098000/tsc2005@0[0]' - status (0)
>>> [    2.378936] input: TSC2005 touchscreen as
>>> /devices/platform/68000000.ocp/48098000.spi/spi_master/spi1/spi1.0/input/input5
>>> [    2.395111] hwmon: Invalid character detected: rx51-battery
>>> [    2.402587] rx51-battery: probe of n900-battery failed with error
>>> -22
>>> [    2.410247] omap_hsmmc 4809c000.mmc: GPIO lookup for consumer cd
>>> [    2.410247] omap_hsmmc 4809c000.mmc: using device tree for GPIO
>>> lookup
>>> [    2.410278] of_get_named_gpiod_flags: can't parse 'cd-gpios'
>>> property of node '/ocp@68000000/mmc@4809c000[0]'
>>> [    2.410278] of_get_named_gpiod_flags: can't parse 'cd-gpio'
>>> property of node '/ocp@68000000/mmc@4809c000[0]'
>>>
>
