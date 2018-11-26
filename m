From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: omap5 fixing palmas IRQ_TYPE_NONE warning leads to gpadc timeouts
Date: Mon, 26 Nov 2018 11:49:54 +0200
Message-ID: <d3f17ac6-c13b-5b5f-a482-b565b130f1ba@ti.com>
References: <CAAfyv35bat+t6awL-VRigAoaUTySwOgZkQMs=W9mEKQ6VDW3FA@mail.gmail.com>
 <20180703084516.GT112168@atomide.com>
 <CAAfyv37F1s8Cg=pfxiN0dA6YEX7KMB-+uifjRoqAdKGWLeYEwA@mail.gmail.com>
 <20181113180656.GE53235@atomide.com>
 <46d271b2-35d3-6353-c530-3292cdac53ab@ti.com>
 <20181119161906.GP53235@atomide.com> <20181119171406.GQ53235@atomide.com>
 <725df8e7-4aff-3751-d0b0-809b89e882e5@nvidia.com>
 <20181123164827.GE53235@atomide.com> <20181126093625.GA10878@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181126093625.GA10878@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <treding@nvidia.com>, Tony Lindgren <tony@atomide.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, Belisko Marek <marek.belisko@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-omap@vger.kernel.org

Thierry,

On 11/26/18 11:36 AM, Thierry Reding wrote:
> On Fri, Nov 23, 2018 at 08:48:27AM -0800, Tony Lindgren wrote:
>> * Jon Hunter <jonathanh@nvidia.com> [181120 11:14]:
>>> On 19/11/2018 17:14, Tony Lindgren wrote:
>>>> Well so commit 7e9d474954f4 ("ARM: tegra: Correct polarity for
>>>> Tegra114 PMIC interrupt") states that tegra114 inverts the
>>>> polarity of the PMIC interrupt. So adding Jon and Thierry to Cc.
>>>
>>> Yes Tegra can invert the polarity of the PMIC interrupt.
>>
>> So is there some IP on Tegra called "Tegra PMC" that is
>> inverting the interrupt? Or is the "Tegra PMC" that commit
>> 7e9d474954f4 mentions just the palmas configuration for
>> inverting the interrupt?
> 
> Yes, there's indeed an IP called PMC (Power-Management Controller) on
> Tegra. It has a special input that is usually wired up to the PMIC
> interrupt and a bit in the control register that configures the polarity
> of that interrupt. If the PMIC generates a low-active interrupt we
> usually set that bit to make sure it is properly sampled by the PMC.
> 
> The symptoms of this being incorrectly configured is usually an
> interrupt storm on the PMIC interrupt, which I think typically results
> in the system not booting at all, or taking a very long time to boot
> because of that storm.
> 
>> The problem I'm having is With omap5 where I can only get the
>> PMIC interrupts working with IRQ_TYPE_LEVEL_HIGH if
>> PALMAS_POLARITY_CTRL_INT_POLARITY is not set unlike for
>> Tegra.
> 
> Does somebody have access to the Palmas documentation? That should
> pretty clearly state what the default polarity is and what it changes to
> if you set the interrupt polarity bit.

The register map documentation I have states the following:
bit7 INT_POLARITY Select the polarity of the INT output line
0: Interrupt line (INT) is low when interrupt is pending (default) RW
1: Interrupt line (INT) is high when interrupt is pending

By default the Palmas irq is active low.

> From what you're saying it sounds like either the logic is the wrong way
> around in the Palmas MFD driver (and we correct it by switching it back
> to the correct polarity in the PMC) or that you'd need to find some way
> of inverting in on OMAP5.
> 
> Thierry
> 

- Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
