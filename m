From: "Varadarajan, Charu Latha" <charu@ti.com>
Subject: RE: [PATCH] [OMAP] GPIO Module disable if all pins inactive
Date: Mon, 26 Oct 2009 14:37:03 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BA31ADE6@dbde02.ent.ti.com>
References: <1256313317-24653-1-git-send-email-charu@ti.com>,<4AE24BD7.2040506@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BA31ADE5@dbde02.ent.ti.com>,<4AE29527.3050402@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48567 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755294AbZJZJHE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Oct 2009 05:07:04 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9Q976AG009168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2009 04:07:08 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9Q975pt009975
	for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2009 14:37:05 +0530 (IST)
In-Reply-To: <4AE29527.3050402@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>>>>  #endif
>>>> +     if (cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
>>>> +             if (!bank->>gpio_status) {
>>>> +                     ctrl = __raw_readl(bank->>base + OMAP24XX_GPIO_CTRL);
>>>> +                     /* Module is enabled, clocks are not gated */
>>>> +                     ctrl &= 0xFFFFFFFE;
>>>> +                     __raw_writel(ctrl, bank->>base + OMAP24XX_GPIO_CTRL);
>>>> +             }
>>>> +             bank->>gpio_status |= 1 << offset;
>>>> +     }
>>> why do this every time a gpio is enabled? why not do this iff gpio was
>>> never used before.. how about the following:
>> The module is enabled only when gpio_status indicates that no GPIO
>> in that  module is currently active and the GPIO being requested is the 1st one
>> to be active in that module.
>> Each module would be disabled in free() API when all GPIOs in a particular module
>> becomes inactive. The module is re-enabled in request() API when a GPIO is
>> requested from the module that was previously disabled.
>Thanks.
Welcome
>>> if (!bank->>gpio_status && (cpu_is_omap24xx() || cpu_is_omap34xx() ||
>>> cpu_is_omap44xx())) {
>>>        u32 ctrl = __raw_readl(bank->>base + OMAP24XX_GPIO_CTRL);
>>>        /* Module is enabled, clocks are not gated */
>>>        ctrl &= 0xFFFFFFFE;
>>>        __raw_writel(ctrl, bank->>base + OMAP24XX_GPIO_CTRL);
>>> }
>>> bank->>gpio_status |= 1 << offset;
>> Why to touch gpio_status if not used (for other than 34xx/24xx/44xx cases)?
>either the gpio_status should be under a #ifdef for 34xx when defining
>or it should be usable by all. what it does now is do both.
 gpio_status is not used under  #ifdef for 34xx. It is used only with cpu_is_omap
(34xx/24xx/44xx). Should we use both #ifdef and cpu_is_omap together? Why? 
But I don't see that approach in LO. For eg., usage of dbck_enable_mask is 
used only with cpu_is_omap and is not declared under  #ifdef.

>my proposal is to allow gpio_status to be usable by ALL OMAPs -> maybe
>OMAP1 also could also use it.. I cannot comment - but it does look to
>have scope of usage beyond omap2/3/4 series?
Even though OMAP1 supports the same feature, I am not including it as I
cannot test it and I am not sure about it in OMAP1. For 24xx, 34xx & 44xx, 
the registers used and offsets are all the same. So the same code is reused. 