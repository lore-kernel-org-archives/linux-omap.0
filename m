From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V4 0/4] ARM: OMAP3+: VP: collate fixes
Date: Thu, 31 May 2012 20:41:35 -0500
Message-ID: <1338514899-3560-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:41789 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752744Ab2FABls (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 May 2012 21:41:48 -0400
Received: by obqv19 with SMTP id v19so2530551obq.8
        for <linux-omap@vger.kernel.org>; Thu, 31 May 2012 18:41:47 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>

Reviewing the android code base brought out a few fixes that upstream
does not have, so collating them and posting them out in this chain.

Nishanth Menon (3):
  ARM: OMAP3+: PM: VP: check only the VPINIDLE status bit
  ARM: OMAP3+: PM: VP: move check of idle to separate function
  ARM: OMAP3+: PM: VP: check to ensure VP is idle before forceupdate

Wenbiao Wang (1):
  ARM: OMAP3+: PM: VP: ensure VP is idle before disable

 arch/arm/mach-omap2/vp.c          |   65 +++++++++++++++++++++++++++++++------
 arch/arm/mach-omap2/vp.h          |   10 ++++--
 arch/arm/mach-omap2/vp3xxx_data.c |    1 +
 arch/arm/mach-omap2/vp44xx_data.c |    1 +
 4 files changed, 65 insertions(+), 12 deletions(-)

Changes in v4:
	vp idle moved off to a seperate function
	reordered patches to reduce loc changes
	rate controlled warnings

Previous revs:
	V1: http://marc.info/?l=linux-omap&m=133736976423629&w=2

Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
--
Regards,
Nishanth Menon
-- 
1.7.9.5

