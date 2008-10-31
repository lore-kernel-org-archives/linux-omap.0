From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [OMAP and mainline][RFC 2.6.28-rc2-omap 0/3] legacy gpio phaseout (III) ...
Date: Fri, 31 Oct 2008 14:17:24 +0200
Message-ID: <1225455447-12179-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:62329 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbYJaMSH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Oct 2008 08:18:07 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9VCHqIi000601
	for <linux-omap@vger.kernel.org>; Fri, 31 Oct 2008 14:18:04 +0200
Received: from localhost.localdomain (esdhcp041151.research.nokia.com [172.21.41.151])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m9VCHsFE030488
	for <linux-omap@vger.kernel.org>; Fri, 31 Oct 2008 14:17:54 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This is from the "Continue phasing out legacy GPIO calls" set I sent earlier
but includes only files which are in mainline.

This is generated on top of David's recent 4+5 "legacy gpio phaseout.." patches in linux-omap tree.

Note that this still includes arch/arm/mach-omap1/leds.c (should vanish
soon/now) and arch/arm/plat-omap/debug-devices.c untouched.


-- 
Jarkko
