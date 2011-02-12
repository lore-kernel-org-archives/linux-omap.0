From: Daniel Morsing <daniel.morsing@gmail.com>
Subject: [PATCH 0/2] Add recommended bpp for omap dss2 generic dpi panels
Date: Sat, 12 Feb 2011 18:02:08 +0100
Message-ID: <1297530130-10355-1-git-send-email-daniel.morsing@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54555 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948Ab1BLRCE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Feb 2011 12:02:04 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomba@iki.fi>
Cc: Bryan Wu <bryan.wu@canonical.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Daniel Morsing <daniel.morsing@gmail.com>

This series adds a mechanism for specifying a recommended bpp for
generic dss2 dpi panels and adds a panel that uses this feature.

The panel added is the 4.3 inch display that is sold with the
Devkit8000.

Daniel Morsing (2):
  omap: dss2: Add recommended bpp option for generic dpi panels
  omap3: devkit8000: Add and use 4.3 inch display

 arch/arm/mach-omap2/board-devkit8000.c           |    2 +-
 drivers/video/omap2/displays/panel-generic-dpi.c |   41 ++++++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletions(-)

-- 
1.7.4

