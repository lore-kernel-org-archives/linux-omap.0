From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v3 2/4] ARM: OMAP2/3: intc: Add DT support for TI interrupt
 controller
Date: Wed, 15 Feb 2012 14:09:56 +0100
Message-ID: <4F3BAEA4.6060901@ti.com>
References: <1329242172-4214-1-git-send-email-b-cousson@ti.com> <1329242172-4214-3-git-send-email-b-cousson@ti.com> <4F3ABA77.8010303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48010 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752152Ab2BONKN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Feb 2012 08:10:13 -0500
In-Reply-To: <4F3ABA77.8010303@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 2/14/2012 8:48 PM, Rob Herring wrote:
> On 02/14/2012 11:56 AM, Benoit Cousson wrote:
>> Add a function to initialize the OMAP2/3 interrupt controller (INTC)
>> using a device tree node.
>>
>> This version take advantage of the new irq_domain_add_legacy API.
>>
>> Replace some printk() with the proper pr_ macro.
>>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Cc: Tony Lindgren<tony@atomide.com>
>> Cc: Rob Herring<rob.herring@calxeda.com>
>> Cc: Grant Likely<grant.likely@secretlab.ca>
>
> Given that you plan to do gen irqchip:

Yes, I will. I even already have to patch, but I'm just trying to 
minimize the dependency since I'd like that to be merged for 3.4.
That series already missed 3.3.

> Acked-by: Rob Herring<rob.herring@calxeda.com>

Thanks,
Benoit
