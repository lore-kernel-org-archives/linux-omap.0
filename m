From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] MUSB: Fix index register corruption seen with g_ether
	and Windows host
Date: Thu, 21 Aug 2008 17:58:07 +0300
Message-ID: <20080821145807.GD23346@gandalf.research.nokia.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02C3E31565@dbde02.ent.ti.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02C3E31565-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "ext Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: "greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org" <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 21, 2008 at 08:21:00PM +0530, ext Gadiyar, Anand wrote:
> From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
> 
> If Indexed Mode register accesses are enabled, the ep0_rxstate()
> function calls musb_g_ep0_giveback() before writing to the CSR
> register. When control returns to this ep0_rxstate, the index
> register contents are over-written. This causes the CSR register
> write to fail.
> 
> Fixed by writing the correct value into the index register before
> writing to the CSR.
> 
> This was observed only in ep0_rxstate() with g_ether loaded and
> the device connected to a MS Windows host PC. Anticipatively fixed
> ep0_txstate() as well.
> 
> Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>

Acked-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

> Fixed my mailer finally. :)

good :-)

> 
>  drivers/usb/musb/musb_gadget_ep0.c |    2 ++
>  1 files changed, 2 insertions(+)
> 
> Index: linux-omap-2.6/drivers/usb/musb/musb_gadget_ep0.c
> ===================================================================
> --- linux-omap-2.6.orig/drivers/usb/musb/musb_gadget_ep0.c	2008-04-14 15:36:38.000000000 +0530
> +++ linux-omap-2.6/drivers/usb/musb/musb_gadget_ep0.c	2008-08-21 18:12:11.688711634 +0530
> @@ -476,6 +476,7 @@ static void ep0_rxstate(struct musb *mus
>  			return;
>  		musb->ackpend = 0;
>  	}
> +	musb_ep_select(musb->mregs, 0);
>  	musb_writew(regs, MUSB_CSR0, tmp);
>  }
>  
> @@ -528,6 +529,7 @@ static void ep0_txstate(struct musb *mus
>  	}
>  
>  	/* send it out, triggering a "txpktrdy cleared" irq */
> +	musb_ep_select(musb->mregs, 0);
>  	musb_writew(regs, MUSB_CSR0, csr);
>  }
>  
-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
