From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 0/1] Do a warm reboot instead of a cold reboot
Date: Mon,  2 Feb 2009 19:10:23 +0200
Message-ID: <1233594624-21615-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23984 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103AbZBBRKd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Feb 2009 12:10:33 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n12HAPUo025325
	for <linux-omap@vger.kernel.org>; Mon, 2 Feb 2009 19:10:29 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patch makes arch_reset do a warm reboot instead of a cold reboot. This
is necessary because otherwise the system does not reboot reliably when disabling
CLKEN in retention.

Note : Unfortuately this breaks retention :( IVA2, PER and CORE don't go to
       retention after reboot.

Peter 'p2' De Schrijver (1):
  Do a soft reboot instead of a cold boot

 arch/arm/mach-omap2/prcm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

