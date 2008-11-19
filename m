From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 0/1] Save sram context after changing MPU, DSP or core clocks
Date: Wed, 19 Nov 2008 13:45:26 +0200
Message-ID: <1227095127-7158-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:26559 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929AbYKSLph (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Nov 2008 06:45:37 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAJBjYL1003755
	for <linux-omap@vger.kernel.org>; Wed, 19 Nov 2008 05:45:35 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patch saves the sram context again after a MPU,DSP or core clock
frequency change. This is necessary so the rom code can restore the correct
DPLL settings when resuming from off mode. Thanks to Rajendra Nayak for
suggesting the problem and coming up with the same fix at about the same time.

Peter 'p2' De Schrijver (1):
  Save sram context after changing MPU, DSP or core clocks

 arch/arm/mach-omap2/clock34xx.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

