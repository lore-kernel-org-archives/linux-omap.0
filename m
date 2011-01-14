From: Daniel Morsing <daniel.morsing@gmail.com>
Subject: [PATCH 0/3] omap3: devkit8000: misc fixes
Date: Fri, 14 Jan 2011 01:03:26 +0100
Message-ID: <1294963409-29891-1-git-send-email-daniel.morsing@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56247 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757359Ab1ANADZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Jan 2011 19:03:25 -0500
Received: by eye27 with SMTP id 27so1191165eye.19
        for <linux-omap@vger.kernel.org>; Thu, 13 Jan 2011 16:03:23 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Thomas Weber <weber@corscience.de>, Daniel Morsing <daniel.morsing@gmail.com>

Here is a set of misc fixes for the devkit8000.

The only really notable one is the lcd enable gpio fix. It gets rid
of some nasty low level twl4030 calls and replaces them with generic gpio
calls. It also fixes a bug where the screen would not turn off when
blanking.

Daniel Morsing (3):
  omap3: devkit8000: Fix indentation issue
  omap3: devkit8000: fix tps65930 pullup/pulldown configuration
  omap3: devkit8000: Use generic gpio for second lcd enable

 arch/arm/mach-omap2/board-devkit8000.c |   26 ++++++++++++++++++++------
 1 files changed, 20 insertions(+), 6 deletions(-)

-- 
1.7.3.4

