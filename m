From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 0/2] PM counters
Date: Wed, 15 Oct 2008 17:48:42 +0300
Message-ID: <1224082124-24439-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:28163 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207AbYJOOtO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 10:49:14 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9FEmWe6012002
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 09:49:12 -0500
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
 arch/arm/mach-omap2/powerdomain.c             |  101 ++++++++++++++++++++++++-
 arch/arm/plat-omap/include/mach/powerdomain.h |    7 ++
 5 files changed, 118 insertions(+), 2 deletions(-)

