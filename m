From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: TWL4030 keypad timeout interrupt
Date: Wed, 14 May 2008 13:08:57 +0300
Message-ID: <20080514100857.GC17908@gandalf.research.nokia.com>
References: <20080513135417.GL4244@gandalf.research.nokia.com> <3d1886c4eeb5320b5d443df10b6bed87@felipebalbi.com> <023e01c8b580$8242db00$7f8818ac@ent.ti.com> <20080514081629.GA17908@gandalf.research.nokia.com> <028f01c8b5a0$87134140$7f8818ac@ent.ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB022256EA1D@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:38213 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754453AbYENKKi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 May 2008 06:10:38 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB022256EA1D@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gopinath, Thara" <thara@ti.com>
Cc: "Ghongadematt, Girish" <girishsg@ti.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, 'Felipe Balbi' <me@felipebalbi.com>, 'Linux OMAP Mailing List' <linux-omap@vger.kernel.org>

On Wed, May 14, 2008 at 03:22:56PM +0530, ext Gopinath, Thara wrote:
> 
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Girish
> > Sent: Wednesday, May 14, 2008 2:27 PM
> > To: felipe.balbi@nokia.com
> > Cc: 'Felipe Balbi'; 'Linux OMAP Mailing List'
> > Subject: RE: TWL4030 keypad timeout interrupt
> >
> >
> >
> > >-----Original Message-----
> > >From: Felipe Balbi [mailto:felipe.balbi@nokia.com]
> > >Sent: Wednesday, May 14, 2008 1:46 PM
> > >To: ext Girish
> > >Cc: 'Felipe Balbi'; felipe.balbi@nokia.com; 'Linux OMAP Mailing List'
> > >Subject: Re: TWL4030 keypad timeout interrupt
> > >
> > >Ok, good :-)
> > >thanks
> > >
> > >>
> > >> >So if i read it correctly, we might have 0 set as our timeout.
> > >> >
> > >> >which might explain why we only see the timeout interrupt when
> > >> >releasing the key.
> > >> >
> > >> >Am I right ?
> > >>
> > >> Well, the timeout is here to help the controller come out of
> > >hangs, if any.
> > >
> > >But is it possible that whenever we release a key we get a
> > timeout? I
> > >think something is wrong there.
> >
> > No, it's an empty timeout feature, an interrupt is generated
> > if no key is pressed during that period of time.
> >
> >
> > Regards,
> > Girish
> 
> This feature allows the TWL4030 keypad internal sequencer to go to idle state if no keypresses are made for the period of time programmed in the timeout register.The reason why you are seeing this only after a release is because this timeout feature is activated only after a release event.Thus when a key is release you see a keyreleased event interrupt and after the programmed timeout interval is over a timeout event interrupt.This timeout interrupt does nothing but tell you that the keypad internal sequencer is going to idle state.
> This is not a must to have feature but there is nothing wrong with having it also.

Ok, got it. :-)
thanks for the clarification :-)

-- 
	- Balbi
