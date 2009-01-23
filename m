From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: Re: [PATCH] usb: musb: fix bug in musbhsdma programming
Date: Fri, 23 Jan 2009 20:38:14 +0200
Message-ID: <20090123183814.GV440@frodo>
References: <1231417896-32363-1-git-send-email-ajay.gupta@ti.com> <20090123101812.GP9233@scadufax.research.nokia.com> <200901231036.04376.david-b@pacbell.net>
Reply-To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200901231036.04376.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jan 23, 2009 at 10:36:04AM -0800, David Brownell wrote:
> On Friday 23 January 2009, Felipe Balbi wrote:
> > On Thu, Jan 08, 2009 at 06:01:36PM +0530, Ajay Kumar Gupta wrote:
> > > Mode bit should be set based on function parameter "mode" of
> > > configure_channel() function.
> > > 
> > > Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> > 
> > Acked-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> 
> NAK -- interpretation of the MODE parameter is correct
> (though it's not clear to me that the callers set it right),
> but this won't apply to current GIT since the code differs.

hmmm.. don't get what you mean. If mode parameter in channel_program()
is true, that means channel->desired_mode should be true and we're
trying to kick mode1 dma, isn't it ??

But true, should be re-issued

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
