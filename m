From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v3 4/5] dma: cppi41: only allocate descriptor memory once
Date: Tue, 01 Oct 2013 18:57:44 +0200
Message-ID: <524AFF08.7080206@gmail.com>
References: <1379861404-8250-1-git-send-email-zonque@gmail.com> <1379861404-8250-5-git-send-email-zonque@gmail.com> <20130926082604.GA24205@linutronix.de> <524AC987.5000301@gmail.com> <524AF6AF.50704@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:49839 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964Ab3JAQ55 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Oct 2013 12:57:57 -0400
In-Reply-To: <524AF6AF.50704@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de, sergei.shtylyov@cogentembedded.com, vinod.koul@intel.com, dan.j.williams@intel.com, balbi@ti.com, gregkh@linuxfoundation.org

On 01.10.2013 18:22, Sebastian Andrzej Siewior wrote:
> On 10/01/2013 03:09 PM, Daniel Mack wrote:

>> A simplified version of the code as it stands is:
>>
>>   for (i = 0; i < DESCS_AREAS; i++)
>>     cdd->cd = dma_alloc_coherent(dev, ..., &cdd->descs_phys, GFP_KERNEL);
>>
>>   for (i = 0; i < DESCS_AREAS; i++)
>>     dma_free_coherent(dev, mem_decs, cdd->cd, cdd->descs_phys);

...

>> So, after all, my patch doesn't really change any of the runtime
>> behaviour. Consider it a cosmetic cleanup if you wish :)
> 
> But it looks strange (in my opinion at least).

I still disagree, but maybe that doesn't matter any more, because ...

> But now, that I look
> again at it yes you moved the alloc out of the loop and replaced
> mem_decs with the computation. So nothing changed but you moved it
> outside.
> 
> Right I think one desc area should be enough so I would just remove the
> for loop and DESCS_AREAS as well. How does this sound to you?

That sound's like a good idea. Everything that make the driver smaller
and easier to understand is certainly a good thing :)

So we can drop this patch favor of your cleanup. However, I appreciate
if you did it on top of the second round of patches I sent today please,
because my resume() implementation uses DESCS_AREAS as well.


Thanks,
Daniel
