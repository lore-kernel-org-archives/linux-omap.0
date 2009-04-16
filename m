From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: ehci problem on OMAP35xx
Date: Thu, 16 Apr 2009 12:26:11 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404280467EF@dbde02.ent.ti.com>
References: <dbdb2ea60904150904j232e2803wb1dc973d727b941c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35298 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751226AbZDPG4V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Apr 2009 02:56:21 -0400
In-Reply-To: <dbdb2ea60904150904j232e2803wb1dc973d727b941c@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: twebb <taliaferro62@gmail.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of twebb
> Sent: Wednesday, April 15, 2009 9:35 PM
> To: linux-omap@vger.kernel.org Mailing List
> Subject: ehci problem on OMAP35xx
> 
> I'm having issues getting USB up and going on HSUSB2/EHCI on
> OMAP35xx-based hardware (very similar to beagle board).  We're using
> an SMSC3317 connected to HSUSB2, and in turn, the 3317 is connected to
> an onboard hub - a SMSC USB2513.  When the hub is removed from reset,
> it appears that handshaking/chirping starts to happen between xcvr and
> hub, but ends with the code announcing that it is "unable to enumerate
> USB device on port 2".  I'm guessing it's failing because we never see
> PED set in the PORTSC_1 reg (and we are seeing PO=1 which doesn't make
> any sense).

Here is the PED (Port Enable/Disable) description:
Ports can only be enabled by the host controller as a part of the reset and enable.
Software cannot enable a port by writing a one to this field. "The host controller 
will only set this bit to a one when the reset sequence determines that the 
attached device is a high-speed device"

So it seems there is some problem in detecting high speed signaling.

PO (Port Ownership) description:
System software uses this field to release ownership of the port to a selected
Host controller (in the event that the attached device is not a high-speed device).
Software writes a one to this bit when the attached device is not a high-speed 
device. "A one in this bit means that a companion host controller owns and 
controls the port."

This is in same line as above. As there is problem in detecting high speed
Signaling so the ownership is given to other host controller for the attached hub.

Ajay

> 
> I'm running a l-o git-based 2.6.28-omap1 kernel with
> omap3_beagle_defconfig.  Beagle board works fine (with patch to
> ehci-omap.c and with CONFIG_USB_EHCI_HCD turned on), but my hardware
> (with virtually same xcvr and and onboard hub) does not.
> 
> Kind of new to this low level USB functionality, so a few questions...
> 1.  Any ideas why we'd see PORTSC_1[PO] = 1?
> 2.  Any suggestions on debugging basic connectivity between 35xx EHCI
> controller and transceiver + hub?
> 
> Thanks,
> twebb
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

