From: ewitcher <ewitcher-mn4gwa5WIIQysxA8WJXlww@public.gmane.org>
Subject: Re: MUSB regression in 2.6.31-rc6
Date: Mon, 17 Aug 2009 17:27:09 -0400 (GMT-04:00)
Message-ID: <6055571.1250544429670.JavaMail.root@elwamui-hound.atl.sa.earthlink.net>
Reply-To: ewitcher <ewitcher-mn4gwa5WIIQysxA8WJXlww@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Valo <kalle.valo-X3B1VOXEql0@public.gmane.org>, Jarkko Nikula <jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, "Gadiyar,Anand" <gadiyar-l0cyMroinI0@public.gmane.org>, "Gupta,Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello,

The below referenced patch was helpful to me in resolving the

<3>twl4030_usb twl4030_usb: ldo init failed

error.

Examining the minicom.cap attachment, I can see that twl4030_usb  is initialized before regulator.  If you move the twl4030_usb initialization to after regulator, you should be ok.

[PATCH] USB:otg:twl4030-usb.c: mark .init as subsys_initcall_sync
http://marc.info/?l=linux-usb&m=124913041802639&w=2

I also included the aforementioned patch at the end of

 Re: [PATCH 10/10] OMAP3: update OMAP3 Beagle defconfig, v2
http://marc.info/?l=linux-omap&m=125038741913297&w=2

Regards,

Eric


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
