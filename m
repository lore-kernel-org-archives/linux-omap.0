From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCHv3 0/1] Add initial support for OMAP3 IGEP module
Date: Sun,  3 Oct 2010 00:06:14 +0200
Message-ID: <1286057175-22916-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41604 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202Ab0JBWGY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 2 Oct 2010 18:06:24 -0400
Received: by wwj40 with SMTP id 40so2721047wwj.1
        for <linux-omap@vger.kernel.org>; Sat, 02 Oct 2010 15:06:22 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org


Hello,

This is the version 3 of patch series to introduce the OMAP3
IGEP module support.

Changes since v2 (thanks Laurent):
- Set onenand_setup to NULL instead of adding a no-op function.
  - On igep3_flash_init() function:
    - Use 'for' loop instead 'while' loop.
    - No need to initialize ret to 0, we're assigning it right after.
    - No need to check for onenandcs < GPMC_CS_NUM, it will always be true.
  - omap_board_config_size is implicitly initialized to 0 in
    plat-omap/common.c, get_config() won't dereference omap_board_config,
    so we can remove the empty igep2_config array.
 
Changes since v1:
 - add DEBUG_LL/EARLY_PRINTK entry

 arch/arm/mach-omap2/Kconfig                  |    5 +
 arch/arm/mach-omap2/Makefile                 |    2 +
 arch/arm/mach-omap2/board-igep0030.c         |  401 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/uncompress.h |    1 +
 4 files changed, 409 insertions(+), 0 deletions(-)
