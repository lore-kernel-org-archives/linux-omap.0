From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 3/8] musb: fix compilation warning in host only mode
Date: Thu, 24 Jun 2010 20:06:10 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E9E3948@dbde02.ent.ti.com>
References: <1276771242-5201-1-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-2-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-3-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-4-git-send-email-ajay.gupta@ti.com>
 <20100624060338.GF8078@nokia.com>
 <19F8576C6E063C45BE387C64729E7394044E9E38CA@dbde02.ent.ti.com>
 <4C235929.9030605@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C235929.9030605-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "gregkh-l3A5Bk7waGM@public.gmane.org" <gregkh-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> >> then you add another ifdef to this file, which is already insane. I'd
> >> rather see you either keep the local variables and just fix what needs
> >> to be fixed,
> 
> >> or use musb->mregs directly.
> 
> > This one seems to be a much better one. Copying the v-3 with this fix
> below.
> 
>     I don't see how it's *much* better...

As it doesn't require to create another variable and moreover within
ugly #ifdefs of three different flavors (HOST, DEVCIE and OTG).

I think it's better to kill all 'mbase' variables and use musb->mregs
directly for a better code readability.

-Ajay 
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
