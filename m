From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] dspbridge: maemo lingering patches
Date: Sat, 23 Jan 2010 12:19:44 +0200
Message-ID: <1264241986-29071-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:64164 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab0AWKT7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 Jan 2010 05:19:59 -0500
Received: by bwz27 with SMTP id 27so1661440bwz.21
        for <linux-omap@vger.kernel.org>; Sat, 23 Jan 2010 02:19:57 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Hi,

These are some patches that were lingering in the maemo branch since a long
time ago.

Jouni Hogander (1):
  DSPBRIDGE: Use enable_off_mode variable instead of
    dsp_test_sleepstate

Mika Kukkonen (1):
  DSPBRIDGE: Various compile warning fixes

 arch/arm/plat-omap/include/dspbridge/dbc.h |    6 +++---
 arch/arm/plat-omap/include/dspbridge/dbg.h |    4 ++--
 arch/arm/plat-omap/include/dspbridge/gt.h  |   16 +++++++++-------
 arch/arm/plat-omap/include/dspbridge/mem.h |    2 +-
 drivers/dsp/bridge/rmgr/drv_interface.c    |    5 -----
 drivers/dsp/bridge/wmd/io_sm.c             |    5 ++---
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c    |    9 ++++-----
 drivers/dsp/bridge/wmd/ue_deh.c            |    2 +-
 8 files changed, 22 insertions(+), 27 deletions(-)

