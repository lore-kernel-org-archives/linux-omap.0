From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 0/3] Implement powerdomain off on state counters
Date: Thu, 24 Jul 2008 16:00:31 +0300
Message-ID: <1216904434-7545-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:23988 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbYGXNAm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jul 2008 09:00:42 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m6OCxteW020079
	for <linux-omap@vger.kernel.org>; Thu, 24 Jul 2008 08:00:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patchset implement counters to count the number of off to on state transitions in a powerdomain. These counters will be made available to
drivers in a later patchset to allow them to make a better informed decision wether to restore the hardware registers or not.

Peter 'p2' De Schrijver (3):
  Power off on state counter debugging
  Power off on state counter infrastructure
  Add hooks for counting off on power transitions

 arch/arm/mach-omap2/Makefile                  |    2 +-
 arch/arm/mach-omap2/clockdomain.c             |   10 +++++
 arch/arm/mach-omap2/off-state-counter-debug.c |   50 +++++++++++++++++++++++++
 arch/arm/mach-omap2/pm34xx.c                  |    6 ++-
 arch/arm/mach-omap2/powerdomain.c             |   48 +++++++++++++++++++++++-
 include/asm-arm/arch-omap/powerdomain.h       |    9 ++++-
 6 files changed, 120 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/mach-omap2/off-state-counter-debug.c

