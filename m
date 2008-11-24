From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 0/1] Fix control debobs macro
Date: Mon, 24 Nov 2008 16:34:34 +0200
Message-ID: <1227537275-7161-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:56121 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724AbYKXOek (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Nov 2008 09:34:40 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAOEYES7022833
	for <linux-omap@vger.kernel.org>; Mon, 24 Nov 2008 08:34:39 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patch fixes a silly bug which causes core observability to be configured wrongly for half of the pads.

Peter 'p2' De Schrijver (1):
  Debobs control macro fix

 arch/arm/plat-omap/include/mach/control.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

