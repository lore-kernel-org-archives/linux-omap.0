From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 0/3] debugfs entries for PM counters
Date: Tue, 14 Oct 2008 17:39:55 +0300
Message-ID: <1223995198-19985-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:54139 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbYJNOkm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 10:40:42 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9EEdrre022215
	for <linux-omap@vger.kernel.org>; Tue, 14 Oct 2008 09:40:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patchset adds 2 debugfs entries for power management counters.
pm_debug/count indicates how many times each powerdomain entered each state
(On, Inactive, Retention, Off).
pm_debug/time indicates how much time each powerdomain spent per state.

Peter 'p2' De Schrijver (3):
  Add closures to clkdm_for_each.
  Add pm-debug counters
  Hook into powerdomain code

 arch/arm/mach-omap2/clockdomain.c             |    5 +-
 arch/arm/mach-omap2/pm-debug.c                |  175 +++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.h                      |    2 +
 arch/arm/mach-omap2/pm34xx.c                  |    8 +-
 arch/arm/mach-omap2/powerdomain.c             |   24 +++-
 arch/arm/plat-omap/include/mach/clockdomain.h |    3 +-
 arch/arm/plat-omap/include/mach/powerdomain.h |    8 +-
 7 files changed, 209 insertions(+), 16 deletions(-)

