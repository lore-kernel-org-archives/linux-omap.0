From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] usb: ehci: fix update qtd->token in qh_append_tds
Date: Sat, 27 Aug 2011 16:06:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1108271548110.21403-100000@netrider.rowland.org>
References: <CACVXFVNz_ic_PPM_vNn1Dz85A2z94kRFso4rcqrvJfuLSqRSCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:33047 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751702Ab1H0UGb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Aug 2011 16:06:31 -0400
In-Reply-To: <CACVXFVNz_ic_PPM_vNn1Dz85A2z94kRFso4rcqrvJfuLSqRSCg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Greg KH <greg@kroah.com>, Santosh <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, USB list <linux-usb@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On Sun, 28 Aug 2011, Ming Lei wrote:

> I read the doc again, :-), and it mentions few about mb/wmb/rmb, I think
> my above description is still not correct. Generally speaking, mb only
> means there is a order between two accesses.
> 
> Now I think only one mb() after 'dummy->hw_token = token;' is enough:
> HC will read the up-to-date value of qtd->hw_token after mb() is executed
> because of the effect of the mb(), which should be guaranteed by mb.

I've been following this whole discussion.  I didn't understand the
idea behind the original patch, and I don't understand this.  What
reason is there for adding a memory barrier after the "dummy->hw_token
= token" line?  Such a barrier would not accomplish anything useful,
because there are no later memory accesses which need to be ordered
with respect to that line.

(By the way, Santosh appears to be right about the earlier wmb() in
this routine.  As far as I can see, it isn't needed.  David Brownell
probably wrote it just as a precaution.)

> > I mean others, please read the the last 3 lines of the comment and
> > compare that to the code lines you added.
> 
> I see now, the comment of the last 3 lines is wrong, should be
> 
>                         * inside L2 cache. 'token = dummy->hw_token'
>                          * after mb() is added for obeying correct mb()
>                          * usage.
> 
> But the 'token = dummy->hw_token' after mb() isn't needed any
> more as described above,  is it?

I don't see why it was ever needed at all.  The compiler will realize
that token is a dead variable at that point in the routine and will
optimize the new line away.

> The patch can make ehci HC see the up-to-date qtd, so make usb transaction
> executed correctly. If a qtd->token is not updated, maybe IOC is not set or set very
> late, so interrupt can't be triggered in time, also mistaken 'total bytes to transfer'
> can make HC work badly.

This doesn't make any sense.  qtd becomes the new dummy; by the time
the HC sees qtd the only important bit set in qtd->hw_token is the HALT
bit.

> In fact, I have traced the problem and found ehci irq is often delayed by ehci HC.
> also sometimes ehci irq is lost, so I start to trace ehci driver and find the problem here.

I don't think you have identified the underlying cause correctly.  
Something else must be responsible.

Alan Stern

