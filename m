From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/2] cpufreq: cpufreq-cpu0: cleanups around DT usage
Date: Mon, 11 Mar 2013 18:05:28 -0500
Message-ID: <1363043130-30270-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:43190 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994Ab3CKXFe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Mar 2013 19:05:34 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: cpufreq <cpufreq@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org

The following series arose from trying to use BeagleBoard-XM (OMAP3 variant)
for doing CPU DVFS using cpufreq-cpu0.

This is also an attempt to slowly remove the dependence on omap-cpufreq
driver and be entirely driven off cpufreq-cpu0 driver.

Somewhere in the future, when we have regulators driven off CCF and OMAP
converted to CCF, we could remove the DT regulator requirements as well.

Based on v3.9-rc2 tag

Nishanth Menon (2):
  cpufreq: cpufreq-cpu0: support for clock which are not in DT yet.
  cpufreq: cpufreq-cpu0: provide compatibility string for DT matchup

 .../devicetree/bindings/cpufreq/cpufreq-cpu0.txt   |    6 ++++++
 drivers/cpufreq/cpufreq-cpu0.c                     |   12 +++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-kernel@vger.kernel.org
Cc: cpufreq@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-omap@vger.kernel.org

This series in addition to the following DT changes (temporary):
http://pastebin.com/h5uysj0i

Screen shot of the voltage changes using cpufreq-cpu0 on Xm:
http://goo.gl/vVEjd

OMAP Caveat: AVS+ABB still wont work with just these changes.
More to come as we progress.

-- 
1.7.9.5

Regards,
Nishanth Menon
