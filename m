From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 0/5] Move PM debug counters to normal PM code. Preview with sequence numbers
Date: Wed, 24 Sep 2008 17:11:53 +0300
Message-ID: <1222265518-7230-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:58110 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbYIXOME (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 10:12:04 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8OEBkDK013064
	for <linux-omap@vger.kernel.org>; Wed, 24 Sep 2008 17:12:01 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patchset makes the PM counters no longer debug only. This will allow drivers to decide if they need to reinitialize the hardware due to an off to on transition. Patchset was made against the pm-0 branch.

Peter 'p2' De Schrijver (5):
  Move some counter functions to powerdomain.c
  Adapt prototypes for counter functions
  Move counter function into generic OMAP PM
  Make counter types unsigned, add closure pointer to pwrdm_for_each,
    add prototypes
  Add hooks to PM layer and clock tree for PM counters

 arch/arm/mach-omap2/clock.c                   |    3 +-
 arch/arm/mach-omap2/clockdomain.c             |    4 +-
 arch/arm/mach-omap2/pm-debug.c                |  107 ++++--------------------
 arch/arm/mach-omap2/pm.h                      |   14 +--
 arch/arm/mach-omap2/pm34xx.c                  |   10 +-
 arch/arm/mach-omap2/powerdomain.c             |  113 +++++++++++++++++++++++--
 arch/arm/plat-omap/include/mach/powerdomain.h |   13 ++-
 7 files changed, 146 insertions(+), 118 deletions(-)

