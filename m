From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH 0/1] ARM: OMAP: Enable TSC2301 drivers in N800 defconfig
Date: Mon, 28 Apr 2008 11:08:33 +0300
Message-ID: <1209370114-17007-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:30767 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765632AbYD1IIG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2008 04:08:06 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3S89RB9028586
	for <linux-omap@vger.kernel.org>; Mon, 28 Apr 2008 03:10:39 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Patch because N800 didn't work anymore with n800_defconfig...

Note that camera driver doesn't compile at the moment so please disable
CONFIG_VIDEO_OMAP2 manually before trying.

Felipe, can you test does this config still work on N810?

-- 
Jarkko
