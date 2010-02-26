From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] musb: Add workqueue for URB giveback
Date: Fri, 26 Feb 2010 17:54:29 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DB7A9CF@dbde02.ent.ti.com>
References: <1267180746-6773-1-git-send-email-ajay.gupta@ti.com>
 <201002261233.46872.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201002261233.46872.laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org" <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org" <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
> -----Original Message-----
> From: Laurent Pinchart [mailto:laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org]
> Sent: Friday, February 26, 2010 5:04 PM
> To: Gupta, Ajay Kumar
> Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org; oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org
> Subject: Re: [PATCH] musb: Add workqueue for URB giveback
> 
> Hi Ajay,
> 
> On Friday 26 February 2010 11:39:06 Ajay Kumar Gupta wrote:
> > Current musb host driver does the giveback of completed urb first and
> > then start the next request. This is significantly affecting the
> streaming
> > from an USB camera wherein we observe huge delay between the two IN
> tokens
> > from musb host. This is due to the fact that UVC driver is doing
> decoding
> > and further processing in giveback context.
> 
> I was thinking about adding a workqueue to the UVC driver for URB
> processing.
> If you beat my by writing a patch before I find time to do so, I won't
> complain ;-)

Sure, I will see when I can post a RFC/PATCH for it. Probably after
two weeks.

Regards,
Ajay
> 
> --
> Regards,
> 
> Laurent Pinchart
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
