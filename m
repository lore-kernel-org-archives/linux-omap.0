From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 0/3] ARM: OMAP4: register V1V8, V2V1 regulators
Date: Wed,  9 May 2012 10:33:31 +0300
Message-ID: <1336548814-1005-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:43117 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753025Ab2EIHd2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 03:33:28 -0400
Received: by lbbgg6 with SMTP id gg6so5987305lbb.36
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 00:33:26 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

Changes since v1:
- rebased on 3.4-rc6

Original intro message:

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
 arch/arm/mach-omap2/twl-common.c       |   43 ++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/twl-common.h       |    2 +
 4 files changed, 51 insertions(+), 2 deletions(-)

-- 
1.7.8.6

