From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 0/3] misc. omap_device/omap_hwmod updates
Date: Fri,  8 Jan 2010 15:26:50 -0800
Message-ID: <1262993213-19866-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:51668 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754278Ab0AHX04 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 18:26:56 -0500
Received: by pzk1 with SMTP id 1so4078226pzk.33
        for <linux-omap@vger.kernel.org>; Fri, 08 Jan 2010 15:26:55 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com

A small series of proposed updates for omap_device/omap_hwmod.

This series was tested on the current PM branch but also applies cleanly to current linux-omap master branch.  

It was tested along with previously posted changes to convert UARTs to
omap_device.  A new version of the UART omap_device conversion will be
arriving soon-ish.

Kevin

Kevin Hilman (3):
  OMAP: omap_device: optionally auto-adjust device activate/deactivate
    latencies
  OMAP: hwmod: add read/write API for SYSCONFIG
  OMAP: hwmod: allow idle after HWMOD_INIT_NO_IDLE

 arch/arm/mach-omap2/omap_hwmod.c              |   21 ++++++++++++-
 arch/arm/plat-omap/include/plat/omap_device.h |    4 ++
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    3 ++
 arch/arm/plat-omap/omap_device.c              |   41 ++++++++++++++++++++-----
 4 files changed, 60 insertions(+), 9 deletions(-)

