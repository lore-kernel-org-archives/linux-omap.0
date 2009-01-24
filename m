From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] usb: musb: fix bug in musbhsdma programming
Date: Fri, 23 Jan 2009 20:31:14 -0800
Message-ID: <200901232031.14265.david-b@pacbell.net>
References: <1231417896-32363-1-git-send-email-ajay.gupta@ti.com> <200901231036.04376.david-b@pacbell.net> <19F8576C6E063C45BE387C64729E739403FA6CCD3A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <19F8576C6E063C45BE387C64729E739403FA6CCD3A-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Friday 23 January 2009, Gupta, Ajay Kumar wrote:
> This patch is not for mainline. 
> It is intended for MV's OMAP GIT

Ah, I see.  Thanks for clarifying.

However ... that's not MontaVista's GIT tree, exactly,
except in that they've hosted the OMAP community tree.
And since that tree is now obsolete, and that patch 
isn't in the main branch ... I'll just ignore this.  :)

- Dave


> to solve the bug introduced by [1] below 
> and is already applied at [2], the modified version of this patch. 
> 
> As [1] is not yet gone to mainline so this patch is also not required in mainline.


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
