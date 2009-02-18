From: Rick Bronson <rick@efn.org>
Subject: USB on OMAP3530
Date: Wed, 18 Feb 2009 08:46:17 -0800
Message-ID: <E1LZpYv-0003FK-Ae@amazonia.comcast.net>
Reply-To: rick@efn.org
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from efn.org ([206.192.230.249]:34060 "EHLO samwise.efn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755389AbZBRRRO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Feb 2009 12:17:14 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello,

  I've got a new board with a OMAP3530 that's wired to a "ULPI Hi-Speed
USB host and peripheral transceiver" (NXP ISP1505) on UH0-D0-7,
UH0-CLK, UH0-STP, UH0-DIR, UH0-NXT.  There is also a mux to switch
from host to device on GPIO_140.

  What set of kernel configs should I enable?  Here's what I have:

CONFIG_USB_HID=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_SUSPEND=y
CONFIG_USB_OTG=y
CONFIG_USB_MON=y
CONFIG_USB_MUSB_HDRC=y
CONFIG_USB_MUSB_SOC=y
CONFIG_USB_MUSB_OTG=y
CONFIG_USB_GADGET_MUSB_HDRC=y
CONFIG_USB_MUSB_HDRC_HCD=y
CONFIG_USB_INVENTRA_DMA=y
CONFIG_USB_STORAGE=y
CONFIG_USB_TEST=y
CONFIG_USB_GADGET=y
CONFIG_USB_GADGET_SELECTED=y
CONFIG_USB_GADGET_DUALSPEED=y
CONFIG_USB_ETH=y
CONFIG_USB_ETH_RNDIS=y
CONFIG_USB_OTG_UTILS=y

  Any help greatly appreciated.

  Rick Bronson

                                                                   _
                                                                  | |
                                                                  / /__
.----------------------------------------------------------._____/ (___)
| Rick Bronson    rick at efn dot org    Tel 541-485-7264  |       (___)
| Amazonia Computing http://www.efn.org/~rick      __ o    |_____  (___)
| 5050 Donald Street     "Onde esta dinheiro?"    _`\<,    |     \_(___)
| Eugene, OR  97405       -- Gal Costa         __( )/( )__ |
`----------------------------------------------------------'
