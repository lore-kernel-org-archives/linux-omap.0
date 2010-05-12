From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [RFC] [PATCH 1/3] OMAP4: Keyboard Controller Support
Date: Wed, 12 May 2010 11:15:11 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5455792@dbde02.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A53043D9EE7F5@dlee03.ent.ti.com>
 <20100421065550.GL4364@core.coreip.homeip.net>
 <27F9C60D11D683428E133F85D2BB4A53043DFD5320@dlee03.ent.ti.com>
 <27F9C60D11D683428E133F85D2BB4A53043DFD5323@dlee03.ent.ti.com>
 <20100511044156.GA21299@core.coreip.homeip.net>
 <27F9C60D11D683428E133F85D2BB4A53043E08F7B6@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53043E08F7B6@dlee03.ent.ti.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: "Arce, Abraham" <x0066660@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Arce,
> Abraham
> Sent: Wednesday, May 12, 2010 11:10 AM
> To: Dmitry Torokhov
> Cc: linux-input@vger.kernel.org; linux-omap@vger.kernel.org
> Subject: RE: [RFC] [PATCH 1/3] OMAP4: Keyboard Controller Support
> 
> Dmitry,
> 
> 2 comments + one question before sending next version...
> 
> [...]
> 
> > > > > > +static irqreturn_t omap_keypad_threaded(int irq, void *dev_id)
> > > > > > +{
> > > > >
> > > > > Why is iti threaded? I fo not see anything that will sleep.
> > >
> > >
> > > It was implemented based on previous comments...
> > >
> >
> > Would you point me to that comment? Like I said, I do not see anything
> > that would possibly sleep in this routine so you don't need to use
> > threaded interrupt.
> 
> Using now request_irq based on your comments. In same omap_keypad_interrupt disable/clear/enable
> interrupts will be executed
> 
> [...]
>
Sorry for jumping into the comments late. Thought this was sorted out. Key scanning
and debounce timeouts etc still there. Having all these things in ISR itself isn't good
idea.

Dmitry,
Don't you think its optimal to push the key-scanning and debounce timeout code
part of bottom half ??

Regards,
Santosh
