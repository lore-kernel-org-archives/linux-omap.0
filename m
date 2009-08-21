From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [DSPBRIGDE PATCH 0/6] trivial dsp patches
Date: Fri, 21 Aug 2009 13:23:33 +0300
Message-ID: <1250850219-25545-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:37390 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755262AbZHUKZx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Aug 2009 06:25:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Ameya Palande <ameya.palande@nokia.com>, x0095840@ti.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

just a few cleanups here and there.

Felipe Balbi (6):
  dsp: bridge: use ARRAY_SIZE
  dsp: bridge: wcd: else is unnecessary
  dsp: bridge: rename Kbuild to Makefile
  dsp: bridge: always use dynamic major/minor numbers
  dsp: brigde: remove unnecessary memset()
  dsp: bridge: beautify erro path

 drivers/dsp/bridge/{Kbuild => Makefile} |    0
 drivers/dsp/bridge/pmgr/wcd.c           |    8 +++---
 drivers/dsp/bridge/rmgr/drv_interface.c |   46 +++++++++++++-----------------
 3 files changed, 24 insertions(+), 30 deletions(-)
 rename drivers/dsp/bridge/{Kbuild => Makefile} (100%)

