From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/2] omap-keypad fixes for OMAP2
Date: Thu,  2 Oct 2008 08:28:47 +0300
Message-ID: <1222925329-28117-1-git-send-email-peter.ujfalusi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:25103 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143AbYJBF3Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Oct 2008 01:29:25 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m925TLiR015087
	for <linux-omap@vger.kernel.org>; Thu, 2 Oct 2008 08:29:22 +0300
Received: from localhost.localdomain (cseresznye.ntc.nokia.com [172.22.144.108])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m925Sojf030098
	for <linux-omap@vger.kernel.org>; Thu, 2 Oct 2008 08:28:50 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Fixes for the omap-keypad driver on OMAP2

Peter Ujfalusi (2)
  OMAP2: omap-keypad: interrupt disable fix
  OMAP2: omap-keypad: Enable more than 6 rows

 drivers/input/keyboard/omap-keypad.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)



