From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 0/3] ARM: OMAP2+: hwmod: RTC: Add lock and unlock hooks
Date: Wed, 10 Jun 2015 14:56:23 +0530
Message-ID: <1433928386-24891-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37962 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754125AbbFJJ3Z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Jun 2015 05:29:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, t-kristo@ti.com, lokeshvutla@ti.com

Some IP blocks like RTC, needs an additional unlocking mechanism for
writing to its registers. This patch adds optional lock and unlock
function pointers to the IP block's hwmod data which gets executed
before and after writing into IP sysconfig register.
And also hook lock and unlock functions to AMx3xx, DRA7 RTC hwmod data,
so that sysconfig registers are updated properly.

Tested on:
DRA7-evm: http://pastebin.ubuntu.com/11688889/
DRA72-evm: http://pastebin.ubuntu.com/11688901/
BeagleBoard-x15: http://pastebin.ubuntu.com/11688907/
BeagleBoneBlack: http://pastebin.ubuntu.com/11688923/ 
AM437x-gp-evm: http://pastebin.ubuntu.com/11689157/ (Used an out of tree patch to enable RTC)

Lokesh Vutla (3):
  ARM: OMAP2+: hwmod: add support for lock and unlock hooks
  ARM: DRA: hwmod: RTC: Add lock and unlock functions
  ARM: AMx3xx: RTC: Add lock and unlock functions

 arch/arm/mach-omap2/omap_hwmod.c                   | 13 ++++++
 arch/arm/mach-omap2/omap_hwmod.h                   |  6 +++
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |  2 +
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |  2 +
 arch/arm/mach-omap2/omap_hwmod_reset.c             | 47 ++++++++++++++++++++++
 5 files changed, 70 insertions(+)

-- 
1.9.1

