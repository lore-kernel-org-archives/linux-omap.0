From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 0/2] ARM: OMAP4: Audio regression fix for 3.8 kernel
Date: Fri, 4 Jan 2013 11:09:21 +0100
Message-ID: <1357294163-4317-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57264 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752346Ab3ADKJ2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Jan 2013 05:09:28 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, Jon Hunter <jon-hunter@ti.com>

Hello,

Changes since v1:
- Update the comment in cclock44xx_data.c as suggested by Jon Hunter

I have noticed that in 3.8-rc2 kernel OMAP4 audio is not working correctly. The
audio playback is in 'slow motion' mode.
The following two patch fixes this regression.

We need to lock the ABE DPLL for all OMAP4 revisions not only for 446x and McPDM
need to be configured to no IDLE mode during activity.

Regards,
Peter
---
Peter Ujfalusi (2):
  ARM: OMAP4: clock data: Lock ABE DPLL on all revisions
  ARM: OMAP4: hwmod_data: Correct IDLEMODE for McPDM

 arch/arm/mach-omap2/cclock44xx_data.c      | 13 ++++++-------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  2 +-
 2 files changed, 7 insertions(+), 8 deletions(-)

-- 
1.8.0.2

