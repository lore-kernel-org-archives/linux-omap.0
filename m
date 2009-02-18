From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 0/1] OMAP3 PM Add C0 state
Date: Wed, 18 Feb 2009 18:21:57 +0200
Message-ID: <1234974118-27446-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:52403 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbZBRQWF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Feb 2009 11:22:05 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n1IGLeeY003412
	for <linux-omap@vger.kernel.org>; Wed, 18 Feb 2009 18:22:01 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patch introduces a new C state C0 which keeps both core and mpu
powerdomains in ON state. This gives us low latency at a cost of higher
power consumption.

Peter 'p2' De Schrijver (1):
  OMAP3 PM Add C0 state

 arch/arm/mach-omap2/cpuidle34xx.c |   53 ++++++++++++++++++++++++++++++-------
 1 files changed, 43 insertions(+), 10 deletions(-)

