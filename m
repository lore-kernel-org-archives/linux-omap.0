From: Ilya Yanok <yanok@emcraft.com>
Subject: [PATCH V2 0/2] Support for HTKW mcx
Date: Thu, 15 Dec 2011 01:53:01 +0100
Message-ID: <1323910383-1184-1-git-send-email-yanok@emcraft.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:57660 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758380Ab1LOAxH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Dec 2011 19:53:07 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: yanok@emcraft.com, sasha_d@emcraft.com

Split into two parts:
 1. Device tree only to be used with board-generic (only serial works)
 2. Full board support via custom machine file for board-testing

Ilya Yanok (2):
  mcx: very basic support for HTKW mcx board
  mcx: support for HTKW mcx board

 arch/arm/boot/dts/mcx.dts                    |   27 ++
 arch/arm/mach-omap2/Kconfig                  |    6 +
 arch/arm/mach-omap2/Makefile                 |    1 +
 arch/arm/mach-omap2/board-mcx.c              |  495 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/uncompress.h |    1 +
 5 files changed, 530 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/mcx.dts
 create mode 100644 arch/arm/mach-omap2/board-mcx.c

-- 
1.7.6.4

