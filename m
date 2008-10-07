From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 0/3] Add PM debug counters on top of PM counters
Date: Tue,  7 Oct 2008 16:33:13 +0300
Message-ID: <1223386396-29560-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:61060 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537AbYJGNeZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 09:34:25 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m97DXxXk011322
	for <linux-omap@vger.kernel.org>; Tue, 7 Oct 2008 08:34:23 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patch provides the PM debug counters and time feature on top of the PM counters. Patch based on pm-1 branch + PM counters patch.

Peter 'p2' De Schrijver (3):
  Add closures to clkdm_for_each
  Add pm-debug counters
  Hook into powerdomain code

 arch/arm/mach-omap2/clockdomain.c             |   31 +-----
 arch/arm/mach-omap2/pm-debug.c                |  153 ++++++++++++-------------
 arch/arm/mach-omap2/pm.h                      |   19 +---
 arch/arm/mach-omap2/pm24xx.c                  |    2 +-
 arch/arm/mach-omap2/pm34xx.c                  |   13 +--
 arch/arm/mach-omap2/powerdomain.c             |   95 +++-------------
 arch/arm/plat-omap/include/mach/clockdomain.h |    3 +-
 arch/arm/plat-omap/include/mach/powerdomain.h |   14 ++-
 8 files changed, 114 insertions(+), 216 deletions(-)

