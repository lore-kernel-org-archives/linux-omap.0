From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/4] arm: omap: gpio: don't access irq_desc array
 directly
Date: Wed, 5 Jan 2011 08:47:22 +0200
Message-ID: <20110105064722.GC2458@legolas.emea.dhcp.ti.com>
References: <1294142577-28772-1-git-send-email-balbi@ti.com>
 <1294142577-28772-2-git-send-email-balbi@ti.com>
 <87r5cs42p1.fsf@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="b5gNqxB1S1yM7hjW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:46969 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751166Ab1AEGr2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jan 2011 01:47:28 -0500
Received: by eyh6 with SMTP id 6so6024815eyh.12
        for <linux-omap@vger.kernel.org>; Tue, 04 Jan 2011 22:47:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87r5cs42p1.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 04, 2011 at 04:24:58PM -0800, Kevin Hilman wrote:
> Felipe Balbi <balbi@ti.com> writes:
> 
> > Instead of accessing the irq_desc array directly
> > we can use irq_to_desc(irq). That will allow us to,
> > if wanted, select SPARSE_IRQ and irq_descs will be
> > added to a radix tree, instead of a array.
> >
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> 
> Can you refresh this one against Tony's omap-for-linus branch. The GPIO
> omap_device/hwmod conversion changed things around a bit and this patch
> doesn't apply.
> 
> After that, you can send separately, and I'll queue this one along with
> some other GPIO core fixes for the 2.6.38-rc series after -rc1 comes
> out.

Sure, it's attached to this mail.

-- 
balbi

--b5gNqxB1S1yM7hjW
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-arm-omap-gpio-don-t-access-irq_desc-array-directly.diff"

>From 8d216ccac14e4eebf259d5b40ed2d239248710e1 Mon Sep 17 00:00:00 2001
From: Felipe Balbi <balbi@ti.com>
Date: Wed, 5 Jan 2011 08:46:18 +0200
Subject: [PATCH] arm: omap: gpio: don't access irq_desc array directly
Organization: Texas Instruments\n

Instead of accessing the irq_desc array directly
we can use irq_to_desc(irq). That will allow us to,
if wanted, select SPARSE_IRQ and irq_descs will be
added to a radix tree, instead of a array.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/plat-omap/gpio.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 1f98e0b..197a6c0 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -756,8 +756,10 @@ static int gpio_irq_type(unsigned irq, unsigned type)
 	spin_lock_irqsave(&bank->lock, flags);
 	retval = _set_gpio_triggering(bank, get_gpio_index(gpio), type);
 	if (retval == 0) {
-		irq_desc[irq].status &= ~IRQ_TYPE_SENSE_MASK;
-		irq_desc[irq].status |= type;
+		struct irq_desc *d = irq_to_desc(irq);
+
+		d->status &= ~IRQ_TYPE_SENSE_MASK;
+		d->status |= type;
 	}
 	spin_unlock_irqrestore(&bank->lock, flags);
 
@@ -1671,7 +1673,9 @@ static void __init omap_gpio_chip_init(struct gpio_bank *bank)
 
 	for (j = bank->virtual_irq_start;
 		     j < bank->virtual_irq_start + bank_width; j++) {
-		lockdep_set_class(&irq_desc[j].lock, &gpio_lock_class);
+		struct irq_desc *d = irq_to_desc(j);
+
+		lockdep_set_class(&d->lock, &gpio_lock_class);
 		set_irq_chip_data(j, bank);
 		if (bank_is_mpuio(bank))
 			set_irq_chip(j, &mpuio_irq_chip);
-- 
1.7.3.4.598.g85356


--b5gNqxB1S1yM7hjW--
