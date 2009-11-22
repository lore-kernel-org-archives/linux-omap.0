From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH 0/3] Add USB mux support for omap7xx and config for HTC
 Herald
Date: Sun, 22 Nov 2009 13:25:08 -0800
Message-ID: <1258925108.11242.1.camel@runt>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:61687 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755649AbZKVVZF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Nov 2009 16:25:05 -0500
Received: by pwi3 with SMTP id 3so3057527pwi.21
        for <linux-omap@vger.kernel.org>; Sun, 22 Nov 2009 13:25:10 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch set updates the mux configuration and omap USB driver for
omap7xx devices, and adds USB initialization code to the HTC Herald board.

These patches have been created against the latest for-next branch of
linux-omap.

Cory Maccarrone (3):
  [OMAP1] MUX: Add omap7xx-specific USB mux pins
  [OMAP] USB: Add omap7xx-specific pin muxing
  [OMAP] HTCHERALD: Add USB configuration to HTC Herald

 arch/arm/mach-omap1/board-htcherald.c |   70 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap1/mux.c             |    4 +-
 arch/arm/plat-omap/include/plat/mux.h |    2 +
 arch/arm/plat-omap/usb.c              |    8 +++-
 4 files changed, 82 insertions(+), 2 deletions(-)


