From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 2/3 v3] musb: Add context save and restore support
Date: Tue, 15 Dec 2009 17:14:56 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404372AAF0F@dbde02.ent.ti.com>
References: <1260797982-28880-1-git-send-email-ajay.gupta@ti.com>
 <1260797982-28880-2-git-send-email-ajay.gupta@ti.com>
 <20091214163324.GB31829@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091214163324.GB31829-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

<snip..>

> >@@ -2179,15 +2322,23 @@ static int musb_suspend(struct device *dev)
> >        spin_lock_irqsave(&musb->lock, flags);
> >
> >        if (is_peripheral_active(musb)) {
> >-               /* FIXME force disconnect unless we know USB will wake
> >-                * the system up quickly enough to respond ...
> >+               /* System is entering into suspend where gadget would not
> be
> >+                * able to respond to host and thus it will be in an
> unknown
> >+                * state for host. Re-enumeration of gadget is required
> after
> >+                * a resume. So we force a disconnect.
> >                 */
> >+               reg = musb_readb(musb->mregs, MUSB_POWER);
> >+               reg &= ~MUSB_POWER_SOFTCONN;
> >+               musb_writeb(musb->mregs, MUSB_POWER, reg);
> >+
> 
> I think we should only allow suspend if cable isn't connected. What
> would happend if you have mounted fs (using mass storage), user is
> transferring files and you force a disconnect ?

We force a disconnect during suspend which is actually triggered by user
Only. So do we need to consider this scenario?

Moreover, in case of OMAP3, as Smart-Idle/Stdby is enabled so system shouldn't enter into suspend state if cable is connected and data
transfer is going on.

-Ajay

> 
> >diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> >index 83beeac..15a3f27 100644
> >--- a/drivers/usb/musb/omap2430.c
> >+++ b/drivers/usb/musb/omap2430.c
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
