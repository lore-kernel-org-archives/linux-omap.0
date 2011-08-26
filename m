From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v5 03/22] gpio/omap: make gpio_context part of gpio_bank
 structure
Date: Fri, 26 Aug 2011 09:27:30 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0384A2340D@dbde02.ent.ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com>
	<1312455893-14922-4-git-send-email-tarun.kanti@ti.com>
	<4E53A0EE.5000703@ti.com> <87sjop5jfq.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48818 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752602Ab1HZD5r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Aug 2011 23:57:47 -0400
In-Reply-To: <87sjop5jfq.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Varadarajan, Charulatha" <charu@ti.com>

[...]
> 
> >> @@ -1494,33 +1490,31 @@ void omap2_gpio_resume_after_idle(void)
> >>   void omap_gpio_save_context(void)
> >>   {
> >>   	struct gpio_bank *bank;
> >> -	int i = 0;
> >>
> >>   	list_for_each_entry(bank,&omap_gpio_list, node) {
> >> -		i++;
> >>
> >>   		if (!bank->loses_context)
> >>   			continue;
> >>
> >> -		gpio_context[i].irqenable1 =
> >> +		bank->context.irqenable1 =
> >>   			__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE1);
> >> -		gpio_context[i].irqenable2 =
> >> +		bank->context.irqenable2 =
> >>   			__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE2);
> >
> > The context restore procedure should be done carefully. For instance
> > IRQ enabled register should be restored last to avoid any spurious
> > interrupts.
> 
> For the sake of clean, easy-to-review patches, this kind of functional
> change should be a separate patch.
> 
> The goal of $SUBJECT patch is simply to move the context struct into the
> bank struct, not change the order of the save restore.
> 
> Any changing of the order of save/restore should be in a dedicated patch
> with a descriptive changelog since that is changing behavior of the code.
Ok.

> 
> Kevin
