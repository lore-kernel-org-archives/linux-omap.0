From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 0/6] OMAP GPIO updates for 2.6.35
Date: Mon,  3 May 2010 16:26:11 -0700
Message-ID: <1272929177-22685-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f203.google.com ([209.85.223.203]:41729 "EHLO
	mail-iw0-f203.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752979Ab0ECXeE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 19:34:04 -0400
Received: by iwn41 with SMTP id 41so3866735iwn.20
        for <linux-omap@vger.kernel.org>; Mon, 03 May 2010 16:34:03 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

A series of OMAP GPIO updates for 2.6.35 from the OMAP PM branch.

Series based on v2.6.34-rc5.

Kevin

Chunqiu Wang (1):
  OMAP3: GPIO: Only enable WAKEUPEN for edge detection GPIOs

Kevin Hilman (3):
  OMAP2/3: GPIO: generalize prepare for idle
  OMAP3: GPIO: disable GPIO debounce clocks on idle
  OMAP: GPIO: remove duplicate debugfs interface

Tero Kristo (2):
  OMAP3: GPIO fixes for off-mode
  OMAP3: GPIO: Removed a couple of unneeded registers from context
    save/restore

 arch/arm/mach-omap2/pm24xx.c           |    4 +-
 arch/arm/mach-omap2/pm34xx.c           |    4 +-
 arch/arm/plat-omap/gpio.c              |  177 +++++++++-----------------------
 arch/arm/plat-omap/include/plat/gpio.h |    4 +-
 4 files changed, 53 insertions(+), 136 deletions(-)

