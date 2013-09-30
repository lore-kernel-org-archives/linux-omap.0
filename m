From: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 1/6] DRIVERS: IRQCHIP: IRQ-GIC: Add support for routable
 irqs
Date: Mon, 30 Sep 2013 20:30:43 +0530
Message-ID: <5249921B.5020108@ti.com>
References: <1380549564-31045-1-git-send-email-r.sricharan@ti.com> <1380549564-31045-2-git-send-email-r.sricharan@ti.com> <524987A3.4090204@arm.com> <5249890B.7020906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5249890B.7020906-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Cc: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org" <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "rnayak-l0cyMroinI0@public.gmane.org" <rnayak-l0cyMroinI0@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Monday 30 September 2013 07:52 PM, Santosh Shilimkar wrote:
> On Monday 30 September 2013 10:16 AM, Marc Zyngier wrote:
>> On 30/09/13 14:59, Sricharan R wrote:
>>> In some socs the gic can be preceded by a crossbar IP which
>>> routes the peripheral interrupts to the gic inputs. The peripheral
>>> interrupts are associated with a fixed crossbar input line and the
>>> crossbar routes that to one of the free gic input line.
>>>
>>> The DT entries for peripherals provides the fixed crossbar input line
>>> as its interrupt number and the mapping code should associate this with
>>> a free gic input line. This patch adds the support inside the gic irqchip
>>> to handle such routable irqs. The routable irqs are registered in a linear
>>> domain. The registered routable domain's callback should be implemented
>>> to get a free irq and to configure the IP to route it.
>> Isn't this just another chained interrupt controller? How is it GIC
>> specific?
>>
> No it isn't a irq controller rather a event router. Patch is missing
> reference to the previous discussion. Previous discussion is here [1]
>
> Regards,
> Santosh
>
> [1] https://lkml.org/lkml/2013/9/13/413
>
Sorry, missed adding that and thanks for pointing it.

Regards,
 Sricharan

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
