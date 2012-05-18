From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/3] ARM: OMAP3+: VP: collate fixes
Date: Fri, 18 May 2012 14:33:18 -0500
Message-ID: <1337369601-14915-1-git-send-email-nm@ti.com>
References: <[PATCH] ARM: OMAP3+: PM: VP: ensure VP is idle before disable>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:57628 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933155Ab2ERTda (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 May 2012 15:33:30 -0400
Received: by obceq6 with SMTP id eq6so4727541obc.9
        for <linux-omap@vger.kernel.org>; Fri, 18 May 2012 12:33:28 -0700 (PDT)
In-Reply-To: <[PATCH] ARM: OMAP3+: PM: VP: ensure VP is idle before disable>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Reviewing the android code base brought out a few fixes that upstream
does not have, so collating them and posting them out in this chain.

Nishanth Menon (2):
  ARM: OMAP3+: PM: VP: check to ensure VP is idle before forceupdate
  ARM: OMAP3+: PM: VP: check only the VPINIDLE status bit

Wenbiao Wang (1):
  ARM: OMAP3+: PM: VP: ensure VP is idle before disable

 arch/arm/mach-omap2/vp.c          |   34 ++++++++++++++++++++++++++++++----
 arch/arm/mach-omap2/vp.h          |    3 ++-
 arch/arm/mach-omap2/vp3xxx_data.c |    1 +
 arch/arm/mach-omap2/vp44xx_data.c |    1 +
 4 files changed, 34 insertions(+), 5 deletions(-)

Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Regards,
Nishanth Menon
-- 
1.7.9.5

