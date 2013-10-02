From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 0/3] dma: cppi41: more suspend/resume patches
Date: Wed, 02 Oct 2013 14:57:17 +0200
Message-ID: <524C182D.7040901@linutronix.de>
References: <1380634271-27588-1-git-send-email-zonque@gmail.com> <20131002102033.GB16680@linutronix.de> <524BFE60.6050707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:42845 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945Ab3JBM5W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Oct 2013 08:57:22 -0400
In-Reply-To: <524BFE60.6050707@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de, vinod.koul@intel.com, dan.j.williams@intel.com, balbi@ti.com

On 10/02/2013 01:07 PM, Daniel Mack wrote:
> No, as stated, the line numbers in the kernel message are somewhat off
> due to added debugging code. What kicks in here is this one:
> 
>         if (!c->td_desc_seen) {
>                 desc_phys = cppi41_pop_desc(cdd, c->q_comp_num);
>                 if (desc_phys) {
>                         __iormb();
>                         WARN_ON(c->desc_phys != desc_phys);
>                         c->td_desc_seen = 1;
>                 }
>         }

Ach okay. So something completed but it wasn't the expected descriptor.

>> So you get the warning because
>> you tried to stop a channel which was not busy. But then you should not
>> be called at all because cppi41_dma_channel_abort() shouldn't call dma
>> driver on idle channels.
> 
> However, I see nothing that forbids you from calling
> dmaengine_terminate_all() on idle channels. If that's not handled
> properly by the cppi driver, I'd say it needs fixing.

No argue about that.

>> How does your suspend & resume thingy work? Is it completly shutdown
>> i.e. powered off? According to you earlier patches I would assume so. In
>> that case the request is not enqueued and there is nothing to be removed
>> from the engine, right?
> 
> No, my debugging showed that the channel has actually been prepared and
> submitted before. It's just being torn down shortly after that. That's
> what makes be believe in a race condition here.

I see.

> Thanks,
> Daniel

Sebastian
