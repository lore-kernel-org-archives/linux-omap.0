From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/3] ARM: OMAP4: register V1V8, V2V1 regulators
Date: Wed,  2 May 2012 16:44:33 +0300
Message-ID: <1335966276-19775-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:46513 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754277Ab2EBNoz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 May 2012 09:44:55 -0400
Received: by lbom4 with SMTP id m4so903956lbo.16
        for <linux-omap@vger.kernel.org>; Wed, 02 May 2012 06:44:52 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

This series adds common configuration for the V1V8, V2V1 regulators from
twl6030. These regulators are commonly used to feed the twl6040 audio IC on
OMAP4 based boards (SDP4430, PandaBoards).

The regulator support for the twl6040 MFD driver will be going via MFD tree to
avoid cross tree issues.

Regards,
Peter
---
Peter Ujfalusi (3):
  OMAP4: twl-common: Add twl6030 V1V8, V2V1 SMPS common configuration
  OMAP: 4430SDP: Use common configuration for V1V8, V2V1 supplies
  OMAP: omap4panda: Use common configuration for V1V8, V2V1 supplies

 arch/arm/mach-omap2/board-4430sdp.c    |    4 ++-
 arch/arm/mach-omap2/board-omap4panda.c |    4 ++-
 arch/arm/mach-omap2/twl-common.c       |   42 ++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/twl-common.h       |    2 +
 4 files changed, 50 insertions(+), 2 deletions(-)

-- 
1.7.8.6

