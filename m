From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC PATCH] gpio/omap: Fix IRQ handling for SPARSE_IRQ
Date: Fri, 24 Feb 2012 11:11:10 +0100
Message-ID: <4F47623E.5060908@ti.com>
References: <4F46C1AF.2040201@ti.com> <20120223230821.GD18185@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58873 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670Ab2BXKLP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Feb 2012 05:11:15 -0500
In-Reply-To: <20120223230821.GD18185@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@secretlab.ca>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

+ Tarun

On 2/24/2012 12:08 AM, Tony Lindgren wrote:
> * Cousson, Benoit<b-cousson@ti.com>  [120223 14:14]:
>> The GPIO driver is still relying on internal OMAP IRQ defines that
>> are not relevant anymore if OMAP is built with SPARSE_IRQ.
>
> Great :)
>
>> Please note that this patch is still RFC, because I do not know
>> how to fix properly the ugly cpu_class_is_omap1 and the dependency
>> with IH_MPUIO_BASE to detect a MPUIO.
>
> Sounds like gpio_to_irq() needs to be set in the
> arch/arm/*omap*/gpio*.c then.

In fact, after a second thought, that might even work for OMAP1 because 
I'm using the proper base (IRQ and GPIO) to convert the IRQ number.

static int irq_to_gpio(struct gpio_bank *bank, unsigned int gpio_irq)
{
	return gpio_irq - bank->irq_base + bank->chip.base;
}

But it might be good to test it on OMAP1 platform.


Tarun,

Do you have an OMAP1 board to test that.

Regards,
Benoit
