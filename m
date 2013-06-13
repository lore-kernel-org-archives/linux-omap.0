From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP: dma: Fix the kfree ordering
Date: Thu, 13 Jun 2013 19:18:58 +0530
Message-ID: <51B9CDCA.9010901@ti.com>
References: <1371128960-24822-1-git-send-email-rnayak@ti.com> <1371128960-24822-4-git-send-email-rnayak@ti.com> <20130613131647.GS21614@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38490 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754770Ab3FMNtd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Jun 2013 09:49:33 -0400
In-Reply-To: <20130613131647.GS21614@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thursday 13 June 2013 06:46 PM, Russell King - ARM Linux wrote:
> On Thu, Jun 13, 2013 at 06:39:20PM +0530, Rajendra Nayak wrote:
>> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
>> index 8a71f75..8e16503 100644
>> --- a/arch/arm/plat-omap/dma.c
>> +++ b/arch/arm/plat-omap/dma.c
>> @@ -2111,8 +2111,8 @@ exit_dma_irq_fail:
>>  	}
>>  
>>  exit_dma_lch_fail:
>> -	kfree(p);
>>  	kfree(d);
>> +	kfree(p);
> 
> Err.
> 
>         p = pdev->dev.platform_data;
>         d                       = p->dma_attr;
> 
> Why is it kfree'ing platform data in the first place?  This means that
> a failed bind can't be reattempted later.  It also means that an unbind
> plus rebind in userspace will free the platform data leaving stale
> pointers behind.

Right, I just seemed to have overlooked the fact that p was pointing to
platform data. Will remove all the kfree(p) and kfree(d) across the
driver (I just realized this is also the case in .remove)

> 
> This is totally nonsense.  Don't kfree() data in your driver which you
> haven't allocated yourself!
> 

