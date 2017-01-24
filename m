From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: v4.10-rc4 to v4.10-rc5: battery regression on Nokia N900
Date: Tue, 24 Jan 2017 06:18:26 -0800
Message-ID: <88c94ea6-abe2-0f20-337e-e9ee00c883d8@roeck-us.net>
References: <20170123124058.GA17134@amd> <20170123141331.GA11402@amd>
 <da1f1b45-3ae5-ffe8-62c6-9ec7c3a1505b@roeck-us.net>
 <20170123144031.GA7870@amd> <20170123232654.GA19342@amd>
 <20170123234912.GA2460@roeck-us.net> <20170124070639.GA5068@rzhang1-surface>
 <20170124073720.GB5603@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170124073720.GB5603@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Zhang Rui <rui.zhang@intel.com>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, fabio.estevam@nxp.com
List-Id: linux-omap@vger.kernel.org

On 01/23/2017 11:37 PM, Pavel Machek wrote:
> On Tue 2017-01-24 15:06:39, Zhang Rui wrote:
>> On Mon, Jan 23, 2017 at 03:49:12PM -0800, Guenter Roeck wrote:
>>> On Tue, Jan 24, 2017 at 12:26:54AM +0100, Pavel Machek wrote:
>>>> Hi!
>>>>
>>>>>>> I'll try to revert it on the top of v4.10-rc5 now... and yes, it fixes
>>>>>>> the issue.
>>>>>>>
>>>>>>> Any idea what went wrong and how to fix that?
>>>>>>>
>>>>>>> Anyway as we are at -rc5 and this is warning fix that caused a
>>>>>>> regression on different hardware... it should be reverted.
>>>>>>>
>>>>>> Agreed.
>>>>>>
>>>>>> What exactly does "stopped working" mean ? That might help understanding
>>>>>> what went wrong.
>>>>>
>>>>> /sys files related to battery no longer appear. I beieve this has
>>>>> something to do with it:
>>>>>
>>>>> [    2.374877] of_get_named_gpiod_flags: parsed 'reset-gpios' property
>>>>> of node '/ocp@68000000/spi@48098000/tsc2005@0[0]' - status (0)
>>>>> [    2.375946] input: TSC2005 touchscreen as
>>>>> /devices/platform/68000000.ocp/48098000.spi/spi_master/spi1/spi1.0/input/input5
>>>>> [    2.392120] rx51-battery: probe of n900-battery failed with error
>>>>> -22
>>>>
>>>> Mystery solved:
>>>>
>>>> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
>>>> index 3932f92..fe5ec82 100644
>>>> --- a/drivers/hwmon/hwmon.c
>>>> +++ b/drivers/hwmon/hwmon.c
>>>> @@ -545,8 +545,10 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
>>>>  	int i, j, err, id;
>>>>
>>>>  	/* Do not accept invalid characters in hwmon name attribute */
>>>> -	if (name && (!strlen(name) || strpbrk(name, "-* \t\n")))
>>>> +	if (name && (!strlen(name) || strpbrk(name, "-* \t\n"))) {
>>>> +		printk("hwmon: Invalid character detected: %s\n", name);
>>>>  		return ERR_PTR(-EINVAL);
>>>> +	}
>>>>
>>>>  	id = ida_simple_get(&hwmon_ida, 0, 0, GFP_KERNEL);
>>>>  	if (id < 0)
>>>>
>>>>
>>>> pavel@n900:~$ dmesg | grep -5 Invalid
>>>> [    0.829650] of_get_named_gpiod_flags: parsed 'gpio-reset' property
>>>> of node '/ocp@68000000/i2c@48072000/tlv320aic3x@19[0]' - status (0)
>>>> [    0.833831] tsl2563 2-0029: model 7, rev. 0
>>>> [    0.837768] of_get_named_gpiod_flags: parsed 'enable-gpio' property
>>>> of node '/ocp@68000000/i2c@48072000/lp5523@32[0]' - status (0)
>>>> [    1.921417] omap_i2c 48072000.i2c: controller timed out
>>>> [    2.056823] lp5523x 2-0032: lp5523 Programmable led chip found
>>>> [    2.064147] hwmon: Invalid character detected: bq27200-0
>>>
>>> So the problem is really that the thermal driver needs to create a valid name.
>>>
>> Right.
>>
>> Before reverting, can you please try if this patch works or not?
>
> Not really. Revert now. Sorry.
>
> Are you sure? This does not look equivalent to me at all.
>
> "name" file handling moved from drivers to the core, which added some
> crazy checks what name can contain. Even if this "works", what is the
> expected effect on the "name" file?
>
The hwmon name attribute must not include '-', as documented in
Documentation/hwmon/sysfs-interface. Is enforcing that 'crazy' ?
Maybe in your world, but not in mine.

Guenter
