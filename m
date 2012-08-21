From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/2] OMAPDSS: fixes for -rc
Date: Tue, 21 Aug 2012 09:09:46 +0300
Message-ID: <1345529388-3509-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:35090 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752663Ab2HUGKe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 02:10:34 -0400
Received: by lbbgp3 with SMTP id gp3so3832795lbb.29
        for <linux-omap@vger.kernel.org>; Mon, 20 Aug 2012 23:10:31 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi Florian,

Here are two small fixes for omapfb and omapdss. The first one fixes an old bug
that causes colors to be wrong on fb console. The other fixes SDI output that
got broken in the previous merge window.

 Tomi

Grazvydas Ignotas (1):
  OMAPFB: fix framebuffer console colors

Tomi Valkeinen (1):
  OMAPDSS: Fix SDI PLL locking

 drivers/video/omap2/dss/sdi.c            |   14 ++++++++++++++
 drivers/video/omap2/omapfb/omapfb-main.c |    2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

-- 
1.7.9.5

