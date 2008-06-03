From: Tero Kristo <tero.kristo@nokia.com>
Subject: Second part for the UART hack (dependency)
Date: Tue,  3 Jun 2008 13:50:41 +0300
Message-ID: <1212490242-5888-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:36651 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbYFCI5Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jun 2008 04:57:16 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m538v3BV026967
	for <linux-omap@vger.kernel.org>; Tue, 3 Jun 2008 03:57:14 -0500
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m538ul2F027396
	for <linux-omap@vger.kernel.org>; Tue, 3 Jun 2008 11:56:47 +0300
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch depends on the PM patch set sent by Jouni Hogander. Basically just a cosmetic modification to make fclk mask look more nice inside pm34xx.c.


