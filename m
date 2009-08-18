From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: MUSB regression in 2.6.31-rc6
Date: Tue, 18 Aug 2009 10:31:44 +0300
Message-ID: <20090818103144.e44df407.jhnikula@gmail.com>
References: <6055571.1250544429670.JavaMail.root@elwamui-hound.atl.sa.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f214.google.com ([209.85.219.214]:37327 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243AbZHRHaN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Aug 2009 03:30:13 -0400
In-Reply-To: <6055571.1250544429670.JavaMail.root@elwamui-hound.atl.sa.earthlink.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ewitcher <ewitcher@mindspring.com>
Cc: Kalle Valo <kalle.valo@iki.fi>, felipe.balbi@nokia.com, "Gadiyar,Anand" <gadiyar@ti.com>, "Gupta,Ajay Kumar" <ajay.gupta@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 17 Aug 2009 17:27:09 -0400 (GMT-04:00)
ewitcher <ewitcher@mindspring.com> wrote:

> Hello,
> 
> The below referenced patch was helpful to me in resolving the
> 
> <3>twl4030_usb twl4030_usb: ldo init failed
> 
> error.
> 
> Examining the minicom.cap attachment, I can see that twl4030_usb  is initialized before regulator.  If you move the twl4030_usb initialization to after regulator, you should be ok.
> 
> [PATCH] USB:otg:twl4030-usb.c: mark .init as subsys_initcall_sync
> http://marc.info/?l=linux-usb&m=124913041802639&w=2
> 
Thanks! That patch and Felipe's patch to board-omap3beagle.c made it
booting.

http://marc.info/?l=linux-arm-kernel&m=125007992121335&w=2

However, I'm not able to get a bit going but at least now one is able to
debug it. There is only this "unexpected notification 03!" seen on pc
side when the cable is plugged in.

Beagle:
g_ether gadget: high speed config #1: CDC Ethernet (ECM)

PC:
usb0: register 'cdc_ether' at usb-0000:00:1d.7-1, CDC Ethernet Device,
a6:9c:9f:d0:8a:65
usb0: CDC: unexpected notification 03!


-- 
Jarkko
