From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 0/2] ARM: OMAP4 SDP/PandaBoard: Fix sys_nirq2 mux configuration
Date: Fri,  6 Jul 2012 15:19:10 +0200
Message-ID: <1341580752-5501-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:37923 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753173Ab2GFNTI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jul 2012 09:19:08 -0400
Received: by obfk16 with SMTP id k16so34312785obf.1
        for <linux-omap@vger.kernel.org>; Fri, 06 Jul 2012 06:19:06 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Hello,

sys_nirq2 pin needs to be set to mode0 (instead of mode1 done in v1 patches).
To my surprise mode1 also worked, but it was not the correct mode.

I have kept the acks from Santosh since the idea behind of the patches are the
same, but now the mux mode is the correct one.

Regards,
Peter

---
Peter Ujfalusi (2):
  ARM: OMAP: board-4430sdp: MUX configuration for sys_nirq2
  ARM: OMAP: board-omap4panda: MUX configuration for sys_nirq2

 arch/arm/mach-omap2/board-4430sdp.c    |    3 +++
 arch/arm/mach-omap2/board-omap4panda.c |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

-- 
1.7.8.6

