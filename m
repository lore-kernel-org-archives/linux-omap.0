From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH 0/2 RFC]OMAP3430: hwmod FW for GPIO
Date: Fri, 12 Feb 2010 19:09:26 +0530
Message-ID: <1265981968-14696-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46485 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943Ab0BLNjw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Feb 2010 08:39:52 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o1CDdnNO022583
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 12 Feb 2010 07:39:51 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Charulatha V <charu@ti.com>

From: Charulatha V <charu@ti.com>

This patch series makes the OMAP3430 GPIO module
use hwmod framework.

This patch series applies on top of pm branch
and it requires my previous patch set which converts
GPIO into an early init device. 

They are boot tested on SDP 3430 and compile tested
for OMAP 2420 and 2430.

Charulatha V (2):
  OMAP3: hwmod: add GPIO hwmods for OMAP3430
  OMAP3: hwmod: Adapt HWMOD FW for GPIO OMAP3430

 arch/arm/mach-omap2/gpio.c             |  901 ++++----------------------------
 arch/arm/mach-omap2/omap_hwmod_34xx.h  |  410 +++++++++++++++
 arch/arm/plat-omap/include/plat/gpio.h |   25 +-
 3 files changed, 533 insertions(+), 803 deletions(-)

