From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 0/2] Bug fixes for DVFS
Date: Tue,  2 Dec 2008 17:31:15 +0200
Message-ID: <1228231877-18114-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:63513 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754596AbYLBPbz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Dec 2008 10:31:55 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mB2FVBuR029357
	for <linux-omap@vger.kernel.org>; Tue, 2 Dec 2008 09:31:53 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

The following patchset fixes some smaal bugs in cpufreq for OMAP3.
The first patch fixes omap_getspeed to return meaningful values.
The second patch makes sure the omap cpufreq driver is initialized after
the cpufreq frameworks and governors are initialized.

Peter 'p2' De Schrijver (2):
  Fix omap_getspeed.
  Make sure omap cpufreq driver initializes after cpufreq framework and
    governors

 arch/arm/mach-omap2/clock34xx.c |    1 +
 arch/arm/plat-omap/cpu-omap.c   |    8 +++++++-
 2 files changed, 8 insertions(+), 1 deletions(-)

