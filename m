From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/8] musb: fix compilation warning in host only mode
Date: Wed, 7 Jul 2010 20:35:56 -0700
Message-ID: <20100708033556.GA25302@kroah.com>
References: <1276771242-5201-1-git-send-email-ajay.gupta@ti.com> <1276771242-5201-2-git-send-email-ajay.gupta@ti.com> <1276771242-5201-3-git-send-email-ajay.gupta@ti.com> <1276771242-5201-4-git-send-email-ajay.gupta@ti.com> <20100624060338.GF8078@nokia.com> <19F8576C6E063C45BE387C64729E7394044E9E38CA@dbde02.ent.ti.com> <20100706091314.GG3035@nokia.com> <20100707220129.GA5884@kroah.com> <19F8576C6E063C45BE387C64729E7394044EB95AE0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044EB95AE0-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "gregkh-l3A5Bk7waGM@public.gmane.org" <gregkh-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 08, 2010 at 07:23:44AM +0530, Gupta, Ajay Kumar wrote:
> Hi,
> > > On Thu, Jun 24, 2010 at 01:17:54PM +0200, ext Gupta, Ajay Kumar wrote:
> > > >Fixes below compilation warning when host only configuration is
> > > >selected.
> > > >drivers/usb/musb/musb_core.c: In function 'musb_stage0_irq':
> > > >drivers/usb/musb/musb_core.c:711: warning: unused variable 'mbase'
> > > >
> > > >Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> > >
> > > Acked-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> > 
> > You've acked a random ammount of patches recently, are you going to be
> > resending them to me?  I have a hard time going back and digging through
> > the archives to pick out the ones that you acked vs. the ones you
> > didn't.
> 
> Greg,
> 
> There are 2 musb and 1 ehci-omap bug fix patches which are acked.
> Another related one is on ULPI and is trivial.
> 
> Apart from these, 2 musb patches for v2.6.36 window are also acked.
> 
> I will prepare the set and send you after sanity testing.

That sounds great, thanks for doing this.

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
