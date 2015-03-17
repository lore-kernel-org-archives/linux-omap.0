From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 0/2] Couple of dmtimer fixes
Date: Mon, 16 Mar 2015 20:14:01 -0500
Message-ID: <1426554843-42641-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53367 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709AbbCQBOc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Mar 2015 21:14:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

Hi Tony,

Please find couple of non-urgent fixes to the OMAP dmtimer driver.
The patches are based on 4.0-rc1.

The first patch is a fix for the issue I reported earlier on the
DRA7 dmtimer hwmod patches [1]. DRA7 has timers 13 through 16 disabled
in DT currently, and enabling any of them would cause a kernel hang.
This fix properly checks the pm_runtime_get_sync() calls in the OMAP
dmtimer driver irrespective of whether the hwmods are added or not.
In the case that they are not added, the runtime_pm calls should return
the value as returned from _od_fail_runtime_resume(), and the probe
should bail out properly fixing the boot hang.

Second patch is a minor fix that balances the pm_runtime_enable() call
in probe with pm_runtime_disable() call in remove, so that the devices
can be bound again properly after doing an unbind through sysfs.

regards
Suman

[1] http://marc.info/?l=linux-omap&m=142653933112526&w=2

Suman Anna (2):
  ARM: OMAP: dmtimer: check for pm_runtime_get_sync() failure
  ARM: OMAP: dmtimer: disable pm runtime on remove

 arch/arm/plat-omap/dmtimer.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

-- 
2.3.2

