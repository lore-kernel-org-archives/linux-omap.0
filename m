From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH PM 0/1] OMAP3: MCSPI: Fix to spi save/restore
Date: Tue,  3 Feb 2009 15:35:20 +0200
Message-ID: <1233668121-32200-1-git-send-email-jouni.hogander@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:55392 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbZBCNhT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Feb 2009 08:37:19 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n13DbFAq020928
	for <linux-omap@vger.kernel.org>; Tue, 3 Feb 2009 15:37:16 +0200
Received: from localhost.localdomain (trdhcp147193.ntc.nokia.com [172.22.147.193])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n13DXEVD007687
	for <linux-omap@vger.kernel.org>; Tue, 3 Feb 2009 15:33:14 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

There is a bug in SPI save/restore. This patch is supposed to fix that.

omap2_mcspi.c |   15 +++++++--------
1 file changed, 7 insertions(+), 8 deletions(-)

