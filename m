From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [RFC][PATCH 1/5] ARM: OMAP2+: gpmc: driver conversion
Date: Mon, 26 Mar 2012 12:42:26 -0500
Message-ID: <4F70AA82.3000204@ti.com>
References: <1332484600-21947-1-git-send-email-afzal@ti.com> <4F6D0569.6080203@ti.com> <C8443D0743D26F4388EA172BF4E2A7A9317BB895@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51872 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933016Ab2CZRma (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Mar 2012 13:42:30 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A9317BB895@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

Hi Afzal,

On 3/26/2012 3:04, Mohammed, Afzal wrote:
> Hi Jon,
>
> On Sat, Mar 24, 2012 at 04:51:13, Hunter, Jon wrote:
>>> +struct gpmc_child {
>>> +	char			*name;
>>> +	int			id;
>>> +	struct resource		*res;
>>> +	unsigned		num_res;
>>> +	struct resource		gpmc_res[GPMC_CS_NUM];
>>
>> Does this imply a gpmc child device can use more than one chip-select? I
>> am trying to understand the link between number of resources and
>> GPMC_CS_NUM.
>
> Yes, relevant portion in commit message as follows,
>
> A peripheral connected to GPMC can have multiple
> address spaces using different chip select. Hence
> GPMC driver has been provided capability to
> distinguish this scenario, i.e. create platform
> devices only once for each connected peripheral,
> and not for each configured chip select. The
> peripheral that made it necessary was tusb6010.

Ok, makes sense. I believe that most devices are using a single CS and 
less common for devices to use more than one. Therefore, I was not sure 
if it made sense to allocate the gpmc_res struct dynamically as I doubt 
you will ever have a device using all 8 chip-selects ;-)

Also, I don't see where the gpmc_child->res and gpmc_child->num_res are 
actually used. Are these needed?

[snip]

>> Do we need to free irqs here?
>
> Irqs has been conveniently forgotten in this patch, in mainline, I could
> not find any platforms using GPMC irq. This can be added later once
> driver conversion is done, if required.

I just meant that if we allocate them during the probe maybe we should 
remove when exiting.

[snip]

>>> +	/* GPMC specific */
>>> +	unsigned		cs;
>>> +	unsigned long		mem_size;
>>> +	unsigned long		mem_start;
>>> +	unsigned long		mem_offset;
>>> +	struct gpmc_config	*config;
>>> +	unsigned		num_config;
>>> +	struct gpmc_timings	*timing;
>>> +};
>>> +
>>> +struct gpmc_pdata {
>>> +	/* GPMC_FCLK rate in picoseconds */
>>> +	unsigned long			fclk_rate;
>>
>> fclk_period
>>
>>> +	struct gpmc_device_pdata	*device_pdata;
>>> +	unsigned			num_device;
>>> +};
>>
>> Do you need both gpmc_pdata and gpmc_device_pdata? Would not a single
>> structure work?
>
> Gpmc_device_data is dedicated to each CS, gpmc_pdata is required
> at least to inform driver about clock rate.

Ok, understood! So the struct gpmc_device_pdata only has a single 
chip-select entry and so looking at the code you will have multiple 
instances of this structure of a gpmc device that uses more than one 
chip-select. Any reason you did it this way and not have a single pdata 
struct for each device defining all chip-selects it uses?

> Generally, as the change involved moving a lot of code, seems more reviews
> are on those than the actual changes than what I intended to get reviewed,
> next patch series will be modified not to move existing code, hence some
> of your suggested changes may not be present in it, probably those to be
> done as another cleanup patch.

Yes I understand. However, it is a good opportunity to clean some of 
this up even if it is existing code :-)

Cheers
Jon
