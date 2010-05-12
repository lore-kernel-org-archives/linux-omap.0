From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] [PATCH 1/3] OMAP4: Keyboard Controller Support
Date: Tue, 11 May 2010 23:03:06 -0700
Message-ID: <20100512060305.GA13273@core.coreip.homeip.net>
References: <27F9C60D11D683428E133F85D2BB4A53043D9EE7F5@dlee03.ent.ti.com>
 <20100421065550.GL4364@core.coreip.homeip.net>
 <27F9C60D11D683428E133F85D2BB4A53043DFD5320@dlee03.ent.ti.com>
 <27F9C60D11D683428E133F85D2BB4A53043DFD5323@dlee03.ent.ti.com>
 <20100511044156.GA21299@core.coreip.homeip.net>
 <27F9C60D11D683428E133F85D2BB4A53043E08F7B6@dlee03.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C5455792@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42050 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679Ab0ELGDM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 May 2010 02:03:12 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C5455792@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Arce, Abraham" <x0066660@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, May 12, 2010 at 11:15:11AM +0530, Shilimkar, Santosh wrote:
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Arce,
> > Abraham
> > Sent: Wednesday, May 12, 2010 11:10 AM
> > To: Dmitry Torokhov
> > Cc: linux-input@vger.kernel.org; linux-omap@vger.kernel.org
> > Subject: RE: [RFC] [PATCH 1/3] OMAP4: Keyboard Controller Support
> > 
> > Dmitry,
> > 
> > 2 comments + one question before sending next version...
> > 
> > [...]
> > 
> > > > > > > +static irqreturn_t omap_keypad_threaded(int irq, void *dev_id)
> > > > > > > +{
> > > > > >
> > > > > > Why is iti threaded? I fo not see anything that will sleep.
> > > >
> > > >
> > > > It was implemented based on previous comments...
> > > >
> > >
> > > Would you point me to that comment? Like I said, I do not see anything
> > > that would possibly sleep in this routine so you don't need to use
> > > threaded interrupt.
> > 
> > Using now request_irq based on your comments. In same omap_keypad_interrupt disable/clear/enable
> > interrupts will be executed
> > 
> > [...]
> >
> Sorry for jumping into the comments late. Thought this was sorted out. Key scanning
> and debounce timeouts etc still there. Having all these things in ISR itself isn't good
> idea.
> 
> Dmitry,
> Don't you think its optimal to push the key-scanning and debounce timeout code
> part of bottom half ??
>

If you need debounce then you need to fire a timer and keep doing this
until interrupt (or key state) settles. It really depends on the device.

-- 
Dmitry
