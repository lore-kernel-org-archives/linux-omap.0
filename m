From: Tony Lindgren <tony@atomide.com>
Subject: Re: testing-board branch: rebase to RMK's devel-stable?
Date: Mon, 5 Sep 2011 03:31:35 -0700
Message-ID: <20110905103135.GF1903@atomide.com>
References: <87vcta7r9f.fsf@ti.com>
 <alpine.LFD.2.00.1109021446300.20358@xanadu.home>
 <alpine.LFD.2.00.1109021448120.20358@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:38064 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752478Ab1IEKbk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Sep 2011 06:31:40 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1109021448120.20358@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

* Nicolas Pitre <nicolas.pitre@linaro.org> [110902 11:25]:
> On Fri, 2 Sep 2011, Nicolas Pitre wrote:
> 
> > On Fri, 2 Sep 2011, Kevin Hilman wrote:
> > 
> > > Hi Tony,
> > > 
> > > Your testing-board branch currently has a couple new boards that are
> > > missing the boot_params to atag_offset conversion (patch below.)
> > > 
> > > There's a patch below to fix this, but maybe it's better to just rebase
> > > your testing-board branch onto Russell's devel-stable branch (where he's
> > > merged the seris from Nico) so any board stuff we add is sure to do it
> > > correctly.
> > 
> > I would suggest that too.
> 
> Better yet, if your bootloader does pass the address of the ATAG list 
> via r2 already (contemporary u-Boot versions do) then the 
> boot_params/atag_offset entry is redundant and can simply be dropped 
> upfront.

Yes we should be able to drop it then.

Tony
