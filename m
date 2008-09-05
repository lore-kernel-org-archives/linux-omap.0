From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH] Implement powerdomain off on state counters
Date: Fri,  5 Sep 2008 16:21:22 +0300
Message-ID: <1220620885-6096-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:47098 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683AbYIENVm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 09:21:42 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m85DLQpM010645
	for <linux-omap@vger.kernel.org>; Fri, 5 Sep 2008 16:21:39 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patchset implement counters to count the number of off to on state 
transitions in a powerdomain. These counters will be made available to
drivers in a later patchset to allow them to make a better informed
decision wether to restore the hardware registers or not.

Peter 'p2' De Schrijver (3):
  Powerdomain debugging
  Powerdomain off mode counters
  PM and clock domain hooks for off mode counters

 arch/arm/mach-omap2/Makefile                  |    2 +-
 arch/arm/mach-omap2/clockdomain.c             |   10 +++++
 arch/arm/mach-omap2/pm34xx.c                  |    9 +++-
 arch/arm/mach-omap2/powerdomain-debug.c       |   50 +++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomain.c             |   48 +++++++++++++++++++++++-
 arch/arm/plat-omap/include/mach/powerdomain.h |    9 ++++-
 6 files changed, 122 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/mach-omap2/powerdomain-debug.c

