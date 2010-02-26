From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] musb: Add workqueue for URB giveback
Date: Fri, 26 Feb 2010 12:33:59 +0100
Message-ID: <201002261233.59190.oliver@neukum.org>
References: <1267180746-6773-1-git-send-email-ajay.gupta@ti.com> <201002261203.27619.oliver@neukum.org> <19F8576C6E063C45BE387C64729E7394044DB7A964@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044DB7A964-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org" <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Am Freitag, 26. Februar 2010 12:20:05 schrieb Gupta, Ajay Kumar:

Hello,

> > -----Original Message-----
> > From: Oliver Neukum [mailto:oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org]
> > Sent: Friday, February 26, 2010 4:33 PM
> > To: Gupta, Ajay Kumar
> > Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> > stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org
> > Subject: Re: [PATCH] musb: Add workqueue for URB giveback
> > 
> > Am Freitag, 26. Februar 2010 11:39:06 schrieb Ajay Kumar Gupta:
> > > +struct queue *create(void)
> > > +{
> > > +       struct queue *new;
> > > +       new = kmalloc(sizeof(struct queue), GFP_ATOMIC);
> > > +       if (!new)
> > > +               return NULL;
> > > +       new->next = NULL;
> > > +       return new;
> > > +}
> > > +void push_queue(struct musb *musb, struct urb *urb)
> > > +{
> > > +       struct queue *new, *temp;
> > > +
> > > +       new = create();
> > > +       new->urb = urb;
> > 
> > And you happily follow the NULL pointer in the error case.
> 
> I will put the NULL check here and also during push_queue(). In case
> Of memory allocation failure I can giveback the URB right away.

If you do that you'll give back URBs out of order. Now I don't know whether
this is defined as something you mustn't do, bad it is not a good idea.

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
