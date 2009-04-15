From: twebb <taliaferro62@gmail.com>
Subject: ehci problem on OMAP35xx
Date: Wed, 15 Apr 2009 12:04:37 -0400
Message-ID: <dbdb2ea60904150904j232e2803wb1dc973d727b941c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:64707 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbZDOQEj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Apr 2009 12:04:39 -0400
Received: by yw-out-2324.google.com with SMTP id 5so3160781ywb.1
        for <linux-omap@vger.kernel.org>; Wed, 15 Apr 2009 09:04:38 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

I'm having issues getting USB up and going on HSUSB2/EHCI on
OMAP35xx-based hardware (very similar to beagle board).  We're using
an SMSC3317 connected to HSUSB2, and in turn, the 3317 is connected to
an onboard hub - a SMSC USB2513.  When the hub is removed from reset,
it appears that handshaking/chirping starts to happen between xcvr and
hub, but ends with the code announcing that it is "unable to enumerate
USB device on port 2".  I'm guessing it's failing because we never see
PED set in the PORTSC_1 reg (and we are seeing PO=1 which doesn't make
any sense).

I'm running a l-o git-based 2.6.28-omap1 kernel with
omap3_beagle_defconfig.  Beagle board works fine (with patch to
ehci-omap.c and with CONFIG_USB_EHCI_HCD turned on), but my hardware
(with virtually same xcvr and and onboard hub) does not.

Kind of new to this low level USB functionality, so a few questions...
1.  Any ideas why we'd see PORTSC_1[PO] = 1?
2.  Any suggestions on debugging basic connectivity between 35xx EHCI
controller and transceiver + hub?

Thanks,
twebb
