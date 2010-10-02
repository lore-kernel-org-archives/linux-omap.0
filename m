From: Tony Lindgren <tony@atomide.com>
Subject: NOTE: hwmod changes merged to linux-omap master for testing
Date: Fri, 1 Oct 2010 17:48:22 -0700
Message-ID: <20101002004821.GN3117@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54061 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610Ab0JBAsX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 20:48:23 -0400
Received: from c-67-188-36-105.hsd1.ca.comcast.net ([67.188.36.105] helo=localhost.localdomain)
	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1P1qH1-0004ND-3H
	for linux-omap@vger.kernel.org; Sat, 02 Oct 2010 00:48:23 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

So I've finally merged Kevin's hwmod branch into the linux-omap
master so we can give it some testing to see if we can merge it
to the mainline. Might take few minutes to hit the mirrors.

Please note that for omap2plus machines you need to change:

- u-boot bootargs for kernel cmdline needs to change with setenv
- if you use hardcoded CONFIG_CMDLINE, change it in your .config
- /etc/inittab in your omap root file system if using serial console

This is because otherwise the serial-omap would be conflicting
with the 8250 driver. This should not affect omap1 machines.

Please give it a try and report any issues on this list! Now
all the machines except ams_delta_defconfig should build.
That one is still missing some camera driver changes to build.

Regards,

Tony
