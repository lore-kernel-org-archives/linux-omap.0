From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 2/3 v3] musb: Add context save and restore support
Date: Thu, 17 Dec 2009 19:46:50 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940449F439D9@dbde02.ent.ti.com>
References: <1260797982-28880-1-git-send-email-ajay.gupta@ti.com>
 <1260797982-28880-2-git-send-email-ajay.gupta@ti.com>
 <4B2A3453.7040008@nokia.com>
 <19F8576C6E063C45BE387C64729E73940449F439C7@dbde02.ent.ti.com>
 <4B2A3BEE.7000809@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B2A3BEE.7000809-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaud Mandy <ext-arnaud.2.mandy-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Arnaud Mandy [mailto:ext-arnaud.2.mandy-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org]
> Sent: Thursday, December 17, 2009 7:41 PM
> To: Gupta, Ajay Kumar
> Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Balbi Felipe
> (Nokia-D/Helsinki); david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org; Gadiyar, Anand
> Subject: Re: [PATCH 2/3 v3] musb: Add context save and restore support
> 
> ext Gupta, Ajay Kumar wrote:
> > <snip>
> >
> >>>  #ifdef CONFIG_PM
> >>>
> >>> +static struct musb_context_registers musb_context;
> >>> +
> >>> +void musb_save_context(struct musb *musb)
> >>> +{
> >>>
> >>>
> >> Could you add one more parameter to this function call, which would
> >> select either if we want to save the musb_platform context or not?
> >> I m working at the moment on turning off the musb when cable unplugged
> >> and turning it on with restoring context after cable re-connect.
> >> In this case I don't need to restore the the musb_platform_context
> since
> >> I just set them before calling this one.
> >>
> >> Same apply for restore.
> >>
> >> what do you think?
> >> I could also modify slightly this implementation after it is ready and
> >> submit it.
> >>
> >
> > I think you want to add the parameter in musb_platform_save_context()
> and
> > not in musb_save_context.
> > If so then where do you restore them? {As you said before calling this}
> >
> 
> In order to support off-mode, we need the transceiver driver to wake-up
> the controller.
> I m working on a hook which would allow that.
> I want to take advantage of your implementation for saving/restoring
> musb context, but saving the platform data is not necessary in my case.

Then how about having a platform specific flag within
musb_platform_save/restorae_context() implementation which wouldn't
save/restore when you don't need them.


> Maybe it musb_platform_save/restore_context(), shouldn't be called from
> musb_save/restore_context();
> 
> > I think if the requirement is generic and suits for all other platforms
> > Using musb then we can add it.
> >
> 
> Yes it should.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
