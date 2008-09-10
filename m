From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: Re: [PATCH] MUSB: Set INDEX register to 0 before accessing
	CONFIGDATA
Date: Wed, 10 Sep 2008 22:01:18 +0300
Message-ID: <20080910190114.GA6671@frodo>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02C418D1B1@dbde02.ent.ti.com> <200809062204.01492.david-b@pacbell.net> <386072610809072012wcf053a6j37c238b82667c23a@mail.gmail.com>
Reply-To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <386072610809072012wcf053a6j37c238b82667c23a-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 08, 2008 at 11:12:24AM +0800, Bryan Wu wrote:
> On Sun, Sep 7, 2008 at 1:04 PM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> > On Thursday 04 September 2008, Gadiyar, Anand wrote:
> >> From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
> >>
> >> The Index register needs to be zero to access CONFIGDATA.
> >> musb_ep_select()will not set the MUSB_INDEX register unless INDEXED
> >> mode addressing is used. This change will set the register correctly
> >> in INDEXED as well as FLAT mode.
> >>
> >> Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
> >> CC: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> >
> > ACK.  I *know* it was originally written that way.  I think
> > the change was one of the Blackfin patches ... I hope this
> > isn't one of those cases where the Blackfin version of this
> > core acts differently.  (Like clearing that DMA IRQ status...)
> >
> 
> For Blackfin, the register MUSB_CONFIGDATA is not exported out to software.
> So in the musb driver, Blackfin code can not access the MUSB_CONFIGDATA.
> The configuration is fixed in the software.

What happens if you try to read/write to the register ? Does it screw up
things somehow or just ignores ??

If it just ignores (and same for the other unexistent registers) we can
drop that patch adding ifdefs to te register accesses otherwise we're
gonna have to think about another solution to abstract that.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
