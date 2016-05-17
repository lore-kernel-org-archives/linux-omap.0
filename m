From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH v2 2/3] mfd: lp873x: Add lp873x PMIC support
Date: Tue, 17 May 2016 13:34:24 +0530
Message-ID: <573AD088.9090600@ti.com>
References: <1462853079-10708-1-git-send-email-j-keerthy@ti.com>
 <1462853079-10708-3-git-send-email-j-keerthy@ti.com>
 <20160512131846.GB1433@dell.open.watershed.co.uk> <57350E17.3000209@ti.com>
 <20160517080130.GG17238@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160517080130.GG17238@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Keerthy <j-keerthy@ti.com>, broonie@kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
List-Id: linux-omap@vger.kernel.org



On Tuesday 17 May 2016 01:31 PM, Lee Jones wrote:
> On Fri, 13 May 2016, Keerthy wrote:
>> On Thursday 12 May 2016 06:48 PM, Lee Jones wrote:
>>> On Tue, 10 May 2016, Keerthy wrote:
>>>
>>>> The LP873X chip is a power management IC for Portable Navigation Systems
>>>>      and Tablet Computing devices. It contains the following components:
>>>>
>>>>       - Regulators.
>>>>       - Configurable General Purpose Output Signals(GPO).
>>>>
>>>> PMIC interacts with the main processor through i2c. PMIC has
>>>> couple of LDOs(Linear Regulators), couple of BUCKs (Step-Down DC-DC
>>>> Converter Cores) and GPOs(General Purpose Output Signals). At this
>>>> time only the regulator functionality is made available.
>>>>
>>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>>> ---
>>>>
>>>> Changes in v2:
>>>>
>>>>    * Used mfd_add_devices instead of of_pltaform_populate.
>>>
>>> Didn't see this conversation, but of_platform_populate () is usually
>>> okay?
>>
>> https://lkml.org/lkml/2016/5/6/244.
>
> Did Mark tell you why you shouldn't be using it?

"You shouldn't be using that, you should just have a table of subdevices
in the MFD"

I inferred not to use of_platform_populate and make use of 
mfd_add_devices instead.

Please correct me if am wrong.

>
>>>>   drivers/mfd/Kconfig        |  15 +++
>>>>   drivers/mfd/Makefile       |   2 +
>>>>   drivers/mfd/lp873x.c       |  98 +++++++++++++++++
>>>>   include/linux/mfd/lp873x.h | 265 +++++++++++++++++++++++++++++++++++++++++++++
>>>>   4 files changed, 380 insertions(+)
>>>>   create mode 100644 drivers/mfd/lp873x.c
>>>>   create mode 100644 include/linux/mfd/lp873x.h
>
> [...]
>
>>>> +/**
>>>> + * struct lp873x - state holder for the lp873x driver
>>>> + * Device data may be used to access the LP873X chip
>>>> + */
>>>> +struct lp873x {
>>>> +	struct device *dev;
>>>> +	unsigned long id;
>>>> +	u8 rev;
>>>> +	struct mutex lp873_lock;	/* lock guarding the data structure */
>>>> +	struct regmap *regmap;
>>>
>>> Are all of these used in >1 driver?
>>
>> Apart from id and rev all are used.
>
> Then why are id and rev in there?
>
