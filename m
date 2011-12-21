From: Ilya Yanok <yanok@emcraft.com>
Subject: [PATCH V3 0/2] Support for HTKW mcx
Date: Wed, 21 Dec 2011 16:53:40 +0100
Message-ID: <1324482822-24221-1-git-send-email-yanok@emcraft.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:58245 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251Ab1LUPxq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Dec 2011 10:53:46 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Ilya Yanok <yanok@emcraft.com>

Split into two parts:
 1. Device tree only to be used with board-generic (only serial works)
 2. Full board support via custom machine file for board-testing

Sorry for double-posting: I've put wrong linux-arm-kernel address in
the first post.

Ilya Yanok (2):
  mcx: very basic support for HTKW mcx board
  mcx: support for HTKW mcx board

 arch/arm/boot/dts/mcx.dts                    |   27 ++
 arch/arm/mach-omap2/Kconfig                  |    6 +
 arch/arm/mach-omap2/Makefile                 |    1 +
 arch/arm/mach-omap2/board-mcx.c              |  500 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/uncompress.h |    1 +
 5 files changed, 535 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/mcx.dts
 create mode 100644 arch/arm/mach-omap2/board-mcx.c

-- 
1.7.6.4

