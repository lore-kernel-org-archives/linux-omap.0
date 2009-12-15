From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 3/3] musb: Add 'extvbus' in musb_hdrc_platform_data
Date: Tue, 15 Dec 2009 09:37:15 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404372AAD05@dbde02.ent.ti.com>
References: <1260797982-28880-1-git-send-email-ajay.gupta@ti.com>
 <1260797982-28880-2-git-send-email-ajay.gupta@ti.com>
 <1260797982-28880-3-git-send-email-ajay.gupta@ti.com>
 <20091214163746.GC31829@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091214163746.GC31829-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Felipe Balbi [mailto:felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org]
> Sent: Monday, December 14, 2009 10:08 PM
> To: Gupta, Ajay Kumar
> Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Balbi Felipe
> (Nokia-D/Helsinki); david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org
> Subject: Re: [PATCH 3/3] musb: Add 'extvbus' in musb_hdrc_platform_data
> 
> Hi,
> 
> On Mon, Dec 14, 2009 at 02:39:42PM +0100, ext Ajay Kumar Gupta wrote:
> >diff --git a/drivers/usb/musb/musb_regs.h b/drivers/usb/musb/musb_regs.h
> >index 8ca8f23..cba724d 100644
> >--- a/drivers/usb/musb/musb_regs.h
> >+++ b/drivers/usb/musb/musb_regs.h
> >@@ -72,6 +72,10 @@
> > #define MUSB_DEVCTL_HR		0x02
> > #define MUSB_DEVCTL_SESSION	0x01
> >
> >+/* ULPI VBUSCONTROL */
> >+#define ULPI_USE_EXTVBUS	0x01
> >+#define ULPI_USE_EXTVBUSIND	0x02
> 
> shouldn't these go to drivers/usb/otg/ulpi.c or include/usb/ulpi.h ?
> 
> or is this musb specific ?? If it's musb specific, please prepend with
> MUSB_

Yes, they are MUSB specific. I will append 'MUSB_' in next version.

-Ajay

> 
> --
> balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
