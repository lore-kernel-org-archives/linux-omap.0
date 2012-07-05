From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: PM/UART 3.5-rc5: UART Rx wakeups not quite right?
Date: Thu, 05 Jul 2012 14:38:59 +0100
Message-ID: <WC20120705133859.690032@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp3.keele.netcentral.co.uk ([212.57.235.197]:44043 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753487Ab2GENjO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Jul 2012 09:39:14 -0400
Received: from terrafix.co.uk (reverse.keele.netcentral.co.uk [212.57.249.250] (may be forged))
	by smtp3.keele.netcentral.co.uk (8.14.2/8.14.2) with ESMTP id q65Dd24Z027331
	for <linux-omap@vger.kernel.org>; Thu, 5 Jul 2012 14:39:08 +0100
Received: from WorldClient by terrafix.co.uk (MDaemon PRO v12.5.6)
	with ESMTP id md50002247128.msg
	for <linux-omap@vger.kernel.org>; Thu, 05 Jul 2012 14:39:04 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Are there any patches floating around to fix UART Rx wakeups for 3.5?

I have a GUMSTIX Overo with various things hanging off the UARTs, one
of which (on ttyO0) sends in periodic (GPS) data.

I don't want this data to wake the OMAP from system suspend.

I would normally disable UART Rx wakeup for ttyO0:
# echo "disabled" > /sys/devices/platform/omap_uart.0/power/wakeup

This works on 3.5-rc5 (i.e. I can suspend, and not immediately wake) UNTIL
I run an application that opens /dev/ttyO0.

At this point when entering system suspend ttyO0 wakes the OMAP up
immediately, even though the SYSFS reports the wakeup as "disabled".

Any ideas?

Cheers,
Joe


