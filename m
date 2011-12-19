From: Peter Barada <peter.barada@logicpd.com>
Subject: linux-3.0: system suspend leaves usbhost clocks enabled
Date: Mon, 19 Dec 2011 17:02:00 -0500
Message-ID: <4EEFB458.1050100@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 174-46-170-154.static.twtelecom.net ([174.46.170.154]:39867
	"HELO edprlnx06.logicpd.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with SMTP id S1751646Ab1LSWLz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Dec 2011 17:11:55 -0500
Received: from [172.16.10.2] (unknown [172.16.10.2])
	by edprlnx06.logicpd.com (Postfix) with ESMTP id A9572600095
	for <linux-omap@vger.kernel.org>; Mon, 19 Dec 2011 16:02:14 -0600 (CST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I'm working with linux-3.0 (I know its not the latest), and I have the
USB host working.

However when I try to suspend, the usbhost power domain doesn't go into
suspend.  I've added code to capture the PRCM registers in SRAM just
before the WFI is executed and dump them after it resumes.  For usbhost
I'm seeing:

48005400 CM_FCLKEN_USBHOST    00000003 != 00000000
48005410 CM_ICLKEN_USBHOST    00000001 != 00000000
48005420 CM_IDLEST_USBHOST    00000000 != 00000003

Which means that the usbhost interface/function clocks are not
disabled.  I also noticed in the core/peripheral domain that a lot of
interface clocks are enabled (compared to the older 2.6.32 kernel I was
working on), even for devices that I don't have any platform_device
for(so the device's probe will fail).

As far as I can tell, the only place the usbhost f/i clocks are enabled
is in omap_hsusb_enable(), and  disabled in omap_hsusb_disable().  I see
omap_hsusb_eneable() called on startup, but never see
omap_hsusb_disable() called during system suspend.

Any ideas how I can get the usbhost clocks disabled across a board suspend?

-- 
Peter Barada
peter.barada@logicpd.com

