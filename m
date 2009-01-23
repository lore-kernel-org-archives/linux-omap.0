From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] usb: musb: fix bug in musbhsdma programming
Date: Fri, 23 Jan 2009 10:50:33 -0800
Message-ID: <200901231050.34154.david-b@pacbell.net>
References: <1231417896-32363-1-git-send-email-ajay.gupta@ti.com> <200901231036.04376.david-b@pacbell.net> <20090123183814.GV440@frodo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090123183814.GV440@frodo>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Cc: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Friday 23 January 2009, Felipe Balbi wrote:
> 
> > NAK -- interpretation of the MODE parameter is correct
> > (though it's not clear to me that the callers set it right),
> > but this won't apply to current GIT since the code differs.
> 
> hmmm.. don't get what you mean. If mode parameter in channel_program()
> is true, that means channel->desired_mode should be true and we're
> trying to kick mode1 dma, isn't it ??

What I mean is:  you're working on "mode1 DMA"
(multiple packets per request, the only sane mode,
when it works) ... and I know you've had a hard time
getting it all to behave.  Ergo it's not clear to me
that Ajay's patch could be sufficient.  If it were,
then you've been spending a LOT of time on something
very simple ... ;)

The "desired_mode" thing is confusing too; it's
TX vs RX, unrelated to "mode1" or "mode0", but
that's a separate naming issue.

- Dave



> 
> But true, should be re-issued
> 


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
