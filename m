From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: testing-board branch: rebase to RMK's devel-stable?
Date: Fri, 2 Sep 2011 14:58:54 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1109021448120.20358@xanadu.home>
References: <87vcta7r9f.fsf@ti.com> <alpine.LFD.2.00.1109021446300.20358@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:37795 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754738Ab1IBS66 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Sep 2011 14:58:58 -0400
Received: by vxi9 with SMTP id 9so2345805vxi.19
        for <linux-omap@vger.kernel.org>; Fri, 02 Sep 2011 11:58:57 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1109021446300.20358@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Fri, 2 Sep 2011, Nicolas Pitre wrote:

> On Fri, 2 Sep 2011, Kevin Hilman wrote:
> 
> > Hi Tony,
> > 
> > Your testing-board branch currently has a couple new boards that are
> > missing the boot_params to atag_offset conversion (patch below.)
> > 
> > There's a patch below to fix this, but maybe it's better to just rebase
> > your testing-board branch onto Russell's devel-stable branch (where he's
> > merged the seris from Nico) so any board stuff we add is sure to do it
> > correctly.
> 
> I would suggest that too.

Better yet, if your bootloader does pass the address of the ATAG list 
via r2 already (contemporary u-Boot versions do) then the 
boot_params/atag_offset entry is redundant and can simply be dropped 
upfront.


Nicolas
