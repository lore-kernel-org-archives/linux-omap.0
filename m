From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] musb: Add workqueue for URB giveback
Date: Fri, 26 Feb 2010 16:50:05 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DB7A964@dbde02.ent.ti.com>
References: <1267180746-6773-1-git-send-email-ajay.gupta@ti.com>
 <201002261203.27619.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201002261203.27619.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org" <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
> -----Original Message-----
> From: Oliver Neukum [mailto:oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org]
> Sent: Friday, February 26, 2010 4:33 PM
> To: Gupta, Ajay Kumar
> Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org
> Subject: Re: [PATCH] musb: Add workqueue for URB giveback
> 
> Am Freitag, 26. Februar 2010 11:39:06 schrieb Ajay Kumar Gupta:
> > +struct queue *create(void)
> > +{
> > +       struct queue *new;
> > +       new = kmalloc(sizeof(struct queue), GFP_ATOMIC);
> > +       if (!new)
> > +               return NULL;
> > +       new->next = NULL;
> > +       return new;
> > +}
> > +void push_queue(struct musb *musb, struct urb *urb)
> > +{
> > +       struct queue *new, *temp;
> > +
> > +       new = create();
> > +       new->urb = urb;
> 
> And you happily follow the NULL pointer in the error case.

I will put the NULL check here and also during push_queue(). In case
Of memory allocation failure I can giveback the URB right away.

> 
> > +
> > +       temp = musb->qhead;
> > +
> > +       spin_lock(&musb->qlock);
> > +       while (temp->next != NULL)
> > +               temp = temp->next;
> > +       temp->next = new;
> > +       spin_unlock(&musb->qlock);
> > +}
> 
> A design allocating memory in giveback is problematic. At least you need
> to handle a failure to allocate memory. But you'd better handle this by
> putting the list into the private part of the URB.

This would require a change in urb structure which would face more
resistance as it will only be used by MUSB HCD.

Thanks,
Ajay
> 
> 	Regards
> 		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
