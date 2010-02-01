From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3 1/2] ARM : OMAP: MUSB : Pass board specific data
 using a structure
Date: Mon, 1 Feb 2010 13:26:42 -0800
Message-ID: <20100201212642.GD22747@atomide.com>
References: <1262265756-17634-1-git-send-email-x0082077@ti.com>
 <20100128194658.GI6647@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100128194658.GI6647-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: ext Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Gupta Ajay Kumar <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> [100128 11:46]:
> On Thu, Dec 31, 2009 at 02:22:36PM +0100, ext Maulik Mankad wrote:
> >ARM : OMAP: MUSB :Pass board specific data from board file
> >
> >This patch proposes to pass board specific data for MUSB
> >(like interface_type, mode etc) from board file by defining
> >board specific structure.
> >
> >Each board file can define this structure based on
> >its requirement and pass this information to the
> >driver.
> >
> >Signed-off-by: Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>
> >Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> >Cc: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> >Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
> >Cc: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
> >Cc: Gupta Ajay Kumar <ajay.gupta-l0cyMroinI0@public.gmane.org>
> 
> Fine by me, Tony, any comments ?

Looks good to me. If you want to get this queued via
linux-usb:

Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Or, if you want me to merge some arch/arm/*omap*/ USB patches,
maybe put them all into a branch for the merge window?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
