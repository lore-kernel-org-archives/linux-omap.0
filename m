From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Fixes for multi-omap configurion
Date: Thu, 21 Aug 2008 11:20:08 +0300
Message-ID: <1219306810-12232-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:28923 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256AbYHUIUp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Aug 2008 04:20:45 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7L8KX2g031779
	for <linux-omap@vger.kernel.org>; Thu, 21 Aug 2008 11:20:42 +0300
Received: from localhost.localdomain (esdhcp04165.research.nokia.com [172.21.41.65])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m7L8KE1S003782
	for <linux-omap@vger.kernel.org>; Thu, 21 Aug 2008 11:20:15 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi

There are at least three drivers crashing if running N800 defconfig +
CONFIG_ARCH_OMAP2430=y on N810. Here are fixes for omap2_mcspi and
omap_wdt but the musb I'll let to Felibe et al. :-)

<1>Unable to handle kernel NULL pointer dereference at virtual address
00000000
<1>pgd = c0004000
<1>[00000000] *pgd=00000000
Internal error: Oops: 5 [#1]
Modules linked in:
CPU: 0    Not tainted  (2.6.27-rc3-omap1 #170)
PC is at musb_platform_init+0x24/0xc0
LR is at 0x0
...


-- 
Jarkko
