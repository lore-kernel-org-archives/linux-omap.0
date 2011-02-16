From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] usb: ehci-omap: add support for TLL mode on OMAP4
Date: Wed, 16 Feb 2011 16:16:25 +0530
Message-ID: <6da3b95c2d97f5b0c125c75336e3f2a6@mail.gmail.com>
References: <1297851194-26264-1-git-send-email-gadiyar@ti.com> <20110216102222.GP2497@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110216102222.GP2497-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Felipe Balbi wrote:
> On Wed, Feb 16, 2011 at 03:43:14PM +0530, Anand Gadiyar wrote:
> > The EHCI controller in OMAP4 supports a transceiver-less link
> > mode (TLL mode), similar to the one in OMAP3. On the OMAP4
> > however, there are an additional set of clocks that need
> > to be turned on to get this working.
> >
> > Request and configure these for each port if that port
> > is connected in TLL mode.
> >
> > Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
> > Cc: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
>
> should this be going to next merge window or are you fixing
> any problem
> ?


This is a new feature for the driver - so it should go in the
next merge window. This belongs in the "has never worked before"
category.

- Anand
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
