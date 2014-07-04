From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 00/10] ARM: OMAP2+: PRCM cleanup series for 3.17
Date: Fri, 4 Jul 2014 17:10:25 +0300
Message-ID: <1404483035-21666-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55045 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754401AbaGDOKj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Jul 2014 10:10:39 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Hi,

Here's a small PRCM cleanup series against 3.16-rc1, meant for 3.17
if at all possible. Basically some cleanup to remove the direct CM/PRM
register accesses outside PRCM drivers. This set is touching the OMAP2/
OMAP3 code only. This series is part of the ongoing work to make PRCM
a separate driver.

Testing done:
- omap2430-sdp : boot
- omap3-beagle : boot, suspend/resume (ret), suspend/resume (off)

Working branch:
- tree: https://github.com/t-kristo/linux-pm.git
- branch: for-v3.17/cm-prm-cleanup

-Tero

