From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap5 fixing palmas IRQ_TYPE_NONE warning leads to gpadc timeouts
Date: Mon, 19 Nov 2018 08:19:06 -0800
Message-ID: <20181119161906.GP53235@atomide.com>
References: <CAAfyv35bat+t6awL-VRigAoaUTySwOgZkQMs=W9mEKQ6VDW3FA@mail.gmail.com>
 <20180703084516.GT112168@atomide.com>
 <CAAfyv37F1s8Cg=pfxiN0dA6YEX7KMB-+uifjRoqAdKGWLeYEwA@mail.gmail.com>
 <20181113180656.GE53235@atomide.com>
 <46d271b2-35d3-6353-c530-3292cdac53ab@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <46d271b2-35d3-6353-c530-3292cdac53ab@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Belisko Marek <marek.belisko@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [181119 10:16]:
> On 2018-11-13 20:06, Tony Lindgren wrote:
> > Looks like the IRQ_TYPE_NONE issue still is there for omap5 and
> > should be fixed with IRQ_TYPE_HIGH.
> > 
> > No idea about why palmas interrupts would stop working though,
> > Peter, do you have any ideas on this one?
> 
> No, I don't.
> The INT polarity can be changed in Palmas.
> based on the pdata->irq_flags (queried via irqd_get_trigger_type())
> the code  configures it:
> 
> if (pdata->irq_flags & IRQ_TYPE_LEVEL_HIGH)
> 	reg = PALMAS_POLARITY_CTRL_INT_POLARITY;
> else
> 	reg = 0;
> 
> and we pass the same irq_flags to the regmap_add_irq_chip()
> IRQ_TYPE_LEVEL_HIGH == IRQF_TRIGGER_HIGH == 0x00000004
> 
> A change in DT should be enough, no need to patch palmas.c, imho.

But it's not. I'm now wondering if wakeupgen is inverting the
polarity for this interrupt?

GIC docs say this about SPI interrupts:

"SPI is triggered on a rising edge or is active-HIGH level-sensitive."

So when setting IRQ_TYPE_LEVEL_HIGH in dts, we still must not
invert the polarity in palmas while tegra needs to. So either
tegra114 hardware is inverting the polarity, or omap5 wakeupgen
is.

Does the palmas trm say which way PALMAS_POLARITY_CTRL
triggers if PALMAS_POLARITY_CTRL_INT_POLARITY is set?

Also note that dra7 is using a gpio for palmas interrupt.

Regards,

Tony
