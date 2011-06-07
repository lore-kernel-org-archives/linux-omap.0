From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [RFC] OMAP: McBSP not working if CONFIG_PM_RUNTIME not set
Date: Tue, 7 Jun 2011 21:18:33 +0200
Message-ID: <201106072118.33632.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:57926 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753292Ab1FGTYg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Jun 2011 15:24:36 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: linux-pm@lists.linux-foundation.org

Hi,

While solving this problem:
http://www.spinics.net/lists/linux-omap/msg52011.html,
I found that since commit e95496d4acadd0b72c4947be61e8d44700fdaae7, 
"OMAP: McBSP: Add pm runtime support", McBSP ports, or at least McBSP1 
on my Amstrad Delta, no longer work when CONFIG_PM_RUNTIME is not set. 
Even if I don't use such setup and always select CONFIG_PM_RUNTIME, I 
think current behaviour is wrong and should be corrected.

Before I come out with a patch, please advise if and how you think this 
should be solved. Should CONFIG_OMAP_MCBSP depend on CONFIG_PM_RUNTIME?
Or should it select CONFIG_PM_RUNTIME? Or maybe an old code which 
manipulated clocks directly should be restored for no CONFIG_PM_RUNTIME 
case? Or should arch/arm/mach-omap1/pm_bus.c be always built in and 
pm_runtime_clk_add_notifier() called from there in order to enable 
clocks on device initialization even if CONFIG_PM_RUNTIME is not set? Or 
still a better solution?

Thanks,
Janusz
