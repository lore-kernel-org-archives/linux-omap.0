From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH] usb: ehci: fix update qtd->token in qh_append_tds
Date: Mon, 29 Aug 2011 11:03:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1108291046540.2525-100000@iolanthe.rowland.org>
References: <CACVXFVOvw6bSfcOYR2RWJO=k1WLgSCUygmSwZmtRDdM_tZNWEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACVXFVOvw6bSfcOYR2RWJO=k1WLgSCUygmSwZmtRDdM_tZNWEA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Santosh <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, 29 Aug 2011, Ming Lei wrote:

> IMO, the dummy has been linked into queue pointed by qh->hw->hw_qtd_next,
> so EHCI will fetch dummy qtd and execute the transaction and will not have
> any delay on the transaction.
> 
> Let me explain the problem again: On ARM, the wmb() before
> 'dummy->hw_token = token;'
> will flush l2 write buffer into memory and all parts of 'dummy' except
> for hw_token field
> have reached into memory already, but dummy->hw_token will stay at l2
> write buffer
> and not reach into memory at this time, so ehci may fetch a
> inconsistent qtd and execute it,
> then mistaken IOC or "total bytes to transfer"  are read by EHCI and
> cause delayed irq
> or lost irq.

No.  Even if the HC reads dummy before dummy->hw_token has been written
out to memory from the L2 cache, it will not see any inconsistencies.  
It will see the old value in hw_token, which has the ACTIVE bit clear.  
Therefore it will not try to execute the qTD but will move on to the
next QH.  See what the fourth paragraph in section 4.10.2 of the EHCI 
spec says about the case where a qTD's ACTIVE bit is set to 0.

Some EHCI implementations have a quirk, in which they perform the 
overlay even when ACTIVE is clear.  But even these implementations 
won't try to execute the qTD, because the old value of dummy->hw_token 
also has the HALT bit set.

> It is not only a reasoning or guess, and I have traced this kind of
> fact certainly.

If your controller behaves as you suggest then it is buggy.  And in
that case, adding another memory barrier won't fix it.  There is still
the possibility that the HC will read dummy during the brief time after
the existing wmb() and before the CPU has written dummy->hw_token.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
