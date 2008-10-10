From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: Git tree updated to v2.6.27, some issues remain
Date: Sat, 11 Oct 2008 03:58:05 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870239624A47@dbde02.ent.ti.com>
References: <20081010120427.GZ3044@atomide.com>
	 <200810100843.47808.david-b@pacbell.net>
 <5e088bd90810100857p2cea5429s810c9810f05bd341@mail.gmail.com>
 <FCCFB4CDC6E5564B9182F639FC3560870239624A2E@dbde02.ent.ti.com>
 <FCCFB4CDC6E5564B9182F639FC3560870239624A46@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42024 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbYJJW2T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2008 18:28:19 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870239624A46@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>, David Brownell <david-b@pacbell.net>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>


>Sent: Friday, October 10, 2008 5:15 PM
>To: Steve Sakoman; David Brownell; linux-omap@vger.kernel.org List
>Subject: RE: Git tree updated to v2.6.27, some issues remain
>
>>>>> Anything else not working right now?
>>>>
>>>> MUSB on Overo...
>>>
>
>Theory 2:
>When I debug on LDP board, I can see the failure happening in request_irq()
>
>In T2-probe:
>	request_irq( ... )
>		...
>		if (irq_desc[irq].status & IRQ_NOREQUEST)
>			return -EINVAL;	>>>> code returns from here !!!
>		...

This patch fixes the T2-probe request_irq() issue:

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 5983926..57cad7e 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -159,7 +159,7 @@ void __init omap_init_irq(void)
 	printk(KERN_INFO "Total of %ld interrupts on %d active controller%s\n",
 	       nr_irqs, nr_banks, nr_banks > 1 ? "s" : "");
 
-	for (i = 0; i < nr_irqs; i++) {
+	for (i = 0; i < NR_IRQS; /*nr_irqs;*/ i++) {
 		set_irq_chip(i, &omap_irq_chip);
 		set_irq_handler(i, handle_level_irq);
 		set_irq_flags(i, IRQF_VALID);

