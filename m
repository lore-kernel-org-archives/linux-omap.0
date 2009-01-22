From: david.hagood@gmail.com
Subject: Odd behavior in musb_hdrc OTG if gadget drivers are modules
Date: Thu, 22 Jan 2009 15:46:28 -0600 (CST)
Message-ID: <6cc6e376b34fd371cf946c1660c97f6e.squirrel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f20.google.com ([209.85.219.20]:54436 "EHLO
	mail-ew0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527AbZAVVqh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Jan 2009 16:46:37 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

I've spend the day tracking down a weird behavior on a Beagleboard with
2.6.29-rc2-omap1.

If you select the mode for the musb to operate in OnTheGo mode
(CONFIG_USB_MUSB_OTG), and if you compile the gadget drivers as modules,
the the USB port will NOT be brought up at system boot, even if it has a
USB mini-A cable plugged in (and thus should be in host mode, not gadget
mode).

If you then modprobe an appropriate gadget driver, then the interface will
be brought up in host mode.

If you DON'T modprobe a gadget driver, AND you attempt to force the port
to host mode by
  echo host > /sys/devices/platform/musb_hdrc/mode

Then we get a kernel page fault trying to change modes, even though we are
changing to host mode, which should be valid.

It seems to me that either the port should be brought up in host mode if
no gadget drivers are loaded, and an attempt to switch to gadget mode
should fail if no driver is loaded, OR there should be a config options to
set what the default gadget driver is in the absence of one being loaded
by the system.


