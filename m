From: Michael Jones <michael.jones@matrix-vision.de>
Subject: high-speed bus on OMAP w/o TT?
Date: Wed, 23 Feb 2011 13:49:21 +0100
Message-ID: <4D650251.3090100@matrix-vision.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail2.matrix-vision.com ([85.214.244.251]:39044 "EHLO
	mail2.matrix-vision.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754170Ab1BWMtX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Feb 2011 07:49:23 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: stern@rowland.harvard.edu, linux-omap@vger.kernel.org

Hi all,

My OMAP37 board started choking on my USB mouse when I updated from
2.6.37 to 2.6.38rc5.  I've tracked it down to commit
d199c96d41d80a567493e12b8e96ea056a1350c1, "USB: prevent buggy hubs from
crashing the USB stack."  If I revert this commit, my mouse works again.
Otherwise, I get the message:

usb 1-1: new low speed USB device using musb-hdrc and address 33
usb 1-1: parent hub has no TT

repeatedly (with 'address' incrementing).

I'm using the musb-hdrc driver for the OTG USB port in host mode.

some relevant config:
CONFIG_USB_EHCI_HCD_OMAP=y
CONFIG_USB_MUSB_HDRC=y
CONFIG_USB_MUSB_OMAP2PLUS=y
CONFIG_USB_MUSB_HOST=y
CONFIG_USB_MUSB_HDRC_HCD=y
CONFIG_USB_INVENTRA_DMA=y

# lsusb
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

Any thoughts on how to get around this besides just reverting the
commit?  Did anybody already encounter this?

thanks,
Michael

MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
