From: Tony Lindgren <tony@atomide.com>
Subject: Re: Problems with 2430 NAND prefetch engine
Date: Fri, 11 Apr 2008 12:22:27 -0700
Message-ID: <20080411192227.GH7717@atomide.com>
References: <a46a26fd0804081733i469936d4m3315f3bb3270ff5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63856 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761522AbYDKTW3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 15:22:29 -0400
Content-Disposition: inline
In-Reply-To: <a46a26fd0804081733i469936d4m3315f3bb3270ff5@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Juha Kuikka <juha.kuikka@gmail.com>
Cc: linux-omap@vger.kernel.org

* Juha Kuikka <juha.kuikka@gmail.com> [080408 17:33]:
> Hi,
> 
> I am trying to use the NAND prefetch engine to speed up NAND access.
> 
> In GPMC CS0 is the NAND chip. GPMC_CONFIG7_0 is set to 0x0000084c by
> u-boot. Hence the address for this CS should be 0x0C000000.
> Documentation indicates that the FIFO should be accessible in any
> associated chip-select region after the engine has been enabled.
> 
> In linux I use ioremap() to map 0x0C000000 and use the returned
> pointer to access the prefetch engine FIFO.
> 
> Prefetch engine is configured and started.
> I get FIFOEVENT interrupt from it and try to read the fifo by using
> this ioremap's pointer but kernel crashes with:
> 
> Unhandled fault: external abort on non-linefetch (0x008) at 0xc4854000
> 0xc4854000 corresponds to the pointer ioremap() returned.
>
> Apparently I miss something either in HW or kernel but I cannot think
> of anything.
> Conventional access to the NAND chip through COMMAND/ADDRESS/DATA
> registers works ok.
> Any ideas would be appreciated.

Are you sure you have all the needed clocks on at this point? At least
gpmc_fck should be checked. Of course if access to gpmc works in
general, this is not the problem.

Tony
