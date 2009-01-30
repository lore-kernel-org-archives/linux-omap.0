From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] usb: musb: adding nop usb transceiver
Date: Fri, 30 Jan 2009 21:32:38 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403FA6CCD47@dbde02.ent.ti.com>
References: <1231411988-7330-1-git-send-email-ajay.gupta@ti.com>
 <200901222329.07689.david-b@pacbell.net>
 <19F8576C6E063C45BE387C64729E739403FA790059@dbde02.ent.ti.com>,<200901291241.19602.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200901291241.19602.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> Basically, that almost all of the OTG state machine must be
> handled outside of this code.  It's a bit of a puzzle how to
> partition that state machine between the drivers that need
> to collaborate on it.  At this point I don't think there can
> be a single model that applies everywhere ... but maybe one
> could evolve over time.

Thanks for clarifying.

> I'll tweak this one a bit.  It's pretty close.  That
> registration function should have a usb_*() prefix

Ok fine.

> and not be declared in an MUSB-only header, since it
> could potentially be used with other OTG hardware.

Is it ok to add it in include/linux/usb/otg.h ?

Thanks,
Ajay



--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
