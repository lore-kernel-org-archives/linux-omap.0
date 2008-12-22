From: Otto Solares <solca@guug.org>
Subject: Nokia Internet Tablets
Date: Mon, 22 Dec 2008 04:34:22 -0600
Message-ID: <20081222103422.GL29448@guug.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from guug.org ([200.9.255.30]:2471 "EHLO guug.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752013AbYLVKjX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Dec 2008 05:39:23 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all!

I want to resurrect missing support for the Nokia Internet Tablets
starting with the N8x0s for my NITdroid project, which uses just
standard Linux kernel APIs.

So first I would like to ask some very newbie questions:

-Is there any ongoing effort to support these devices in latest kernels
 at the same level as the latest Nokia production kernel (2.6.21-omap)?

-I don't plan to suspend but just sleep while idling, is this a good
 approach to power management (pm)?

-I read about the pm branch, where can I pull it?

-What it does mean retention state for OMAP2 processors? As far as I
 can figure is some deep sleep state?

-If it is a sleep state, what are the conditions to get in? any way to
 check or how to know if it get in?

-Does CONFIG_NO_HZ works for this devices?

-Disabling serial support in linux-omap can I get rid of the serial
 clocks so it more easily get in deep sleep states?

-2.6.21-omap had DVFS for OMAP2, why it was removed and what is needed
 to port it back to latest linux-omap kernel so cpufreq scaling works?

-Same for the camera drivers, why it was removed and what is required
 to port it back?

-AFAIK the recent removals of the N800 sound driver was because it was
 not written for ALSA OMAP SoC API, right?

-Can the retu RTC be ported to the CONFIG_RTC_CLASS API?

-Are the CONFIG_REGULATOR and CONFIG_POWER_SUPPLY APIs of any use for
 the Internet Tablets?

If it is lack of time of the original developers, I would like to step
in, willing to try to complete this work as long as you are willing to
support me with answers to my newbie questions as this devices are in
plenty operation today but the Nokia kernel is getting really old and
it's a good thing if we can port all the drivers to standard Linux API.

Thx in advance!

-otto
