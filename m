From: Sricharan R <r.sricharan@ti.com>
Subject: Re: [PATCH 1/3] misc: Add crossbar driver
Date: Thu, 25 Jul 2013 00:13:53 +0530
Message-ID: <51F02069.3050207@ti.com>
References: <1374165830-6367-1-git-send-email-r.sricharan@ti.com> <1374165830-6367-2-git-send-email-r.sricharan@ti.com> <51E83A4F.5080904@ti.com> <CACRpkdY3nQaWimTwB-Zt-8+Q_KZr8a0rpB1SUQq=AuoG4bAYnQ@mail.gmail.com> <51ED2385.60108@ti.com> <51ED5C66.1010407@ti.com> <51EFFBE1.4090505@ti.com> <51F0031B.1050307@ti.com> <51F00530.9090703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51F00530.9090703@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, ext Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Rajendra Nayak <rnayak@ti.com>, Felipe Balbi <balbi@ti.com>, Thomas Gleixner <tglx@linutronix.de>, Grant Likely <grant.likely@secretlab.ca>
List-Id: linux-omap@vger.kernel.org

On Wednesday 24 July 2013 10:17 PM, Nishanth Menon wrote:
> On 07/24/2013 11:38 AM, Santosh Shilimkar wrote:
>> On Wednesday 24 July 2013 12:08 PM, Nishanth Menon wrote: 
>>> That said, maybe a intermediate pinctrl approach might be more pragmatic and less theoretically flexible.
>>> an option might be to "statically allocate" default number of interrupts to a domain - example:
>>> * GIC IRQ 72->78 allotted to UARTs
>>> * pinctrl mapping provided for those but only 6 can be used (rest are marked status="disabled" as default) at any given time (choice of pinctrl option determines GIC interrupt line to use)
>>> * All modules will have a pinctrl definition to have a mapping - to avoid bootloader overriding default cross bar setting in ways un-expected by kernel.
>>>
>>> Does that sound fair trade off?
>> This sounds better. That way we can get all the devices in the DT at least.
>
> Fair enough - if Linus and Tony are still ok with this approach to the problem, seeing a patch series with the effect would be beneficial.
>
 Ok, i will use this idea of certain number interrupts to groups.
Yes on DRA7XX, we have about 160 gic lines and 320 irq crossbar device inputs contending for it.
1:2 and fully arbitrary.  But will we be really exhausting them ?

Regards,
 Sricharan
