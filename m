From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 0/2] hwspinlock/omap - new SoC support
Date: Wed, 2 Jul 2014 18:00:58 -0500
Message-ID: <1404342060-2919-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47669 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150AbaGBXBZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Jul 2014 19:01:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

Hi Ohad,

The following two patches allow the OMAP hwspinlock driver
to be enabled for AM33xx, AM437x and DRA7xx SoCs.

The patches are rebased onto 3.16-rc3 and are identical to those
posted in the OMAP hwspinlock DT support v5 series [1][2]. Posting
these separately to decouple from the DT series, as per the discussion
on the lists.

regards
Suman

[1] https://patchwork.kernel.org/patch/4096831/
[2] https://patchwork.kernel.org/patch/4096761/

Suman Anna (2):
  hwspinlock/omap: enable module before reading SYSSTATUS register
  hwspinlock/omap: enable build for AM33xx, AM43xx & DRA7xx

 drivers/hwspinlock/Kconfig           |  2 +-
 drivers/hwspinlock/omap_hwspinlock.c | 27 ++++++++++++++++++++-------
 2 files changed, 21 insertions(+), 8 deletions(-)

-- 
2.0.0

