From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/3] ARM: OMAP2/3: Move McBSP fck alias to hwmod data
Date: Thu, 14 Jun 2012 15:27:23 +0300
Message-ID: <1339676846-12791-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:44306 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753396Ab2FNM1U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 08:27:20 -0400
Received: by lahi5 with SMTP id i5so1434617lah.0
        for <linux-omap@vger.kernel.org>; Thu, 14 Jun 2012 05:27:18 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

To keep the McBSP fck alias handling in sync among OMAP versions.
Change the legacy implementation for OMAP2/3 regarding to McBSP fck alias.
OMAP4 (and OMAP5) uses the hwmod data to specify the aliases for the fcks and
it is also needed for the coming McBSP DT support.

Tested on OMAP3 BeagleBoard, compile tested it for OMAP2.

Regards,
Peter

---
Peter Ujfalusi (3):
  ARM: OMAP2: Move McBSP fck clock alias to hwmod data for OMAP2420
  ARM: OMAP2: Move McBSP fck clock alias to hwmod data for OMAP2430
  ARM: OMAP3: Move McBSP fck clock alias to hwmod data

 arch/arm/mach-omap2/clock2420_data.c       |    4 ----
 arch/arm/mach-omap2/clock2430_data.c       |   10 ----------
 arch/arm/mach-omap2/clock3xxx_data.c       |   10 ----------
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    9 +++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   15 +++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   21 +++++++++++++++++++++
 6 files changed, 45 insertions(+), 24 deletions(-)

-- 
1.7.8.6

