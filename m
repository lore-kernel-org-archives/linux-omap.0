From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 0/2] OMAP2+: misc. defconfig cleanups for 2.6.37
Date: Tue, 28 Sep 2010 12:07:27 -0700
Message-ID: <1285700849-10000-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:59387 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754776Ab0I1THn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Sep 2010 15:07:43 -0400
Received: by pxi10 with SMTP id 10so1789948pxi.19
        for <linux-omap@vger.kernel.org>; Tue, 28 Sep 2010 12:07:43 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

A couple of small defconfig changes for 2.6.37 with the goal of working
towards a smaller default kernel image.

Kevin Hilman (2):
  OMAP2+: defconfig: disable CPUfreq
  OMAP2+: defconfig: modularize bluetooth, audio and WLAN

 arch/arm/configs/omap2plus_defconfig |   34 +++++++++++++++-------------------
 1 files changed, 15 insertions(+), 19 deletions(-)

-- 
1.7.2.1

