From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] ARM OMAP: Fix race in OMAP2/3 DMA IRQ handling
Date: Fri, 23 Jan 2009 10:05:33 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A39CEE9C@dbde02.ent.ti.com>
References: <20090121172409.GA23967@mail.solidboot.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02A39CE60B@dbde02.ent.ti.com>
 <49782AAF.4070506@solidboot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54121 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754547AbZAWEfs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Jan 2009 23:35:48 -0500
In-Reply-To: <49782AAF.4070506@solidboot.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Juha Yrjola <juha.yrjola@solidboot.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



Regards,
Santosh
 

> -----Original Message-----
> From: Juha Yrjola [mailto:juha.yrjola@solidboot.com] 
> Sent: Thursday, January 22, 2009 1:44 PM
> To: Shilimkar, Santosh
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] ARM OMAP: Fix race in OMAP2/3 DMA IRQ handling
> 
> Shilimkar, Santosh wrote:
> >> --- a/arch/arm/plat-omap/dma.c
> >> +++ b/arch/arm/plat-omap/dma.c
> >> @@ -1898,11 +1898,11 @@ static int omap2_dma_handle_ch(int ch)
> >>  		status = dma_read(CSR(ch));
> >>  	}
> >>  
> >> +	dma_write(status, CSR(ch));
> > This is not necessary. Refers line  
> "dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR(ch));" just above.
> 
> Yes, the current DMA code is full of inconsistencies and illogic. In 
> general, clearing a hard-coded mask of bits in an IRQ status 
> register is 
> a nice way to enter a race with the machine. And that's a race you 
> cannot win every time, so you'll miss IRQs that you haven't 
> handled yet.
> 
> A major cleanup should be done to the DMA code, but that's no 
> reason not 
> to fix bugs now.
> 
> > It will any way do the job of clearing. In a way, clear done after
> > the  callback has no effect since the status reg and global 
> IRQ_enable for
> > the particular channel is already disabled before that.
> 
> Yes, in a way that completely ignores the code and hardware behaviour.
> 
> If you write a 1 to, say, the FRAME bit of the CSR *after* a transfer 
> has been completed, *before* handling the event, you lose the 
> CSR value, 
> so the channel handling function complains (correctly) about 
> a spurious 
> IRQ and refuses to do anything more productive.
What you mean by *before* handling the event ? Do you mean the callback. Because status passed to the callback is read in the beginning of ISR. I agree with your point partly. Partly because I sill have a question in mind.
> If you start a quick transfer from the callback function, the 
> FRAME bit 
> *will* get set before control returns from the callback function.
> 
> > So dma library is safe from the problem you have described.
> 
> Sounds like you're in denial, man. I didn't just randomly 
> send a patch, 
> I actually ran into the problem, fixed it, verified it indeed 
> is fixed, 
> and only after that did I send it.
Not really in denail mode.I just couldn't visualise the issue completely. For that matter any patch fixes the bug is welcome :) 
Since DMA channel interrupt refelcts at two levels ( global DMA_IRQSTATUS and Cannel specific CSR), and global updates are independent of any mask, I was curious about the issue. We have already seen some spurious IRQ issue because of above when DMA hardware is being used by two independent software modules running together.  