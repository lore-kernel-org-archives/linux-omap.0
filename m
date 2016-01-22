From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: USB gadgets with configfs hang reboot
Date: Fri, 22 Jan 2016 10:28:41 -0800
Message-ID: <20160122182840.GS19432@atomide.com>
References: <20160115224839.GA19432@atomide.com>
 <56A205E4.6050305@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56A205E4.6050305-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrzej Pietrasiewicz <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Andrzej Pietrasiewicz <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> [160122 02:36]:
> Hi Tony,
> 
> W dniu 15.01.2016 o 23:48, Tony Lindgren pisze:
> >Hi all,
> >
> >Looks like there's some issue with the USB gadgets and configfs.
> >
> >I'm seeing rmmod of the UDC driver cause a warning and then reboot
> >hangs the system. This happens at least with v4.4, and I've reproduced
> >it with dwc3 and musb so it seems to be generic.
> >
> 
> I can't reproduce your problem on 4.4-rc4 nor on 4.4 release
> with the script you provided
>
> I'm using Odroid XU3, which has dwc3.

Well thanks for trying. Probably the difference is that
dwc3-exynos.c remove is calling platform_device_unregister()
while dwc3-omap.c remove is calling of_platform_depopulate()?

> >	mkdir functions/ecm.0
> >	ln -s functions/acm.0 configs/c.1
> 
> I assume you meant ecm.0 here and in the next line.
> 
> >	ln -s functions/acm.0 configs/c.2

OK, yes you're right. That does not affect the outcome though.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
