From: Tony Lindgren <tony@atomide.com>
Subject: Re: beagleboard expansion boards, was Trying to understand how to
 use new OMAP mux code
Date: Wed, 2 Jun 2010 17:44:11 +0300
Message-ID: <20100602144410.GL5980@atomide.com>
References: <738b3f7e1003111424t34326158j570980c691a98853@mail.gmail.com>
 <20100311224812.GU2900@atomide.com>
 <4C062DD4.2050701@cioinfoindus.fr>
 <20100602112130.GG5980@atomide.com>
 <20100602144606.4287c438.jhnikula@gmail.com>
 <3BC7A992-11AB-4EBF-B7A5-4C4B1498CC58@student.utwente.nl>
 <20100602161418.c6af218b.jhnikula@gmail.com>
 <20100602135709.GK5980@atomide.com>
 <2305B135-F746-4734-9A68-5AE748334678@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58089 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757945Ab0FBOoQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jun 2010 10:44:16 -0400
Content-Disposition: inline
In-Reply-To: <2305B135-F746-4734-9A68-5AE748334678@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Laurent Epinat <laurent.epinat@cioinfoindus.fr>, linux-omap@vger.kernel.org

* Koen Kooi <koen@dominion.thruhere.net> [100602 17:01]:
> 
> "Support all beagle expansion boards mentioned in http://elinux.org/BeagleBoardPinMux#Vendor_and_Device_IDs out of the box"
> 
> That means that a user can plug in an expansion board, apply power and it will "just work". That's the case now for the zippy, zippy2, trainer and beaglefpga boards with the current u-boot and kernel setup. I agree it doesn't scale, but I haven't seen any actual effort by the beagleboard/omap3 community to make the muxing and initializing the board (i2c, spi, gpio, rtc) work completely in the kernel :(

Well how about patch u-boot to allow saveenv the revision
and then pass it to kernel as ATAG_REVISION? That's available
as system_rev in the kernel. Then you can initialize the platform
devices in the board-*.c files.

The other option would be to somehow to detect the hardware
during the boot, but that may not work for all the devices.

Regards,

Tony
