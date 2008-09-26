From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 0/2] PM counters
Date: Fri, 26 Sep 2008 17:12:00 +0300
Message-ID: <1222438323-14197-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:63658 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbYIZOP3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 10:15:29 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8QEFKNe016578
	for <linux-omap@vger.kernel.org>; Fri, 26 Sep 2008 17:15:26 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patch introduces counters for the various PM states in OMAP3.

Peter 'p2' De Schrijver (2):
  PM counter infrastructure.
  Hook into PM counters

 arch/arm/mach-omap2/clock.c                   |    2 +
 arch/arm/mach-omap2/clockdomain.c             |    4 +
 arch/arm/mach-omap2/pm34xx.c                  |    6 ++
 arch/arm/mach-omap2/powerdomain.c             |   94 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/powerdomain.h |    7 ++
 5 files changed, 113 insertions(+), 0 deletions(-)

