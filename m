From: David Brownell <david-b@pacbell.net>
Subject: Re: usb-to-eth dongle on usb ehci host port
Date: Thu, 23 Apr 2009 15:12:17 -0700
Message-ID: <200904231512.17869.david-b@pacbell.net>
References: <dbdb2ea60904231213p7872804elc5cc6f72db445c55@mail.gmail.com> <1240515055.7362.218.camel@sax-lx.fischerfamily.org> <dbdb2ea60904231300q6fb09390hf0ab0222393bc2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:40032 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753385AbZDWWMT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Apr 2009 18:12:19 -0400
In-Reply-To: <dbdb2ea60904231300q6fb09390hf0ab0222393bc2e@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: twebb <taliaferro62@gmail.com>
Cc: todd.fischer@ridgerun.com, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, "omapandroid-discussion@omapzoom.org" <omapandroid-discussion@omapzoom.org>

On Thursday 23 April 2009, twebb wrote:
> =A0It does look like it
> recognizes it ("REALTEK USB 10/100 LAN"), but how to tell if it
> recognizes it specifically as a eth adaptor?

drivers/net/usb/Kconfig has a USB_RTL8150 entry you might try.

> usb 1-2.2: New USB device found, idVendor=3D0bda, idProduct=3D8150
> usb 1-2.2: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=
=3D3
> usb 1-2.2: Product: USB 10/100 LAN
> usb 1-2.2: Manufacturer: REALTEK
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
