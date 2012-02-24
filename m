From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 0/4] mmc: omap: add autocmd12, DDR support and runtime fixes
Date: Fri, 24 Feb 2012 21:14:30 +0530
Message-ID: <1330098274-12048-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48961 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757454Ab2BXPnk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Feb 2012 10:43:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>

	add Autocmd12 for multiblock read/write
	add DDR support
	minor pm runtime fixes

Balaji T K (4):
  mmc: omap: Enable Auto CMD12
  mmc: omap: add DDR support to omap_hsmmc
  mmc: omap: use runtime put sync in probe error patch
  mmc: omap: context save after enabling runtime pm

 drivers/mmc/host/omap_hsmmc.c |   29 ++++++++++++++++++++++-------
 1 files changed, 22 insertions(+), 7 deletions(-)

