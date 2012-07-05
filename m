From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: PM/RTC 3.5-rc5: System suspends fails when not built with RTC?
Date: Thu, 05 Jul 2012 16:03:14 +0100
Message-ID: <WC20120705150314.450045@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp3.keele.netcentral.co.uk ([212.57.235.197]:55883 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752351Ab2GEPD0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Jul 2012 11:03:26 -0400
Received: from terrafix.co.uk (reverse.keele.netcentral.co.uk [212.57.249.250] (may be forged))
	by smtp3.keele.netcentral.co.uk (8.14.2/8.14.2) with ESMTP id q65F3Hn2028841
	for <linux-omap@vger.kernel.org>; Thu, 5 Jul 2012 16:03:22 +0100
Received: from WorldClient by terrafix.co.uk (MDaemon PRO v12.5.6)
	with ESMTP id md50002247217.msg
	for <linux-omap@vger.kernel.org>; Thu, 05 Jul 2012 16:03:18 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I've got 3.5-rc5 with the following patches applied to get system suspend working on OMAP3:
  - fix the DSS: OMAPDSS: Use PM notifiers for system suspend
  - fix the 32KHz clock: ARM: OMAP2+: hwmod code/clockdomain data: fix 32K sync timer

This has been built with the omap2plus_defconfig.

However, If I disable the RTC (i.e. CONFIG_RTC_CLASS/CONFIG_RTC_DRV_TWL4030) and rebuild then when suspending the device never wakes up.

That is, I can't get any wakeups to happen (either through the console, or GPIO buttons) hence I'm assuming the kernel has crashed...

Any ideas?

As far as I know there is no dependency on the RTC in 3.4, and with the RTC compiled in I never see a problem on 3.5-rc5.

Cheers,
Joe


