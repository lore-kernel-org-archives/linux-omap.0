From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: Problems with 3.4-rc5
Date: Wed, 02 May 2012 12:52:51 +0100
Message-ID: <WC20120502115251.8503FF@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.keele.netcentral.co.uk ([212.57.235.197]:51149 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753568Ab2EBLxD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 May 2012 07:53:03 -0400
Received: from terrafix.co.uk (reverse.keele.netcentral.co.uk [212.57.249.250] (may be forged))
	by smtp3.keele.netcentral.co.uk (8.14.2/8.14.2) with ESMTP id q42BqrMH010598
	for <linux-omap@vger.kernel.org>; Wed, 2 May 2012 12:52:58 +0100
Received: from WorldClient by terrafix.co.uk (MDaemon PRO v12.5.4)
	with ESMTP id md50002215802.msg
	for <linux-omap@vger.kernel.org>; Wed, 02 May 2012 12:52:54 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I've just given 3.4-rc5 a quick run-through on my GUMSTIX Overo (AM3703), and have noticed a couple of issues...

Firstly, it fails to build "drivers/mfd/omap-usb-host.c" if you have:

CONFIG_USB_EHCI_HCD=m
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_HCD_OMAP=y

drivers/mfd/omap-usb-host.c: In function 'omap_usbhs_init':
drivers/mfd/omap-usb-host.c:524:3: error: implicit declaration of function 'cpu_is_omap3430'
drivers/mfd/omap-usb-host.c:524:3: error: implicit declaration of function 'omap_rev'
drivers/mfd/omap-usb-host.c:524:43: error: 'OMAP3430_REV_ES2_1' undeclared (first use in this function)
drivers/mfd/omap-usb-host.c:524:43: note: each undeclared identifier is reported only once for each function it appears in

I'm assuming this has been spotted and I've missed the fix (just a missing include?).

Secondly, I get the following when booted:
...
[    4.701232] devtmpfs: mounted
[    4.704772] Freeing init memory: 168K
[    4.827301] omapdss DISPC error: FIFO UNDERFLOW on gfx, disabling the overlay
...

Which means that the display doesn't work.

I am currently running 3.3, which works just fine and doesn't give an underflow.

So was wondering what changes have been made that may affect this? There were problems in the 3.2-era due to runtime-
PM causing a similar issue, has anything changed around here again?

(as a side not: the panel I use is a custom 800x480 added to panel-generic-dpi.c, with board-overo.c updated to use it).

Cheers,
Joe Woodward


