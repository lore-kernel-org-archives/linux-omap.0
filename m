From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM OMAP: Fix race in OMAP2/3 DMA IRQ handling
Date: Thu, 22 Jan 2009 17:27:48 -0800
Message-ID: <20090123012744.GH7172@atomide.com>
References: <20090121172409.GA23967@mail.solidboot.com> <EAF47CD23C76F840A9E7FCE10091EFAB02A39CE60B@dbde02.ent.ti.com> <49782AAF.4070506@solidboot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53855 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763469AbZAWB1v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Jan 2009 20:27:51 -0500
Content-Disposition: inline
In-Reply-To: <49782AAF.4070506@solidboot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Juha Yrjola <juha.yrjola@solidboot.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Juha Yrjola <juha.yrjola@solidboot.com> [090122 00:34]:
> Shilimkar, Santosh wrote:
>>> --- a/arch/arm/plat-omap/dma.c
>>> +++ b/arch/arm/plat-omap/dma.c
>>> @@ -1898,11 +1898,11 @@ static int omap2_dma_handle_ch(int ch)
>>>  		status = dma_read(CSR(ch));
>>>  	}
>>>  +	dma_write(status, CSR(ch));
>> This is not necessary. Refers line  "dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR(ch));" just above.
>
> Yes, the current DMA code is full of inconsistencies and illogic. In  
> general, clearing a hard-coded mask of bits in an IRQ status register is  
> a nice way to enter a race with the machine. And that's a race you  
> cannot win every time, so you'll miss IRQs that you haven't handled yet.
>
> A major cleanup should be done to the DMA code, but that's no reason not  
> to fix bugs now.
>
>> It will any way do the job of clearing. In a way, clear done after
>> the  callback has no effect since the status reg and global IRQ_enable for
>> the particular channel is already disabled before that.
>
> Yes, in a way that completely ignores the code and hardware behaviour.
>
> If you write a 1 to, say, the FRAME bit of the CSR *after* a transfer  
> has been completed, *before* handling the event, you lose the CSR value,  
> so the channel handling function complains (correctly) about a spurious  
> IRQ and refuses to do anything more productive.
>
> If you start a quick transfer from the callback function, the FRAME bit  
> *will* get set before control returns from the callback function.
>
>> So dma library is safe from the problem you have described.
>
> Sounds like you're in denial, man. I didn't just randomly send a patch,  
> I actually ran into the problem, fixed it, verified it indeed is fixed,  
> and only after that did I send it.

Pushed to l-o master and omap-2.6.28 branches, and added to omap-fixes
queue for the mainline.

Tony
