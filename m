From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] [OMAP] GPIO Module disable if all pins inactive
Date: Sat, 24 Oct 2009 00:48:23 -0500
Message-ID: <4AE29527.3050402@ti.com>
References: <1256313317-24653-1-git-send-email-charu@ti.com>,<4AE24BD7.2040506@ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB02BA31ADE5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40028 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751541AbZJXFsU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 24 Oct 2009 01:48:20 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9O5mOmU005810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sat, 24 Oct 2009 00:48:24 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id n9O5mOq6009579
	for <linux-omap@vger.kernel.org>; Sat, 24 Oct 2009 00:48:24 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9O5mOHi007503
	for <linux-omap@vger.kernel.org>; Sat, 24 Oct 2009 00:48:24 -0500 (CDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BA31ADE5@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charu Latha" <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Varadarajan, Charu Latha had written, on 10/23/2009 11:05 PM, the following:
>>>  #endif
>>> +     if (cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
>>> +             if (!bank->>gpio_status) {
>>> +                     ctrl = __raw_readl(bank->>base + OMAP24XX_GPIO_CTRL);
>>> +                     /* Module is enabled, clocks are not gated */
>>> +                     ctrl &= 0xFFFFFFFE;
>>> +                     __raw_writel(ctrl, bank->>base + OMAP24XX_GPIO_CTRL);
>>> +             }
>>> +             bank->>gpio_status |= 1 << offset;
>>> +     }
>> why do this every time a gpio is enabled? why not do this iff gpio was
>> never used before.. how about the following:
> The module is enabled only when gpio_status indicates that no GPIO 
> in that  module is currently active and the GPIO being requested is the 1st one 
> to be active in that module.
> Each module would be disabled in free() API when all GPIOs in a particular module 
> becomes inactive. The module is re-enabled in request() API when a GPIO is 
> requested from the module that was previously disabled.
Thanks.

>> if (!bank->>gpio_status && (cpu_is_omap24xx() || cpu_is_omap34xx() ||
>> cpu_is_omap44xx())) {
>>        u32 ctrl = __raw_readl(bank->>base + OMAP24XX_GPIO_CTRL);
>>        /* Module is enabled, clocks are not gated */
>>        ctrl &= 0xFFFFFFFE;
>>        __raw_writel(ctrl, bank->>base + OMAP24XX_GPIO_CTRL);
>> }
>> bank->>gpio_status |= 1 << offset;
> Why to touch gpio_status if not used (for other than 34xx/24xx/44xx cases)? 
either the gpio_status should be under a #ifdef for 34xx when defining 
or it should be usable by all. what it does now is do both.

my proposal is to allow gpio_status to be usable by ALL OMAPs -> maybe 
OMAP1 also could also use it.. I cannot comment - but it does look to 
have scope of usage beyond omap2/3/4 series?

-- 
Regards,
Nishanth Menon
