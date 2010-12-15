From: Tomasz Mloduchowski <tomasz.mloduchowski@xlogic.pl>
Subject: Re: twl4030_usb porting advice
Date: Wed, 15 Dec 2010 12:27:10 +0000
Message-ID: <4D08B41E.7090400@xlogic.pl>
References: <4D08ACAC.8070900@xlogic.pl> <20101215121023.GN2997@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from xen-13-178-63-247-83.statnet.pl ([178.63.247.83]:43609 "EHLO
	xlogic.pl" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753452Ab0LOM1t (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Dec 2010 07:27:49 -0500
In-Reply-To: <20101215121023.GN2997@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org

>> I would gladly welcome any pointers that could help me solve this issue.
>
> you're connecting a FS/LS device to EHCI port, that doesn't work. OMAP
> can't handle port handoff to companion OHCI controller, then it fails
> not being able to enumerate the device. Try remuxing your port to OHCI
> controller and disabling EHCI from Kconfig.

It actually is a HS device (it's a 4-port hub) - when booting the vendor 
supplied kernel (based off 2.6.32, i.e. pre -IR redesign), the device 
identifies as follows:

Bus 001 Device 002: ID 05e3:0608 Genesys Logic, Inc. USB-2.0 4-Port HUB

with the following boot messages:

usb 1-2: new high speed USB device using ehci-omap and address 2
usb 1-2: New USB device found, idVendor=05e3, idProduct=0608
usb 1-2: New USB device strings: Mfr=0, Product=1, SerialNumber=0
usb 1-2: Product: USB2.0 Hub
hub 1-2:1.0: USB hub found
hub 1-2:1.0: 4 ports detected


I've pasted the boot log for my kernel:
http://pastie.org/1379102

And the boot log for the original kernel:
http://pastie.org/1379100

Cheers,
Tomasz


