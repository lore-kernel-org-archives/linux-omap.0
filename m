From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 0/2] Add PM early init
Date: Thu, 31 Jul 2008 16:37:36 +0300
Message-ID: <1217511458-9950-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:21491 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbYGaNi2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Jul 2008 09:38:28 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m6VDcEiD006239
	for <linux-omap@vger.kernel.org>; Thu, 31 Jul 2008 16:38:26 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patchset add an early init function to initialize the voltage controller
and the off mode polarity before the drivers depending on these features are 
enabled.

Peter 'p2' De Schrijver (2):
  Move voltage controller configuration to pm34xx.c
  Add early init for voltage controller configuration and off mode
    polarity.

 arch/arm/mach-omap2/pm34xx.c      |   71 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/smartreflex.c |   60 -------------------------------
 2 files changed, 71 insertions(+), 60 deletions(-)

