From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] AM35x: Add musb support
Date: Tue, 23 Mar 2010 09:27:14 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DE0E8E6@dbde02.ent.ti.com>
References: <1267017495-17548-1-git-send-email-ajay.gupta@ti.com>,<4BA4CCF3.4060500@ru.mvista.com>
 <19F8576C6E063C45BE387C64729E7394044DCC5F29@dbde02.ent.ti.com>
 <4BA5FBF6.8010102@mvista.com>
 <19F8576C6E063C45BE387C64729E7394044DE0E5E6@dbde02.ent.ti.com>
 <4BA742ED.6080004@ru.mvista.com>
 <19F8576C6E063C45BE387C64729E7394044DE0E71B@dbde02.ent.ti.com>
 <4BA74E48.30109@ru.mvista.com>
 <19F8576C6E063C45BE387C64729E7394044DE0E730@dbde02.ent.ti.com>
 <4BA77142.3050109@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4BA77142.3050109-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
> >>> It is being used from plat/usb.h.
> >>>
> >>>
> >>    I haven't found where it's included.
> >>
> >
> > It's from cppi41_dma.h.
> >
> 
>    Well, you've removed the register #define's from cppi41_dma.h and
> #includ'ed <plat/usb.h>

Correct.

> BUT there's certainly no such header for DA8xx , so as I  suspected
> you've broken DA8xx support. That certainly won't do.:-/

As cppi4.1 register layouts are different in DA8x and AM3517 so we can't
use common place (cppi41_dma.h)for them and therefore I moved them
to plat/usb.h defines.

Ajay
> 
> WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
