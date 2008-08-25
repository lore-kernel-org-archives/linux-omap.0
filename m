From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] OMAP:MUSB: Fixes the TT programming.
Date: Sun, 24 Aug 2008 20:53:22 -0700
Message-ID: <20080825035322.GC3128@kroah.com>
References: <1219385613-20108-1-git-send-email-ajay.gupta@ti.com> <200808212330.06650.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200808212330.06650.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: ajay.gupta-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 21, 2008 at 11:30:06PM -0700, David Brownell wrote:
> On Thursday 21 August 2008, ajay.gupta-l0cyMroinI0@public.gmane.org wrote:
> > From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> > 
> > Fixes enumeration failures when a USB device attached to a LS hub
> > is connected to OMAP EVM via HS hub. This is fixed by correctly
> > programming hub address register in enqueue path.  
> > 
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> 
> Looks right to me, other than the lack of line wrapping in that
> summary (corrected above).  Moreover, there ought to be some way
> to make all high speed hosts share TT scheduling code ... ;)
> 
> Acked-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

Ok, for all MUSB patches, I'm going to wait until Felipe tells me to
accept them, as he's the subsystem/driver maintainer.

Felipe, is this ok?  Can you just bundle up what you feel is good and
send them to me when they are ready (usually as soon as possible)?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
