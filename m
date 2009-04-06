From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] musb: refresh nop transceiver support for musb
Date: Mon, 6 Apr 2009 11:30:37 -0700
Message-ID: <200904061130.38325.david-b@pacbell.net>
References: <1239024889-28597-1-git-send-email-ajay.gupta@ti.com> <20090406134406.GG22170@scadufax.research.nokia.com> <19F8576C6E063C45BE387C64729E73940427EE8F27@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <19F8576C6E063C45BE387C64729E73940427EE8F27-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Monday 06 April 2009, Gupta, Ajay Kumar wrote:
> David, what's your comment on this?

It was wrong to try registering the transceiver in
the mach-map2/usb2.c file in any case.  That's a
board-specific issue for OMAP3; and TUSB60x0 chips
have an integrated one.  See

 http://marc.info/?l=linux-usb&m=123852898920405&w=2

So for example the RX51 board support (nyet in mainline)
needs to register the NOP transceiver; and I think one
more board, maybe the OMAP3 EVM, does too.

- Dave

p.s. This issue is *only* for the OMAP tree.


  

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
