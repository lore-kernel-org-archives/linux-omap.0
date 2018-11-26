From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: omap5 fixing palmas IRQ_TYPE_NONE warning leads to gpadc timeouts
Date: Mon, 26 Nov 2018 11:19:31 -0800
Message-ID: <92d5936c-d0c4-a12b-a363-116517ddfe64@oracle.com>
References: <CAAfyv35bat+t6awL-VRigAoaUTySwOgZkQMs=W9mEKQ6VDW3FA@mail.gmail.com>
 <20180703084516.GT112168@atomide.com>
 <CAAfyv37F1s8Cg=pfxiN0dA6YEX7KMB-+uifjRoqAdKGWLeYEwA@mail.gmail.com>
 <20181113180656.GE53235@atomide.com>
 <46d271b2-35d3-6353-c530-3292cdac53ab@ti.com>
 <20181119161906.GP53235@atomide.com> <20181119171406.GQ53235@atomide.com>
 <20181126101434.GB10878@ulmo> <20181126191405.GM53235@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181126191405.GM53235@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Thierry Reding <treding@nvidia.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Belisko Marek <marek.belisko@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Laxman Dewangan <ldewangan@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-omap@vger.kernel.org

On 11/26/2018 11:14 AM, Tony Lindgren wrote:
> * Thierry Reding <treding@nvidia.com> [181126 10:14]:
>> On Mon, Nov 19, 2018 at 09:14:06AM -0800, Tony Lindgren wrote:
>>> Well so commit 7e9d474954f4 ("ARM: tegra: Correct polarity for
>>> Tegra114 PMIC interrupt") states that tegra114 inverts the
>>> polarity of the PMIC interrupt. So adding Jon and Thierry to Cc.
>>>
>>> So it seems that commit df545d1cd01a ("mfd: palmas: Provide
>>> irq flags through DT/platform data") wrongly sets the
>>> PALMAS_POLARITY_CTRL_INT_POLARITY on IRQ_TYPE_LEVEL_HIGH
>>> while it should set it on IRQ_TYPE_LEVEL_LOW.
>>
>> Oops, sorry, you seem to have come to pretty much the same conclusion as
>> I did. I think what we need to do is find a copy of the TRM and see what
>> exactly the right behaviour is. Or we need to find someone that can take
>> measurements of the PMIC interrupt pin.
> 
> Yeah so either tegra inverts the PMIC interrupt twice now,
> or we have also omap5 wkupgen also inverting the PMIC interrupt
> once.. Santosh, do you remember if omap5 wkupgen might be
> inverting the palmas interrupt?
> 
 From the memory, omap5 wakeupgen doesn't invert the irqlines and
not anything specific to PMIC specially either.
