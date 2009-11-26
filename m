From: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 1/2 v2] musb: Add context save and restore support
Date: Thu, 26 Nov 2009 15:57:15 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030AAC31C0@dbde02.ent.ti.com>
References: <1259217599-17793-1-git-send-email-ajay.gupta@ti.com>
 <4B0E4449.8030701@ti.com>
 <19F8576C6E063C45BE387C64729E739404370D7BF1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <19F8576C6E063C45BE387C64729E739404370D7BF1-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>, "Dasgupta, Romit" <romit-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> <snip.>
> 
> > >                  */
> > > +               reg = musb_readb(musb->mregs, MUSB_POWER);
> > > +               reg &= ~MUSB_POWER_SOFTCONN;
> > > +               musb_writeb(musb->mregs, MUSB_POWER, reg);
> > After this softdisconnect when we subsequently get reconnected followed by
> > a reset we could have changed our speed (LS,FS, HS).
> 
> I didn't get it completely. I think as a peripheral USB speed will remain
> same after resume for the gadget driver it was before suspend?
> 
> If we intend to change the gadget driver then we may have support for a
> different speed but it would anyways happen after resume is completed.
> 

The host side might change, but that shouldn't affect us. This bit is
used to tell MUSB (acting as a peripheral) if it should attempt
to enumerate at HS or not - it will always fall back to FS if the host
does not support it.

So Ajay is correct in restoring this register.

- Anand
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
