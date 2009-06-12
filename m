From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH 1/2] Serial: Define IRQ flags for 8250 driver
Date: Fri, 12 Jun 2009 09:54:38 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C0115CBC30F@dlee02.ent.ti.com>
References: <1244767784-22820-1-git-send-email-vikram.pandita@ti.com>
 <7A436F7769CA33409C6B44B358BFFF0C0115CBC08A@dlee02.ent.ti.com>
 <20090612063743.GA655@nokia.com>
 <7A436F7769CA33409C6B44B358BFFF0C0115CBC2F2@dlee02.ent.ti.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F53464BE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37185 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752681AbZFLOyt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jun 2009 10:54:49 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F53464BE@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



Regards,
Nishanth Menon

> -----Original Message-----
> From: Pandita, Vikram
> Sent: Friday, June 12, 2009 9:50 AM
> To: Menon, Nishanth; felipe.balbi@nokia.com
> Cc: linux-omap@vger.kernel.org
> Subject: RE: [PATCH 1/2] Serial: Define IRQ flags for 8250 driver
> 
> 
> 
> >-----Original Message-----
> >From: Menon, Nishanth
> >Sent: Friday, June 12, 2009 9:46 AM
> >To: felipe.balbi@nokia.com
> >Cc: Pandita, Vikram; linux-omap@vger.kernel.org
> >Subject: RE: [PATCH 1/2] Serial: Define IRQ flags for 8250 driver
> >
> >> -----Original Message-----
> >> From: Felipe Balbi [mailto:felipe.balbi@nokia.com]
> >> Sent: Friday, June 12, 2009 1:38 AM
> >> To: Menon, Nishanth
> >> Cc: Pandita, Vikram; linux-omap@vger.kernel.org
> >> Subject: Re: [PATCH 1/2] Serial: Define IRQ flags for 8250 driver
> >>
> >> On Fri, Jun 12, 2009 at 03:46:37AM +0200, ext Menon, Nishanth wrote:
> >> >
> >> > > -----Original Message-----
> >> > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >> > > owner@vger.kernel.org] On Behalf Of Pandita, Vikram
> >> > > Sent: Thursday, June 11, 2009 7:50 PM
> >> > > To: linux-omap@vger.kernel.org
> >> > > Cc: Pandita, Vikram
> >> > > Subject: [PATCH 1/2] Serial: Define IRQ flags for 8250 driver
> >> > >
> >> > >
> >> > > +	/* Get IRQ Trigger Flag */
> >> > > +	if (up->port.flags & UPF_IRQ_TRIG_RISING)
> >> > > +		irq_flags |= IRQF_TRIGGER_RISING;
> >> > > +	else if (up->port.flags & UPF_IRQ_TRIG_FALLING)
> >> > > +		irq_flags |= IRQF_TRIGGER_FALLING;
> >> > > +	else if (up->port.flags & UPF_IRQ_TRIG_HIGH)
> >> > > +		irq_flags |= IRQF_TRIGGER_HIGH;
> >> > > +	else if (up->port.flags & UPF_IRQ_TRIG_LOW)
> >> > > +		irq_flags |= IRQF_TRIGGER_LOW;
> >> > > +
> >> > Blame it on my dislike for nested if elseif, but...
> >> > irq_flags |=
> >> > 	(up->port.flags & UPF_IRQ_TRIG_RISING)? IRQF_TRIGGER_RISING :
> >> > 	(up->port.flags & UPF_IRQ_TRIG_FALLING)? IRQF_TRIGGER_FALLING :
> >> > 	(up->port.flags & IRQF_TRIGGER_HIGH)? IRQF_TRIGGER_HIGH :
> >> > 	(up->port.flags & UPF_IRQ_TRIG_LOW)? IRQF_TRIGGER_LOW : 0;
> >> >
> >> > Makes sense?
> >>
> >> switch (up->port.flags & UPF_IRQ_FLAGS_MASK) {
> >> case UPF_IRQ_TRIG_RISING:
> >> 	irq_flags |= IRQF_TRIGGER_RISING;
> >> 	break;
> >> case UPF_IRQ_TRIG_FALLING:
> >> 	irq_flags |= IRQF_TRIGGER_FALLING;
> >> 	break;
> >> case UPF_IRQ_TRIG_HIGH:
> >> 	irq_flags |= IRQF_TRIGGER_HIGH;
> >> 	break;
> >> case UPF_IRQ_TRIG_LOW:
> >> 	irq_flags |= IRQF_TRIGGER_LOW;
> >> 	break;
> >> default:
> >> 	printk(KERN_ERR "Unsupported flag\n");
> >> 	return -EINVAL;
> >> }
> >>
> >Better :) infact, if the port.flags = UPF_IRQ_TRIG_LOW |
> UPF_IRQ_TRIG_HIGH it might be better to
> >return -EINVAL, which Felipe's change does :).
> 
> Needs more investigation as to how current boards using 8250 driver do not
> pass any flag (maybe just SHARED flag) and they still work. Maybe some
> default taken by request_irq()
> 
> In short NO_ need to return failure as no flag is a valid use case.
Replacing switch (up->port.flags & UPF_IRQ_FLAGS_MASK) 
With
#define UPF_IRQ_LEVEL_FLAGS_MASK \
		(UPF_IRQ_TRIG_RISING | UPF_IRQ_TRIG_FALLING |\
		 UPF_IRQ_TRIG_HIGH | UPF_IRQ_TRIG_LOW)

switch (up->port.flags & UPF_IRQ_LEVEL_FLAGS_MASK) {
will allow for valid -EINVAL return.
Regards,
Nishanth Menon
