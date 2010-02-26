From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH] musb: Add workqueue for URB giveback
Date: Fri, 26 Feb 2010 17:49:13 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DB7A9C7@dbde02.ent.ti.com>
References: <1267180746-6773-1-git-send-email-ajay.gupta@ti.com>
 <201002261203.27619.oliver@neukum.org>
 <19F8576C6E063C45BE387C64729E7394044DB7A964@dbde02.ent.ti.com>
 <201002261233.59190.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34476 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935934Ab0BZMTN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Feb 2010 07:19:13 -0500
In-Reply-To: <201002261233.59190.oliver@neukum.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>

Hi,
> > > Am Freitag, 26. Februar 2010 11:39:06 schrieb Ajay Kumar Gupta:
> > > > +struct queue *create(void)
> > > > +{
> > > > +       struct queue *new;
> > > > +       new = kmalloc(sizeof(struct queue), GFP_ATOMIC);
> > > > +       if (!new)
> > > > +               return NULL;
> > > > +       new->next = NULL;
> > > > +       return new;
> > > > +}
> > > > +void push_queue(struct musb *musb, struct urb *urb)
> > > > +{
> > > > +       struct queue *new, *temp;
> > > > +
> > > > +       new = create();
> > > > +       new->urb = urb;
> > >
> > > And you happily follow the NULL pointer in the error case.
> >
> > I will put the NULL check here and also during push_queue(). In case
> > Of memory allocation failure I can giveback the URB right away.
> 
> If you do that you'll give back URBs out of order.

Right, this would confuse the class driver and better avoided.

Next option is to add another list_head within URB structure to trace
the URBs. (as you suggested earlier)

-Ajay  

> Now I don't know whether this is defined as something you mustn't
> do, bad it is not a good idea.
> 
> 	Regards
> 		Oliver
