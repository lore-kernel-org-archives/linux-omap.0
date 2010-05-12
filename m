From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 0/3] omap4 i2c board support
Date: Wed, 12 May 2010 13:57:28 +0530
Message-ID: <1273652851-14147-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45932 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754164Ab0ELI1h (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 May 2010 04:27:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Tony,

This series contains remaining patches from ealier series and
is is rebased against the current omap "for-next" branch

Balaji T K (2):
  omap4: add i2c1 peripherals data
  omap4: Enable RTC and regulator support

Santosh Shilimkar (1):
  omap4: Add i2c board support on omap4430 sdp platform

 arch/arm/configs/omap_4430sdp_defconfig |  376 ++++++++++++++++++++++++++++---
 arch/arm/mach-omap2/board-4430sdp.c     |  187 +++++++++++++++
 arch/arm/plat-omap/i2c.c                |   21 ++-
 3 files changed, 553 insertions(+), 31 deletions(-)

