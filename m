From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH] OMAP: Beagle: fix DVI GPIO request
Date: Mon, 21 May 2012 12:41:16 +0300
Message-ID: <1337593277-13822-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:35550 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757420Ab2EUJla (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 May 2012 05:41:30 -0400
Received: by lbok6 with SMTP id k6so4226481lbo.32
        for <linux-omap@vger.kernel.org>; Mon, 21 May 2012 02:41:26 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Tony,

There is a bug in the for-l-o-3.5 branch I sent earlier, causing the DVI driver
to fail to request the power-down GPIO. This patch fixes it.

Tomi Valkeinen (1):
  OMAP: Beagle: fix DVI GPIO request

 arch/arm/mach-omap2/board-omap3beagle.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
1.7.9.5

