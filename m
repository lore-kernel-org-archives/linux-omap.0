From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] ASoC: omap-mcpdm updates for 3.7
Date: Thu,  4 Oct 2012 11:15:07 +0300
Message-ID: <1349338509-3440-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:51313 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755330Ab2JDIOD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 04:14:03 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so188282obb.19
        for <linux-omap@vger.kernel.org>; Thu, 04 Oct 2012 01:14:00 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

Hello Mark, Tony,

The mcpdm driver no longer needs to include any plat/*.h file, clearing the way
for the single kernel image.

Regards,
Peter
---
Peter Ujfalusi (1):
  ASoC: omap-mcpdm: Remove OMAP revision check

Tony Lindgren (1):
  ASoC: Fix wrong include for McPDM

 sound/soc/omap/omap-mcpdm.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

-- 
1.7.12

