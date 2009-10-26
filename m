From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH] [OMAP] GPIO Module disable if all pins inactive
Date: Mon, 26 Oct 2009 05:33:53 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C012AC2283B@dlee02.ent.ti.com>
References: <1256313317-24653-1-git-send-email-charu@ti.com>,<4AE24BD7.2040506@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BA31ADE5@dbde02.ent.ti.com>,<4AE29527.3050402@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BA31ADE6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52393 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755480AbZJZKdu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Oct 2009 06:33:50 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9QAXtTV002710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2009 05:33:55 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9QAXs2G023878
	for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2009 05:33:54 -0500 (CDT)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9QAXsRi001011
	for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2009 05:33:54 -0500 (CDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BA31ADE6@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charu Latha" <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> From: Varadarajan, Charu Latha
> Sent: Monday, October 26, 2009 4:07 AM
> 
> >>>>  #endif
> >>>> +     if (cpu_is_omap24xx() || cpu_is_omap34xx() ||
> cpu_is_omap44xx()) {
> >>>> +             if (!bank->>gpio_status) {
> >>>> +                     ctrl = __raw_readl(bank->>base +
> OMAP24XX_GPIO_CTRL);
> >>>> +                     /* Module is enabled, clocks are not gated */
> >>>> +                     ctrl &= 0xFFFFFFFE;
> >>>> +                     __raw_writel(ctrl, bank->>base +
> OMAP24XX_GPIO_CTRL);
> >>>> +             }
> >>>> +             bank->>gpio_status |= 1 << offset;
> >>>> +     }
> >>> why do this every time a gpio is enabled? why not do this iff gpio was
> >>> never used before.. how about the following:
> >> The module is enabled only when gpio_status indicates that no GPIO
> >> in that  module is currently active and the GPIO being requested is the
> 1st one
> >> to be active in that module.
> >> Each module would be disabled in free() API when all GPIOs in a
> particular module
> >> becomes inactive. The module is re-enabled in request() API when a GPIO
> is
> >> requested from the module that was previously disabled.
> >Thanks.
> Welcome
> >>> if (!bank->>gpio_status && (cpu_is_omap24xx() || cpu_is_omap34xx() ||
> >>> cpu_is_omap44xx())) {
> >>>        u32 ctrl = __raw_readl(bank->>base + OMAP24XX_GPIO_CTRL);
> >>>        /* Module is enabled, clocks are not gated */
> >>>        ctrl &= 0xFFFFFFFE;
> >>>        __raw_writel(ctrl, bank->>base + OMAP24XX_GPIO_CTRL);
> >>> }
> >>> bank->>gpio_status |= 1 << offset;
> >> Why to touch gpio_status if not used (for other than 34xx/24xx/44xx
> cases)?
> >either the gpio_status should be under a #ifdef for 34xx when defining
> >or it should be usable by all. what it does now is do both.
>  gpio_status is not used under  #ifdef for 34xx. It is used only with
> cpu_is_omap
> (34xx/24xx/44xx). Should we use both #ifdef and cpu_is_omap together? Why?
> But I don't see that approach in LO. For eg., usage of dbck_enable_mask is
> used only with cpu_is_omap and is not declared under  #ifdef.

Please see [1] saved_datain is an example of why I think gpio.c could go thru a cleanup ;) already in #ifdef in line 1908, in line 1925, we add a new #ifdef under a #ifdef :D.. err...

Ok this piece of code is not perfect.. 

Regards,
Nishanth Menon
[1] http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=blob;f=arch/arm/plat-omap/gpio.c;h=487bea7b5605fe366064d792d0c9cc8aed1eac63;hb=0bbf5337f2f2957775051a3caf60b66d3306c815#l174 
