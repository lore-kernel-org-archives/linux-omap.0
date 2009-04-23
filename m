From: twebb <taliaferro62@gmail.com>
Subject: usb-to-eth dongle on usb ehci host port
Date: Thu, 23 Apr 2009 15:13:11 -0400
Message-ID: <dbdb2ea60904231213p7872804elc5cc6f72db445c55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:36552 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759451AbZDWTNO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Apr 2009 15:13:14 -0400
Received: by yx-out-2324.google.com with SMTP id 3so424266yxj.1
        for <linux-omap@vger.kernel.org>; Thu, 23 Apr 2009 12:13:12 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, "omapandroid-discussion@omapzoom.org" <omapandroid-discussion@omapzoom.org>

I'm trying to get network connectivity via a usb-to-eth dongle on
HSUSB2/EHCI port of an OMAP35xx.  The dongle is recognized and
enumerated by the ehci controller, but no eth0 net device is
dynamically created.  I'm passing the basic IP parameters to the
kernel using u-boot kernel args.  Is a particular kernel config
parameter required?  Maybe CONFIG_USB_USBNET and/or
CONFIG_USB_NET_CDCETHER?  (I'm about to try these.)

The dongle is OK because I get network connectivity through it when I
plug the dongle into my linux laptop.  I know this is simple, but I'm
not sure what I'm missing.

Thanks,
twebb
