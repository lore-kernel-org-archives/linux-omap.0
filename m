From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH resend 1/3] AM35x: Add musb support
Date: Mon, 5 Jul 2010 16:45:53 +0300
Message-ID: <20100705134552.GD15951@atomide.com>
References: <1278053879-6850-1-git-send-email-ajay.gupta@ti.com>
 <20100705095015.GP15951@atomide.com>
 <4C31ADCA.40607@ru.mvista.com>
 <20100705102322.GR15951@atomide.com>
 <4C31B54F.6040109@ru.mvista.com>
 <20100705104841.GS15951@atomide.com>
 <19F8576C6E063C45BE387C64729E7394044EAAD8F6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044EAAD8F6-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Gupta, Ajay Kumar <ajay.gupta-l0cyMroinI0@public.gmane.org> [100705 14:48]:
> > > >>   I think Ajay has explained why it's needed. The option is
> > > >>necessary in one or another form.
> > >
> > > >It's not needed for omaps, we can already build in support for
> > > >omap2, omap3 and omap4 into the same kernel binary.
> > >
> > >    Not with AM35x USB support merged -- at least you won't be able
> > > to build single kernel with monolithic MUSB support.
> > 
> > Right. I believe musb is pretty much the only remaining driver
> > that won't behave with multi-omap. But let's not merge code that
> > would make fixing that even harder.
> > 
> > > >If a Kconfig option is needed for optionally compiling in the support
> > > >for am35x musb, it should be called USB_MUSB_AM35X or similar that
> > > >gets selected if the boards using it are selected.
> > >
> > >    Do you mean that we should have this option in
> > drivers/usb/musb/Kconfig?
> > 
> > Yeah, it could be set automatically with default y if
> > MACH_AM35X_SOME_BOARD.
> > 
> > Then options like this should not be mutually exclusive like they
> > currently are for musb, that breaks using musb with multi omap.
> 
> Choosing USB_MUSB_AM35X would anyways compile am35x.c and not omap2430.c
> File; thus musb would not work on OMAP3x boards with same binary.

You should set up things so both can be compiled in, that's standard
behaviour for all Linux drivers :)
 
> I will update the patches and submit for further reviews.

Thanks,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
