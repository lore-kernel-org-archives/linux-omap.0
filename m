From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: omap5 fixing palmas IRQ_TYPE_NONE warning leads to gpadc timeouts
Date: Tue, 20 Nov 2018 17:52:56 +0530
Message-ID: <3f2dc0f7-8f01-d6a1-bc0d-8c2586f6091b@nvidia.com>
References: <CAAfyv35bat+t6awL-VRigAoaUTySwOgZkQMs=W9mEKQ6VDW3FA@mail.gmail.com>
 <20180703084516.GT112168@atomide.com>
 <CAAfyv37F1s8Cg=pfxiN0dA6YEX7KMB-+uifjRoqAdKGWLeYEwA@mail.gmail.com>
 <20181113180656.GE53235@atomide.com>
 <46d271b2-35d3-6353-c530-3292cdac53ab@ti.com>
 <20181119161906.GP53235@atomide.com> <20181119171406.GQ53235@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181119171406.GQ53235@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Belisko Marek <marek.belisko@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Jon Hunter <jonathanh@nvidia.com>, Thierry Reding <treding@nvidia.com>
List-Id: linux-omap@vger.kernel.org



On Monday 19 November 2018 10:44 PM, Tony Lindgren wrote:
> Hi,
>
> * Tony Lindgren <tony@atomide.com> [181119 16:19]:
>> * Peter Ujfalusi <peter.ujfalusi@ti.com> [181119 10:16]:
>>> On 2018-11-13 20:06, Tony Lindgren wrote:
>>>> Looks like the IRQ_TYPE_NONE issue still is there for omap5 and
>>>> should be fixed with IRQ_TYPE_HIGH.
>>>>
>>>> No idea about why palmas interrupts would stop working though,
>>>> Peter, do you have any ideas on this one?
>>> No, I don't.
>>> The INT polarity can be changed in Palmas.
>>> based on the pdata->irq_flags (queried via irqd_get_trigger_type())
>>> the code  configures it:
>>>
>>> if (pdata->irq_flags & IRQ_TYPE_LEVEL_HIGH)
>>> 	reg = PALMAS_POLARITY_CTRL_INT_POLARITY;
>>> else
>>> 	reg = 0;
>>>
>>> and we pass the same irq_flags to the regmap_add_irq_chip()
>>> IRQ_TYPE_LEVEL_HIGH == IRQF_TRIGGER_HIGH == 0x00000004
>>>
>>> A change in DT should be enough, no need to patch palmas.c, imho.
>> But it's not. I'm now wondering if wakeupgen is inverting the
>> polarity for this interrupt?
>>
>> GIC docs say this about SPI interrupts:
>>
>> "SPI is triggered on a rising edge or is active-HIGH level-sensitive."
>>
>> So when setting IRQ_TYPE_LEVEL_HIGH in dts, we still must not
>> invert the polarity in palmas while tegra needs to. So either
>> tegra114 hardware is inverting the polarity, or omap5 wakeupgen
>> is.
>>
>> Does the palmas trm say which way PALMAS_POLARITY_CTRL
>> triggers if PALMAS_POLARITY_CTRL_INT_POLARITY is set?
>>
>> Also note that dra7 is using a gpio for palmas interrupt.
> Well so commit 7e9d474954f4 ("ARM: tegra: Correct polarity for
> Tegra114 PMIC interrupt") states that tegra114 inverts the
> polarity of the PMIC interrupt. So adding Jon and Thierry to Cc.
>
> So it seems that commit df545d1cd01a ("mfd: palmas: Provide
> irq flags through DT/platform data") wrongly sets the
> PALMAS_POLARITY_CTRL_INT_POLARITY on IRQ_TYPE_LEVEL_HIGH
> while it should set it on IRQ_TYPE_LEVEL_LOW.

When I implemented, ARM GIC interrupt driver did not support the 
IRQ_TYPE_LEVEL_LOW. If we set this then it produces warning.
[Commit ID commit df545d1cd01aab3ba3f687d5423e6c3687b069d8
mfd: palmas: Provide irq flags through DT/platform data]

So from DT we can not really set the IRQ_TYPE_LEVEL_LOW as irq flag.
