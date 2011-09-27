From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 2/9] regulator: helper routine to extract regulator_init_data
Date: Tue, 27 Sep 2011 20:18:04 +0530
Message-ID: <4E81E224.2070408@ti.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com> <1317118372-17052-3-git-send-email-rnayak@ti.com> <20110927121003.GB4289@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:53062 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751462Ab1I0OsN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Sep 2011 10:48:13 -0400
Received: by mail-yi0-f45.google.com with SMTP id 2so6919810yib.4
        for <linux-omap@vger.kernel.org>; Tue, 27 Sep 2011 07:48:12 -0700 (PDT)
In-Reply-To: <20110927121003.GB4289@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org

On Tuesday 27 September 2011 05:40 PM, Mark Brown wrote:
> On Tue, Sep 27, 2011 at 03:42:45PM +0530, Rajendra Nayak wrote:
>
>> +	init_data = devm_kzalloc(dev, sizeof(struct regulator_init_data),
>> +						 GFP_KERNEL);
>> +	if (!init_data)
>> +		return NULL; /* Out of memory? */
>
> This means that the init data will be kept around for the entire
> lifetime of the device rather than being discarded.

Wasn't it the same while this was passed around as platform_data?

>
>> +	init_data->supply_regulator = (char *)of_get_property(dev->of_node,
>> +						"regulator-supplies", NULL);
>
> I'd expect that in the device tree world the supply regulator would
> reference the node for that regulator.

You mean using phandles? Thats what Grant proposed too but
I thought you instead had an inclination towards names? Or maybe
I misunderstood.

>
>>   	/* voltage output range (inclusive) - for voltage control */
>> -	int min_uV;
>> -	int max_uV;
>> +	u32 min_uV;
>> +	u32 max_uV;
>>
>> -	int uV_offset;
>> +	u32 uV_offset;
>>
>>   	/* current output range (inclusive) - for current control */
>> -	int min_uA;
>> -	int max_uA;
>> +	u32 min_uA;
>> +	u32 max_uA;
>
> Hrm, I think loosing the signs here is bad karma - negative voltages do
> exist after all.

Oops.. they do? didn't know about that.

