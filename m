From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 18/48] mfd: twl4030-power: Register with kernel power-off
 handler
Date: Mon, 10 Nov 2014 06:49:53 -0800
Message-ID: <5460D091.3000509@roeck-us.net>
References: <1415292213-28652-1-git-send-email-linux@roeck-us.net> <1415292213-28652-19-git-send-email-linux@roeck-us.net> <20141110084600.GA2582@amd> <5460C70D.1000206@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35130 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795AbaKJOt4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Nov 2014 09:49:56 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XnqI0-00428Q-BG
	for linux-omap@vger.kernel.org; Mon, 10 Nov 2014 14:49:56 +0000
In-Reply-To: <5460C70D.1000206@roeck-us.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, linux-omap@vger.kernel.org

On 11/10/2014 06:09 AM, Guenter Roeck wrote:
> On 11/10/2014 12:46 AM, Pavel Machek wrote:
>> Hi!
>>
>>> @@ -611,7 +611,7 @@ twl4030_power_configure_resources(const struct twl4030_power_data *pdata)
>>>    * After a successful execution, TWL shuts down the power to the SoC
>>>    * and all peripherals connected to it.
>>>    */
>>> -void twl4030_power_off(void)
>>> +static void twl4030_power_off(struct power_off_handler_block *this)
>>>   {
>>>       int err;
>>>
>>> @@ -621,6 +621,11 @@ void twl4030_power_off(void)
>>>           pr_err("TWL4030 Unable to power off\n");
>>>   }
>>>
>>> +static struct power_off_handler_block twl4030_power_off_hb = {
>>> +    .handler = twl4030_power_off,
>>> +    .priority = POWER_OFF_PRIORITY_LOW,
>>> +};
>>> +
>>>   static bool twl4030_power_use_poweroff(const struct twl4030_power_data *pdata,
>>>                       struct device_node *node)
>>>   {
>>> @@ -839,7 +844,9 @@ static int twl4030_power_probe(struct platform_device *pdev)
>>>       }
>>>
>>>       /* Board has to be wired properly to use this feature */
>>> -    if (twl4030_power_use_poweroff(pdata, node) && !pm_power_off) {
>>> +    if (twl4030_power_use_poweroff(pdata, node)) {
>>> +        int ret;
>>> +
>>>           /* Default for SEQ_OFFSYNC is set, lets ensure this */
>>>           err = twl_i2c_read_u8(TWL_MODULE_PM_MASTER, &val,
>>>                         TWL4030_PM_MASTER_CFG_P123_TRANSITION);
>>> @@ -856,7 +863,11 @@ static int twl4030_power_probe(struct platform_device *pdev)
>>>               }
>>>           }
>>>
>>> -        pm_power_off = twl4030_power_off;
>>> +        ret = devm_register_power_off_handler(&pdev->dev,
>>> +                              &twl4030_power_off_hb);
>>> +        if (ret)
>>> +            dev_warn(&pdev->dev,
>>> +                 "Failed to register power-off handler\n");
>>>       }
>>>
>>
>> Could we get rid of the "struct power_off_handler_block" and guarantee
>> that register_power_off never fails (or print message from the
>> register_power_off...)? That way, your patch would be an cleanup.
>>
>> You could then add priorities if they turn out to be really
>> neccessary, later...
>
> Priorities are necessary. We had _that_ discussion before.
> Priorities solve the problem where multiple handlers are installed,
> either conditionally or unconditionally. If I take priorities away,
> a substantial part of the patch set's value gets lost, and I might
> as well drop it.
>
I have an idea: Instead of dropping the priority, drop
power_off_handler_block and add two parameters to register_power_off_handler
and devm_register_power_off_handler instead: the priority and a context.
At the same time, declare that those two functions must be called
with the memory subsystem initialized (register_power_off_handler_simple
must be used otherwise).

With this change, the registration functions can still fail due to memory
allocation errors, but we can get rid of the data structure and simplify
the calling code while retaining functionality. I'll explore that for v7.

Guenter

