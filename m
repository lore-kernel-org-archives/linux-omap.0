From: Gary Thomas <gary@mlbassoc.com>
Subject: MUSB Host problems
Date: Tue, 09 Jun 2009 11:45:57 -0600
Message-ID: <4A2E9FD5.9090807@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:3996 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbZFIRp6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Jun 2009 13:45:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I'm trying to get MUSB Host working on my 3530 platform (very
similar to the Beagle).  When I startup, I get this message:
  Clock usbhost_48m_fck didn't enable in 100000 tries

What does this mean?  How do I fix it?

Currently, the USB subsystem finds the various hubs (ports 0-2).
The OTG port (0) works great.  When I plug in a device to USB-1,
it sees it, but immediately gives up :-(
    ehci-omap ehci-omap.0: GetStatus port 1 status 001803 POWER sig=j CSC CONNECT
    hub 1-0:1.0: port 1: status 0501 change 0001
    hub 1-0:1.0: state 7 ports 3 chg 0002 evt 0000
    hub 1-0:1.0: port 1, status 0501, change 0000, 480 Mb/s
    ehci-omap ehci-omap.0: port 1 full speed --> companion
    ehci-omap ehci-omap.0: GetStatus port 1 status 003801 POWER OWNER sig=j CONNECT
    hub 1-0:1.0: port 1 not reset yet, waiting 50ms
    ehci-omap ehci-omap.0: GetStatus port 1 status 003002 POWER OWNER sig=se0 CSC
    hub 1-0:1.0: unable to enumerate USB device on port 1
    hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0002
    hub 1-0:1.0: hub_suspend
Then it's dead.  Any ideas?

Thanks

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
