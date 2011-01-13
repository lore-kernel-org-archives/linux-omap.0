From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH 0/2] cm-t3517 fixes
Date: Thu, 13 Jan 2011 18:24:48 +0200
Message-ID: <1294935890-31160-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:41711 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933020Ab1AMQYx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Jan 2011 11:24:53 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

This little patch serie is based on Tony's devel-board branch.
It fixes the rtc and some comments on cm-t3517.

Igor Grinberg (2):
  arm: omap3: cm-t3517: rtc fix
  arm: omap3: cm-t3517: minor comment fix

 arch/arm/mach-omap2/board-cm-t3517.c |   29 ++++++++++++++++++++++++-----
 1 files changed, 24 insertions(+), 5 deletions(-)

-- 
1.7.2.5

