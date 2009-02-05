From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH PM 0/1] OMAP3: PM: Fix to prcm save/restore
Date: Thu,  5 Feb 2009 13:34:00 +0200
Message-ID: <1233833641-5329-1-git-send-email-jouni.hogander@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:17670 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbZBELct (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Feb 2009 06:32:49 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n15BWWSw025171
	for <linux-omap@vger.kernel.org>; Thu, 5 Feb 2009 13:32:46 +0200
Received: from localhost.localdomain (trdhcp147193.ntc.nokia.com [172.22.147.193])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n15BVnvG013689
	for <linux-omap@vger.kernel.org>; Thu, 5 Feb 2009 13:31:49 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch should fix the problem in locking DPLL2 after wake-up from OFF mode:

clock: dpll2_ck failed transition to 'locked'
clock: dpll2_ck failed transition to 'locked'
clock: dpll2_ck failed transition to 'locked'
clock: dpll2_ck failed transition to 'locked'

prcm.c |    6 +++++-
1 file changed, 5 insertions(+), 1 deletion(-)

