From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 11/12] mfd: twl4030-irq: Return twl6030_mmc_card_detect
 IRQ for board setup
Date: Mon, 5 Mar 2012 09:29:54 +0100
Message-ID: <4F547982.9040900@ti.com>
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com> <1330707024-23730-12-git-send-email-b-cousson@ti.com> <4F523419.3080100@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52234 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993Ab2CEIaE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 03:30:04 -0500
In-Reply-To: <4F523419.3080100@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: sameo@linux.intel.com, tony@atomide.com, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Hi Sergei,

On 3/3/2012 4:09 PM, Sergei Shtylyov wrote:
> Hello.
>
> On 02-03-2012 20:50, Benoit Cousson wrote:
>
>> Card detect IRQ from the TWL6030 used to be provided to the MMC
>
>> controller code using a statically allocated IRQ scheme:
>>
>> card_detect_irq = TWL6030_IRQ_BASE + MMCDETECT_INTR_OFFSET;
>>
>> This is no longer valid in a SPARSE_IRQ context since there is no more
>> pre-defined TWL6030_IRQ_BASE.
>>
>> Return the proper card detect IRQ value in the
>> twl6030_mmc_card_detect_config
>> that will be called from the MMC controller.
>>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Cc: Felipe Balbi<balbi@ti.com>
>> Cc: Tony Lindgren<tony@atomide.com>
>> Cc: Rajendra Nayak<rnayak@ti.com>
>> ---
>> drivers/mfd/twl6030-irq.c | 3 ++-
>
> Subject talks about twl4030-irq.

Oops, good catch. thanks.

I guess that Tony's patch (mmc: omap_hsmmc: Simplify init for twl6030 
MMC card detect) will supersede that one.

Thanks,
Benoit
