From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: twl4030-usb.c
Date: Wed, 21 Jan 2009 13:10:59 +0200
Message-ID: <1232536259.6515.351.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gate.edelkey.net ([213.138.147.140]:42878 "EHLO
	gate.edelkey.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400AbZAUL2e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Jan 2009 06:28:34 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com


The twl4030-usb.c seems to have moved from /drivers/usb/otg back
to /drivers/i2c/chips after the recent mainline merge. Felipe, any plans
to put it back to drivers/usb/otg?

I have a patch for twl4030-usb enabling regulator switching, so I'm just
wondering against what tree should I post the patch. And to which list?

- Kalle
