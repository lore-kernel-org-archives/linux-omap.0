From: Juha Yrjola <juha.yrjola@solidboot.com>
Subject: Re: [PATCH] ARM OMAP: Fix race in OMAP2/3 DMA IRQ handling
Date: Thu, 22 Jan 2009 10:13:35 +0200
Message-ID: <49782AAF.4070506@solidboot.com>
References: <20090121172409.GA23967@mail.solidboot.com> <EAF47CD23C76F840A9E7FCE10091EFAB02A39CE60B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from solidboot.com ([92.48.122.80]:46157 "EHLO rei.solidboot.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751336AbZAVIes (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Jan 2009 03:34:48 -0500
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02A39CE60B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Shilimkar, Santosh wrote:
>> --- a/arch/arm/plat-omap/dma.c
>> +++ b/arch/arm/plat-omap/dma.c
>> @@ -1898,11 +1898,11 @@ static int omap2_dma_handle_ch(int ch)
>>  		status = dma_read(CSR(ch));
>>  	}
>>  
>> +	dma_write(status, CSR(ch));
> This is not necessary. Refers line  "dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR(ch));" just above.

Yes, the current DMA code is full of inconsistencies and illogic. In 
general, clearing a hard-coded mask of bits in an IRQ status register is 
a nice way to enter a race with the machine. And that's a race you 
cannot win every time, so you'll miss IRQs that you haven't handled yet.

A major cleanup should be done to the DMA code, but that's no reason not 
to fix bugs now.

> It will any way do the job of clearing. In a way, clear done after
> the  callback has no effect since the status reg and global IRQ_enable for
> the particular channel is already disabled before that.

Yes, in a way that completely ignores the code and hardware behaviour.

If you write a 1 to, say, the FRAME bit of the CSR *after* a transfer 
has been completed, *before* handling the event, you lose the CSR value, 
so the channel handling function complains (correctly) about a spurious 
IRQ and refuses to do anything more productive.

If you start a quick transfer from the callback function, the FRAME bit 
*will* get set before control returns from the callback function.

> So dma library is safe from the problem you have described.

Sounds like you're in denial, man. I didn't just randomly send a patch, 
I actually ran into the problem, fixed it, verified it indeed is fixed, 
and only after that did I send it.

Cheers,
Juha
