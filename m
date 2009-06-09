From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: MUSB Host problems
Date: Tue, 9 Jun 2009 23:19:21 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F52BB6F3@dbde02.ent.ti.com>
References: <4A2E9FD5.9090807@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55969 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752473AbZFIRta convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Jun 2009 13:49:30 -0400
In-Reply-To: <4A2E9FD5.9090807@mlbassoc.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Gary
>Thomas
>Sent: Tuesday, June 09, 2009 12:46 PM
>To: linux-omap@vger.kernel.org
>Subject: MUSB Host problems
>
>I'm trying to get MUSB Host working on my 3530 platform (very

Based on your description, its not MUSB but the USBHOST EHCI block that you want to get working.

>similar to the Beagle).  When I startup, I get this message:
>  Clock usbhost_48m_fck didn't enable in 100000 tries

This is bad

>
>What does this mean?  How do I fix it?
>
>Currently, the USB subsystem finds the various hubs (ports 0-2).
>The OTG port (0) works great.  When I plug in a device to USB-1,

Is this a full speed device? 

>it sees it, but immediately gives up :-(
>    ehci-omap ehci-omap.0: GetStatus port 1 status 001803 POWER sig=j CSC CONNECT
>    hub 1-0:1.0: port 1: status 0501 change 0001
>    hub 1-0:1.0: state 7 ports 3 chg 0002 evt 0000
>    hub 1-0:1.0: port 1, status 0501, change 0000, 480 Mb/s
>    ehci-omap ehci-omap.0: port 1 full speed --> companion

Looks like your device is getting recognized as a full speed.
So EHCI cannot handle it.

You need to have OHCI driver built in which is not present in linux-omap code base.

>    ehci-omap ehci-omap.0: GetStatus port 1 status 003801 POWER OWNER sig=j CONNECT
>    hub 1-0:1.0: port 1 not reset yet, waiting 50ms
>    ehci-omap ehci-omap.0: GetStatus port 1 status 003002 POWER OWNER sig=se0 CSC
>    hub 1-0:1.0: unable to enumerate USB device on port 1
>    hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0002
>    hub 1-0:1.0: hub_suspend
>Then it's dead.  Any ideas?
>
>Thanks
>
>--
>------------------------------------------------------------
>Gary Thomas                 |  Consulting for the
>MLB Associates              |    Embedded world
>------------------------------------------------------------
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

