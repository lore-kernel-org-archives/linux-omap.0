From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: Fix relocation if image end past uncompressed
 kernel end
Date: Tue, 26 Apr 2011 11:57:00 +0300
Message-ID: <20110426085700.GJ16892@atomide.com>
References: <alpine.LFD.2.00.1104200850030.24613@xanadu.home>
 <20110420165514.GE10402@atomide.com>
 <alpine.LFD.2.00.1104201318040.24613@xanadu.home>
 <20110421055945.GB13688@atomide.com>
 <20110421104954.GH13688@atomide.com>
 <alpine.LFD.2.00.1104210919070.24613@xanadu.home>
 <alpine.LFD.2.00.1104211711240.24613@xanadu.home>
 <alpine.LFD.2.00.1104212233170.24613@xanadu.home>
 <20110422062843.GA841@atomide.com>
 <alpine.LFD.2.00.1104220959440.24613@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:15075 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752466Ab1DZI5E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Apr 2011 04:57:04 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1104220959440.24613@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Shawn Guo <shawn.guo@freescale.com>, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Aaro Koskinen <aaro.koskinen@nokia.com>, linux-omap@vger.kernel.org

* Nicolas Pitre <nicolas.pitre@linaro.org> [110422 17:08]:
> On Thu, 21 Apr 2011, Tony Lindgren wrote:
> 
> > * Nicolas Pitre <nicolas.pitre@linaro.org> [110421 20:20]:
> > > I found the bugger.  The problem was a bad stack alignment.
> > 
> > .. as this patch won't solve the n900 booting problem with zImage.
> > With LZMA I'm still also getting "LZMA data is corrupt".
> 
> Hmmm......
> 
> Is it possible you have bad RAM?  In compressed/head.S, locate this 
> code:

This is happening on all n900 boards AFAIK.
 
> #ifdef CONFIG_AUTO_ZRELADDR
>                 @ determine final kernel image address
>                 mov     r4, pc
>                 and     r4, r4, #0xf8000000
>                 add     r4, r4, #TEXT_OFFSET
> #else
>                 ldr     r4, =zreladdr
> #endif
> 
> Right after that, simply override r4 with a physical address towards the 
> end of the RAM, say 8MB before end of RAM (unless your decompressed 
> kernel is larger than that).  That won't make a booting system, but at 
> least you will be able to test the decompressor when loaded at various 
> locations in memory without involving the relocation loop.

OK thanks, I'll take a look. I guess it could also be a cache flush
issue or borderline memory timings set in the bootloader.

Regards,

Tony
