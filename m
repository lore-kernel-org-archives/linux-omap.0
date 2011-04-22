From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH] ARM: Fix relocation if image end past uncompressed kernel
 end
Date: Fri, 22 Apr 2011 10:12:01 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1104220959440.24613@xanadu.home>
References: <1303272904-31392-1-git-send-email-nicolas.pitre@linaro.org> <20110420072156.GA28679@atomide.com> <alpine.LFD.2.00.1104200850030.24613@xanadu.home> <20110420165514.GE10402@atomide.com> <alpine.LFD.2.00.1104201318040.24613@xanadu.home>
 <20110421055945.GB13688@atomide.com> <20110421104954.GH13688@atomide.com> <alpine.LFD.2.00.1104210919070.24613@xanadu.home> <alpine.LFD.2.00.1104211711240.24613@xanadu.home> <alpine.LFD.2.00.1104212233170.24613@xanadu.home>
 <20110422062843.GA841@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48848 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755541Ab1DVOME (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Apr 2011 10:12:04 -0400
Received: by qyk7 with SMTP id 7so347237qyk.19
        for <linux-omap@vger.kernel.org>; Fri, 22 Apr 2011 07:12:03 -0700 (PDT)
In-Reply-To: <20110422062843.GA841@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Shawn Guo <shawn.guo@freescale.com>, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Aaro Koskinen <aaro.koskinen@nokia.com>, linux-omap@vger.kernel.org

On Thu, 21 Apr 2011, Tony Lindgren wrote:

> * Nicolas Pitre <nicolas.pitre@linaro.org> [110421 20:20]:
> > I found the bugger.  The problem was a bad stack alignment.
> 
> .. as this patch won't solve the n900 booting problem with zImage.
> With LZMA I'm still also getting "LZMA data is corrupt".

Hmmm......

Is it possible you have bad RAM?  In compressed/head.S, locate this 
code:

#ifdef CONFIG_AUTO_ZRELADDR
                @ determine final kernel image address
                mov     r4, pc
                and     r4, r4, #0xf8000000
                add     r4, r4, #TEXT_OFFSET
#else
                ldr     r4, =zreladdr
#endif

Right after that, simply override r4 with a physical address towards the 
end of the RAM, say 8MB before end of RAM (unless your decompressed 
kernel is larger than that).  That won't make a booting system, but at 
least you will be able to test the decompressor when loaded at various 
locations in memory without involving the relocation loop.


Nicolas
