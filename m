From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH v2 0/4] ARM: OMAP3: cm-t35/cm-t3730 fixes
Date: Sun,  6 Nov 2011 16:13:47 +0200
Message-ID: <1320588827-9407-1-git-send-email-grinberg@compulab.co.il>
References: <1319017160-20391-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:47311
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752335Ab1KFOOF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Nov 2011 09:14:05 -0500
In-Reply-To: <1319017160-20391-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

This patch series fixes several issues on boards in subj.
It is based on Tony's fixes branch.

v2:	- Rebase on top of fixes branch
	- Elaborate more in the commit messages

Igor Grinberg (4):
  ARM: OMAP3: cm-t35: fix ads7846 touchscreen
  ARM: OMAP3: cm-t35: fix DSS regulator supply
  ARM: OMAP3: cm-t35: fix audio
  ARM: OMAP3: cm-t35: fix USB hub

 arch/arm/mach-omap2/board-cm-t35.c |   50 ++++++++++++++++++++++++++++-------
 1 files changed, 40 insertions(+), 10 deletions(-)

-- 
1.7.3.4

