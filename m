From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: omap5 fixing palmas IRQ_TYPE_NONE warning leads to gpadc timeouts
Date: Mon, 26 Nov 2018 20:17:20 +0000
Message-ID: <149b3b6b-e52e-4942-151b-6df4358f5a7a@nvidia.com>
References: <CAAfyv37F1s8Cg=pfxiN0dA6YEX7KMB-+uifjRoqAdKGWLeYEwA@mail.gmail.com>
 <20181113180656.GE53235@atomide.com>
 <46d271b2-35d3-6353-c530-3292cdac53ab@ti.com>
 <20181119161906.GP53235@atomide.com> <20181119171406.GQ53235@atomide.com>
 <725df8e7-4aff-3751-d0b0-809b89e882e5@nvidia.com>
 <20181123164827.GE53235@atomide.com> <20181126093625.GA10878@ulmo>
 <d3f17ac6-c13b-5b5f-a482-b565b130f1ba@ti.com> <20181126102541.GC10878@ulmo>
 <20181126193212.GN53235@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181126193212.GN53235@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Thierry Reding <treding@nvidia.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Belisko Marek <marek.belisko@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-omap@vger.kernel.org


On 26/11/2018 19:32, Tony Lindgren wrote:
> * Thierry Reding <treding@nvidia.com> [181126 10:25]:
>> On Mon, Nov 26, 2018 at 11:49:54AM +0200, Peter Ujfalusi wrote:
>>> The register map documentation I have states the following:
>>> bit7 INT_POLARITY Select the polarity of the INT output line
>>> 0: Interrupt line (INT) is low when interrupt is pending (default) RW
>>> 1: Interrupt line (INT) is high when interrupt is pending
>>>
>>> By default the Palmas irq is active low.
>>
>> That would confirm that the driver code is correct. My understanding is
>> that the PMC on Tegra expects a low-active IRQ from the PMIC, so we need
>> to invert the interrupt again in the PMC.
> 
> But then why Tegra need to set PALMAS_POLARITY_CTRL_INT_POLARITY
> if dts has IRQ_TYPE_LEVEL_HIGH? Shouldn't the Palmas default low
> setting be correct for Tegra if PMC expects active-low interrupt
> and then inverts it for GIC?

So I think what is going on here is ...

1. For Tegra, the interrupt parent the palmas interrupt in DT is the GIC
   not the PMC. The PMC does not register an interrupt controller
   (although to be correct probably should have. I think it had been
    discussed in the past and Stephen W may know the history here). So
   the interrupt polarity has to be HIGH otherwise setting the trigger
   type in the GIC will fail (as it only supports rising edge or level
   high IIRC).
2. However, as Thierry mentioned the Tegra PMC wants an active low
   interrupt and so the PMC inverts it on entering the PMC. However,
   given that the GIC interrupts must be active high, the PMC must
   invert again between the PMC and GIC.

So looking back my description in the change 7e9d474954f4 was not quite
accurate because the interrupt from palmas is active high but the PMC
inverts it. I think that this is quite confusing because we don't have a
good way to describe this in the DT. If we made the PMC an interrupt
controller then it would probably be a lot clearer. However, for
historical reasons this was not done.

Cheers
Jon

-- 
nvpublic
