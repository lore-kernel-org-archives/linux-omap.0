From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] ARM: OMAP4: Audio regression fix for 3.8 kernel
Date: Thu, 3 Jan 2013 14:46:49 +0100
Message-ID: <1357220811-29904-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58435 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753271Ab3ACNq6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jan 2013 08:46:58 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, Jon Hunter <jon-hunter@ti.com>

Hello,

I have noticed that in 3.8-rc2 kernel OMAP4 audio is not working correctly. The
audio playback is in 'slow motion' mode.
The following two patch fixes this regression.

We need to lock the ABE DPLL for all OMAP4 revisions not only for 446x and McPDM
need to be configured to no IDLE mode during activity.

Regards,
Peter
---
Peter Ujfalusi (2):
  ARM: OMAP4: clock data: ABE DPLL need to be locked on all revisions
  ARM: OMAP4: hwmod_data: Correct IDLEMODE for McPDM

 arch/arm/mach-omap2/cclock44xx_data.c      | 14 ++++++--------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  2 +-
 2 files changed, 7 insertions(+), 9 deletions(-)

-- 
1.8.0.2

