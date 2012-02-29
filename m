From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/2] OMAPDSS: small fixes for 3.3 rc
Date: Wed, 29 Feb 2012 10:48:20 +0200
Message-ID: <1330505302-8258-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:44490 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932161Ab2B2Isj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Feb 2012 03:48:39 -0500
Received: by mail-lpp01m010-f44.google.com with SMTP id j5so4184165lag.3
        for <linux-omap@vger.kernel.org>; Wed, 29 Feb 2012 00:48:38 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: FlorianSchandinat@gmx.de, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

Two small fixes for omapdss.

Florian, if the patches are ok, I guess it's easier if you just apply these
patches from email, instead of me sending a pull request?

 Tomi

Tomi Valkeinen (2):
  OMAPDSS: panel-dvi: Add Kconfig dependency on I2C
  OMAPDSS: APPLY: make ovl_enable/disable synchronous

 drivers/video/omap2/displays/Kconfig |    2 +-
 drivers/video/omap2/dss/apply.c      |    6 ++++++
 2 files changed, 7 insertions(+), 1 deletions(-)

-- 
1.7.4.1

