From: Tero Kristo <tero.kristo@nokia.com>
Subject: Bug fix: reschedule check for omap3 PM
Date: Fri, 20 Mar 2009 15:21:01 +0200
Message-ID: <1237555262-13678-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:17334 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715AbZCTNlU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2009 09:41:20 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n2KDf9ZD018506
	for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 15:41:15 +0200
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n2KDe9RT020548
	for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 15:40:09 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

Hi,

This patch fixes a problem where an interrupt may cause scheduling inside
idle loop, but which does not get served due to the decision that has already
been done for the system to enter idle. This can cause nasty latencies in
some cases.

This would not need to be done if interrupts would be disabled inside the
idle loop (arch/arm/kernel/process.c @ cpu_idle), but currently this is not
the case in ARM kernel.

-Tero


