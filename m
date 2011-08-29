From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] usb: ehci: fix update qtd->token in qh_append_tds
Date: Mon, 29 Aug 2011 12:33:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1108291218040.2525-100000@iolanthe.rowland.org>
References: <CACVXFVNFXh33tsvkM=jdnc8OocVhjkzpt6LK59zKa9L2F7HxpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:40193 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753866Ab1H2Qdo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Aug 2011 12:33:44 -0400
In-Reply-To: <CACVXFVNFXh33tsvkM=jdnc8OocVhjkzpt6LK59zKa9L2F7HxpQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, Santosh <santosh.shilimkar@ti.com>, USB list <linux-usb@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On Mon, 29 Aug 2011, Ming Lei wrote:

> Suppose HC can see the old value in hw_token, which has the ACTIVE bit clear.
> 
> The qtd transaction will not be executed until the new token is
> flushed into memory.
> From view of CPU, the irq is still be delayed because ioc irq is generated
> after the qtd transaction is executed when new token is flushed into
> memory. The delay
> depends on how long the token will be flushed into memory.

That's right.

> From my observation, the delay is commonly over 5ms for CSW, sometimes the delay
> is more than 20ms, so caused the bad performance.

No wonder!  Do you see the same sort of performance degradation when 
using shared memory to communicate between two CPUs?

Regardless, this is not quite the same as what you were talking about
earlier.  You specifically mentioned

	... so ehci may fetch a inconsistent qtd and execute it, then
	mistaken IOC or "total bytes to transfer" are read by EHCI and
	cause delayed irq or lost irq.

Bad performance is different from inconsistencies and lost IRQs.

> Also I am not sure if EHCI can read the old hw_token correctly in this kind of
> inconsistent memory state.

The memory state is NOT inconsistent!  It is consistent at all times, 
both before and after the new hw_token value is stored.  The memory 
state is just slow to update, that's all.  This is a speed issue, not a 
correctness issue.

Nevertheless, it remains true that you want to add a memory barrier
instruction simply in order to speed up a cache writeback, not to force
any sort of ordering.  This needs to be explained carefully in the code
(not just in the patch description!) and it needs to be done in a way
that won't affect other architectures.

Also, as you mentioned before, you may want to do the same thing in 
qh_link_async() just after the

	head->hw->hw_next = dma;

line.  Delays in flushing that write would also slow down performance.

Alan Stern

