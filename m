From: Tero Kristo <tero.kristo@nokia.com>
Subject: PM34xx: Sleep support patches
Date: Fri, 12 Sep 2008 14:38:12 +0300
Message-ID: <1221219494-12636-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:34459 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528AbYILJsg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2008 05:48:36 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8C9mAqY023360
	for <linux-omap@vger.kernel.org>; Fri, 12 Sep 2008 12:48:33 +0300
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m8C9mBHw027254
	for <linux-omap@vger.kernel.org>; Fri, 12 Sep 2008 12:48:12 +0300
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

These two patches are required for OMAP34xx to enter dynamic idle & suspend
modes successfully. These patches introduce two new sysfs files for dynamic
clock control: /sys/power/gpio_clocks_off_while_idle and
/sys/power/uart_clocks_off_while_idle. Both of these must be enabled for
dynamic idle / suspend to work.


