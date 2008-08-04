From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] MUSB: Workaround for simultaneous TX and RX usage
Date: Mon, 4 Aug 2008 17:17:34 +0300
Message-ID: <20080804141734.GG30539@gandalf.research.nokia.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02568EBABF@dbde02.ent.ti.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02568EBABF-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "ext Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Aug 04, 2008 at 06:48:22PM +0530, ext Gadiyar, Anand wrote:
> MUSB RTL v1.4 has a hardware issue which results in a DMA controller
> hang when TX and RX DMA channels are simultaneously enabled. This
> affects at least OMAP2430 and OMAP34XX.
> 
> Since RX transfers are in Mode 0 and anyway result in one DMA interrupt
> per packet, we can use System DMA to unload the RX fifos. MUSB DMA can
> be used for all TX channels as before.
> 
> Tested with full-duplex TX and RX transfers using g_ether. Runs for 24
> hours without a hang. Without this patch, the hang occurs within minutes.

This patch is not applying against linux-omap musb neither musb on
greg's queue. Could you please refresh it ? It's better to use the
version on greg's queue, if it fails for linux-omap I can prepare a
clean patch to avoid conflicts later.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
