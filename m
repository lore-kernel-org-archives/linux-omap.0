From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [ARM][OMAP] TWL4030 IRQ
Date: Wed, 24 Jun 2009 10:37:45 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B530E7E5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51510 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751768AbZFXFIO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Jun 2009 01:08:14 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>

Russell, 

After digging a bit, the proposed twl_irq change would need some major changes.

1. All the T2(TWL)drivers ( rtc, madc, bci, gpio, keypad, usb, mmc)needs modification. Currently twl_irq fw implements kind of "twl4030_irq_chip" which allows all the T2 drivers to get virtual interrupt numbers and can make use of standard "request_irq" linux api.
2.Above also helps to have useful entries like /proc/interrupts/rtc etc. With proposed change this also won't be available.
3. Register/unregister irq handlers to T2 from all the drivers


On the reported lock-up issue, I tried alternative to call mask/unmask functions with disabling local cpu interrupts. This worked for me but not sure whether it is entirely correct.

Something like this:
 static void handle_twl4030_pih(unsigned int irq, irq_desc_t *desc)
 {
+	unsigned long flags;
+
 	/* Acknowledge, clear *AND* mask the interrupt... */
+	local_irq_save(flags);
 	desc->chip->ack(irq);
+	local_irq_restore(flags);
 	complete(&irq_event);
 }

Do you think above approach is fine to get around the spin-lock lockup issue ? 
 
> -----Original Message-----
> From: Shilimkar, Santosh 
> Sent: Saturday, June 20, 2009 8:55 PM
> To: 'Tony Lindgren'; 'linux-omap@vger.kernel.org'
> Cc: 'Russell King - ARM Linux'
> Subject: [ARM][OMAP] TWL4030 IRQ
> 
> Just to brief you all, I came across a dead lock scenario on 
> the arm-smp kernel. After discussing with Russell on mailing 
> list, the actual bug seems be located in twl4030 IRQ implementation.
> 
> Initially I was suspecting the arm-generic area and hence 
> didn't include linux-omap list in the mail thread
> 
> For more information on this issue, please read this email thread.
> http://marc.info/?l=linux-arm-kernel&m=124550947525299&w=2
> 
> I will create a patch for "twl4030" and also would be 
> correcting upcoming "twl6030" accordingly.
> 
> If anyone on this mailing list has any other opinion, please 
> react to the email thread. 


Regards,
Santosh 