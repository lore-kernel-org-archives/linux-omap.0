From: Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 8/8] usb: musb: Fix suspend interrupt issue in device
 mode
Date: Thu, 17 Jun 2010 07:18:54 -0700
Message-ID: <20100617141854.GB9063@suse.de>
References: <1276771242-5201-2-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-3-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-4-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-5-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-6-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-7-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-8-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-9-git-send-email-ajay.gupta@ti.com>
 <4C1A0687.4080002@ru.mvista.com>
 <006501cb0e16$c08bae00$808918ac@apr.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <006501cb0e16$c08bae00$808918ac-wD+IZp/g4/2mHdYHvhjUOg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maulik <x0082077-l0cyMroinI0@public.gmane.org>
Cc: 'Sergei Shtylyov' <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, 'Ajay Kumar Gupta' <ajay.gupta-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, 'David Brownell' <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 17, 2010 at 05:45:15PM +0530, Maulik wrote:
> > -----Original Message-----
> > From: Sergei Shtylyov [mailto:sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org]
> > Sent: Thursday, June 17, 2010 4:57 PM
> > To: Ajay Kumar Gupta
> > Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> > felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org; gregkh-l3A5Bk7waGM@public.gmane.org; Maulik Mankad; David Brownell
> > Subject: Re: [PATCH 8/8] usb: musb: Fix suspend interrupt issue in device
> > mode
> > 
> > Hello.
> > 
> > Ajay Kumar Gupta wrote:
> > 
> > > From: Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>
> > 
> > > As a part of aligning the ISR code for MUSB with the specs, the
> > > ISR code was re-written.
> > 
> > > See Commit 1c25fda4a09e8229800979986ef399401053b46e (usb: musb: handle
> > > irqs in the order dictated by programming guide)
> > 
> > > With this the suspend interrupt came accidently under
> > CONFIG_USB_MUSB_HDRC_HCD.
> > 
> > > The fix brings suspend interrupt handling outside
> > > CONFIG_USB_MUSB_HDRC_HCD.
> > 
> > > Signed-off-by: Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>
> > > Acked-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> > > Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
> > > Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> > 
> > [...]
> > 
> > > diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> > > index 4f43db7..64b08f9 100644
> > > --- a/drivers/usb/musb/musb_core.c
> > > +++ b/drivers/usb/musb/musb_core.c
> > > @@ -635,7 +635,7 @@ static irqreturn_t musb_stage0_irq(struct musb
> > *musb, u8 int_usb,
> > >  		handled = IRQ_HANDLED;
> > >  	}
> > >
> > > -
> > > +#endif
> > 
> >     Could you move #endif one line up, so that it closely embraces the
> > *if*
> > statement?
> 
> The patch is already in Greg's queue. 
> 
> Greg,
> 
> Do you want me to resend this patch?

No, it's already in my queue, so I don't need to reapply it :)

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
