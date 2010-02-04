From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH/RFC 0/4] convert HS-MMC driver to hwmod + runtime PM
Date: Wed,  3 Feb 2010 16:51:24 -0800
Message-ID: <1265244688-4055-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f189.google.com ([209.85.211.189]:49225 "EHLO
	mail-yw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932716Ab0BDAvg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Feb 2010 19:51:36 -0500
Received: by ywh27 with SMTP id 27so1788686ywh.1
        for <linux-omap@vger.kernel.org>; Wed, 03 Feb 2010 16:51:35 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This series converts the OMAP HS-MMC driver to use omap_hwmod +
runtime PM API.

Depends on MMC hwmods available in 'pm-wip/hwmods' branch of
my git tree[1] as well as previously posted runtime PM series:

   [PATCH/RFC 0/2] initial runtime PM layer for OMAP

The easies way to experiment/test is to use my 'pm-wip/mmc' branch
which has all the dependencies, and is based on omap/for-next'.
It has been tested by merging with current PM branch.

[1] http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git

Kevin Hilman (3):
  MMC: OMAP HS-MMC: convert to dev_pm_ops
  OMAP3EVM: MMC: enable power-saving mode
  OMAP2/3 MMC: initial conversion to runtime PM

Paul Walmsley (1):
  OMAP: MMC (core): split device registration by OMAP

 arch/arm/mach-omap1/devices.c         |   45 ++++++-
 arch/arm/mach-omap2/board-omap3evm.c  |    1 +
 arch/arm/mach-omap2/devices.c         |  111 ++++++++-------
 arch/arm/mach-omap2/hsmmc.c           |   12 +-
 arch/arm/plat-omap/devices.c          |   50 -------
 arch/arm/plat-omap/include/plat/mmc.h |    5 +
 drivers/mmc/host/omap_hsmmc.c         |  241 ++++++++++++++++-----------------
 7 files changed, 233 insertions(+), 232 deletions(-)

