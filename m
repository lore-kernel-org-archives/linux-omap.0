From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: omap5 fixing palmas IRQ_TYPE_NONE warning leads to gpadc timeouts
Date: Mon, 26 Nov 2018 10:13:56 +0000
Message-ID: <7d433094-4797-9bff-ba7b-325a706882c6@nvidia.com>
References: <CAAfyv35bat+t6awL-VRigAoaUTySwOgZkQMs=W9mEKQ6VDW3FA@mail.gmail.com>
 <20180703084516.GT112168@atomide.com>
 <CAAfyv37F1s8Cg=pfxiN0dA6YEX7KMB-+uifjRoqAdKGWLeYEwA@mail.gmail.com>
 <20181113180656.GE53235@atomide.com>
 <46d271b2-35d3-6353-c530-3292cdac53ab@ti.com>
 <20181119161906.GP53235@atomide.com> <20181119171406.GQ53235@atomide.com>
 <725df8e7-4aff-3751-d0b0-809b89e882e5@nvidia.com>
 <20181123164827.GE53235@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181123164827.GE53235@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Belisko Marek <marek.belisko@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Laxman Dewangan <ldewangan@nvidia.com>, Thierry Reding <treding@nvidia.com>
List-Id: linux-omap@vger.kernel.org


On 23/11/2018 16:48, Tony Lindgren wrote:
> * Jon Hunter <jonathanh@nvidia.com> [181120 11:14]:
>> On 19/11/2018 17:14, Tony Lindgren wrote:
>>> Well so commit 7e9d474954f4 ("ARM: tegra: Correct polarity for
>>> Tegra114 PMIC interrupt") states that tegra114 inverts the
>>> polarity of the PMIC interrupt. So adding Jon and Thierry to Cc.
>>
>> Yes Tegra can invert the polarity of the PMIC interrupt.
> 
> So is there some IP on Tegra called "Tegra PMC" that is
> inverting the interrupt? Or is the "Tegra PMC" that commit
> 7e9d474954f4 mentions just the palmas configuration for
> inverting the interrupt?
> 
> The problem I'm having is With omap5 where I can only get the
> PMIC interrupts working with IRQ_TYPE_LEVEL_HIGH if
> PALMAS_POLARITY_CTRL_INT_POLARITY is not set unlike for
> Tegra.

I see what you are saying and so technically we should not need to
invert with the Tegra PMC as well. This PMIC is used on the Tegra114
Dalmore board which was where I saw the original problem. However, I
have not tested this board for a while (and not part of our current
nightly testing). Do you know if something has changed recently?

Cheers
Jon

-- 
nvpublic
