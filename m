From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH 0/4] ARM: OMAP3: cm-t35/cm-t3730 fixes
Date: Wed, 19 Oct 2011 11:39:16 +0200
Message-ID: <1319017160-20391-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:49167
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751865Ab1JSJjj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Oct 2011 05:39:39 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

This patch series fixes several issues on boards in subj.
It is based on Tony's board branch at [1].

[1] git://github.com/tmlind/linux.git


Igor Grinberg (4):
  ARM: OMAP3: cm-t35: add regulator supply for ads7846
  ARM: OMAP3: cm-t35: fix DSS regulator supply
  ARM: OMAP3: cm-t35: fix audio
  arm: omap3: cm-t35: add reset for sb-t35 usb hub

 arch/arm/mach-omap2/board-cm-t35.c |   50 ++++++++++++++++++++++++++++-------
 1 files changed, 40 insertions(+), 10 deletions(-)

-- 
1.7.3.4

