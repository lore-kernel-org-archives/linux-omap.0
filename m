From: Ilya Yanok <yanok@emcraft.com>
Subject: [PATCH 0/2] Support for TeeJet Mt.Ventoux
Date: Tue, 27 Dec 2011 00:08:30 +0100
Message-ID: <1324940912-18164-1-git-send-email-yanok@emcraft.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:55906 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552Ab1LZXIm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Dec 2011 18:08:42 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: sasha_d@emcraft.com, Ilya Yanok <yanok@emcraft.com>

Split into two parts:
 1. Device tree only to be used with board-generic (only serial works)
 2. Full board support via custom machine file for board-testing

Ilya Yanok (2):
  mt_ventoux: very basic support for TeeJet Mt.Ventoux board
  mt_ventoux: support for TeeJet Mt.Ventoux board

 arch/arm/boot/dts/am3517_mt_ventoux.dts       |   27 +
 arch/arm/mach-omap2/Kconfig                   |    6 +
 arch/arm/mach-omap2/Makefile                  |    1 +
 arch/arm/mach-omap2/board-am3517_mt_ventoux.c |  708 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/uncompress.h  |    1 +
 5 files changed, 743 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/am3517_mt_ventoux.dts
 create mode 100644 arch/arm/mach-omap2/board-am3517_mt_ventoux.c

-- 
1.7.6.4

