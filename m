From: Rex Feany <rfeany@laeos.net>
Subject: Re: OMAP34xx
Date: Thu, 9 Feb 2012 17:41:21 -0800
Message-ID: <20120210014121.GA7503@rexfeany.com>
References: <20120208231551.GA9009@kroah.com>
 <alpine.DEB.2.00.1202081648510.9540@utopia.booyaka.com>
 <20120209004731.GA11343@kroah.com>
 <4F3374F0.3080002@bitmer.com>
 <20120209133739.GB2590@sirena.org.uk>
 <20120209183624.GJ1426@atomide.com>
 <20120209193442.GA1767@rexfeany.com>
 <87hayzzjlv.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ilona.fnordsoft.com ([173.230.144.79]:35674 "EHLO
	ilona.fnordsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754601Ab2BJBlW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 20:41:22 -0500
Content-Disposition: inline
In-Reply-To: <87hayzzjlv.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Greg KH <gregkh@linuxfoundation.org>, Paul Walmsley <paul@pwsan.com>, Grazvydas Ignotas <notasas@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

Thus spake Kevin Hilman (khilman@ti.com):

> Can you double check that you're building and booting using Tony's -rc3
> based branch?

I believe so, but I cloned it again anyway and it is different from what
I had originally.

> Also, can you do a test using omap2plus_defconfig?

Of course! Serial seems OK with the defconfig, but it doesn't detect the
network chip (it looks like all of the usb stuff is turned off in the
defconfig). dmesg: http://tonya.fnordsoft.com/omap-testing/dmesg-defconfig

I am trying to get usb & networking working, I tried turning on
ohci/ehci and smsc95xx, but it doesn't seem like anything is detected.
Am I just missing a config option? I will go through this more tomorrow,
becuase I have networking working with my other modified defconfig.

dmesg: http://tonya.fnordsoft.com/omap-testing/dmesg-usb-config
config: http://tonya.fnordsoft.com/omap-testing/usb-config 

 USB_EHCI_HCD n -> m
 USB_NET_SMSC95XX n -> y
 USB_OHCI_HCD n -> m
+MFD_OMAP_USB_HOST y
+USB_EHCI_HCD_OMAP y
+USB_EHCI_MV n
+USB_EHCI_ROOT_HUB_TT n
+USB_EHCI_TT_NEWSCHED y
+USB_OHCI_BIG_ENDIAN_DESC n
+USB_OHCI_BIG_ENDIAN_MMIO n
+USB_OHCI_HCD_OMAP1 y
+USB_OHCI_HCD_OMAP3 y
+USB_OHCI_LITTLE_ENDIAN y
+USB_OTG_UTILS y
+USB_SISUSBVGA n

thanks!!
/rex.
