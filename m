From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH 0/4] regulator: tps65917/palmas: Cleanups and bugfixes
Date: Fri, 8 Jul 2016 10:58:17 +0530
Message-ID: <577F39F1.3000203@ti.com>
References: <1462494592-27909-1-git-send-email-nm@ti.com>
 <572C444F.9070304@nvidia.com> <20160506171453.GX6292@sirena.org.uk>
 <572CEA22.2090300@ti.com> <573E9306.5050908@ti.com>
 <573EABD8.7040206@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <573EABD8.7040206@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>, Nishanth Menon <nm@ti.com>, Mark Brown <broonie@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Keerthy <j-keerthy@ti.com>, Stephen Warren <swarren@nvidia.com>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org



On Friday 20 May 2016 11:46 AM, Laxman Dewangan wrote:
>
> On Friday 20 May 2016 10:01 AM, Keerthy wrote:
>> + Lee Jones
>>
>> On Saturday 07 May 2016 12:31 AM, Nishanth Menon wrote:
>>> On 05/06/2016 12:14 PM, Mark Brown wrote:
>>>> On Fri, May 06, 2016 at 12:44:23PM +0530, Laxman Dewangan wrote:
>>>>
>>>>> When you are here, can you implement the dt parsing with the new
>>>>> method from
>>>>> regulator framework.
>>>>> Regulator FW calls callback to parse customized DT property, just
>>>>> need to
>>>>> pass the node and pointer when registering.
>>>>
>>>>> This will helps lots in cleanups and readability.
>>>>
>>>> Yes, please.
>>>>
>>> yeah, the driver has started showing it's age, it will be good to do a
>>> refactor.
>>
>> Laxman,
>>
>> I got the dt parsing with new method from regulator framework part, But
>> by new method do you also want to remove the dt compatible of
>> regulators and let only the mfd compatible stay?
>>
>> replace of_platform_populate with mfd_add_devices so that linux
>> handles the drivers split up and not the device tree?
>>
>
> The DT binding of child devices of the palmas are like that each sub
> node has compatible.
> So I dont think we can change this to avoid regression.
>
> However, if we make the child devices independent of the parent devices
> then it will be very useful to use across different PMIC if they have
> same IP.
> Currently, child devices are very much tightly coupled with parent
> devices for the register access and global structure member accces.
>
> This is exactly what we did for the max77686 RTC driver which is used by
> max77686, max77802 and max77620.
>
> There is two mfd core driver, max77686 and max77620 and uses same RTC
> driver rtc-max77686.c

Laxman,

Sorry for responding late on this thread. The new way of the dt parsing 
with the new method expects the driver to populate vsel_reg, vsel_mask,
enable_reg, enable_mask.

The inherent difference in palmas regulator driver w.r.t handling 
regulators is that this driver treats smps and ldo differently. It has 
separate read/write functions for both and goes by separate base 
addresses for spmp and ldo. Now to get all this unified under one 
regulator_desc array a lot of code churn would be needed in both header 
and C files. Not sure if that is okay.

Regards,
Keerthy
>
>
