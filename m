From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [RFT/RFC/PATCH 00/31] arm: omap: irq: cleanup INTC driver
Date: Fri, 3 Jan 2014 17:42:41 +0530
Message-ID: <52C6A939.70708@ti.com>
References: <1384970958-4118-1-git-send-email-balbi@ti.com> <20131219184815.GU27438@atomide.com> <20131219232153.GE707@saruman.home> <20131221005309.GH26054@atomide.com> <20131223173409.GA10536@saruman.home> <20140102220101.GA8652@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46256 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751099AbaACMNM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Jan 2014 07:13:12 -0500
In-Reply-To: <20140102220101.GA8652@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

[]..

>>> so a bit more work is needed. Maybe also rebase these against
>>> omap-for-v3.14/dt too?
>>
>> Will do.
> 
> Rebased on top of omap-for-v3.14/omap3-board-removal. Patches are on my
> k.org tree:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git wip/omap-fix-intc

It needs a minor build fix though..

diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-omap-intc.c
index b58c5d5..d03b5a3 100644
--- a/drivers/irqchip/irq-omap-intc.c
+++ b/drivers/irqchip/irq-omap-intc.c
@@ -151,7 +151,7 @@ static void omap_mask_ack_irq(struct irq_data *d)
 static void omap_suspend_irq(struct irq_data *d)
 {
        omap_intc_save_context();
-       omap3_intc_prepare_idle();
+       omap_intc_prepare_idle();
 
        /* A pending interrupt would prevent OMAP from entering suspend */
        omap_ack_irq(NULL);

regards,
Rajendra

> 
> cheers
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

