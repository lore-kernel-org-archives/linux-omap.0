From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH 0/3] ARM: OMAP1/2+: 32k-timer: Add hwmod lookup for 32k-timer
Date: Thu, 19 Jan 2012 19:58:21 +0530
Message-ID: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57554 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290Ab2ASOeF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Jan 2012 09:34:05 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com, johnstul@us.ibm.com, Vaibhav Hiremath <hvaibhav@ti.com>

This patch series cleans up the existing 32k-sync timer implementation
without any major code change and adds hwmod lookup for omap2+ devices,
if lookup fails then fall back to gp-timer.

With this, we should be able to support multi-omap boot
including devices with/without 32k-sync timer.
For example, AM33xx device doesn't have 32k-sync timer available,
which breaks multi-omap boot.

This patch-series has been boot tested on AM37xEVM platform, it
would be helpful if somebody help me to validate it on OMAP2
platform.

Background:
==========
In 2010 timeframe 'Fillipe Balbi' had submitted first version
of 32k-sync timer cleanup patches, but it did not made its way
to the mainline.

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg37403.html

Yesterday I had submitted the RFC version patch-series, which was
built on top of earlier cleanup patches from 'Fillipe Balbi'.

http://www.spinics.net/lists/linux-omap/msg63004.html

Based on comments (Thanks to Russell, Marc and Tony) from community
it was clear that, arch_init is not the correct way here.


Vaibhav Hiremath (3):
  ARM: OMAP2+: 32k-counter: Use hwmod lookup to check presence of 32k
    timer
  ARM: OMAP2/3: Add idle_st bits for ST_32KSYNC timer to prcm-common
    header
  ARM: OMAP2+: hwmod data: Add 32k-sync timer data to hwmod database

 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   53 ++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   52 +++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   51 +++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
 arch/arm/mach-omap2/prcm-common.h          |    4 +
 arch/arm/mach-omap2/timer.c                |   27 ++++-----
 arch/arm/plat-omap/counter_32k.c           |   83 ++++++++++++++-------------
 7 files changed, 215 insertions(+), 57 deletions(-)

