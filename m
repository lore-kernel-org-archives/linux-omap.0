From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 0/2] ARM: AM43xx: PRM: fix reset handling issues
Date: Tue, 5 May 2015 16:33:03 +0300
Message-ID: <1430832785-1976-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53783 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946032AbbEENd0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 May 2015 09:33:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, d-gerlach@ti.com, s-anna@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Hi,

The work done for consolidating PRM code introduced a reset issue
on AM43xx which is visible at least with wkup-m3, and prevents
taking the wkup-m3 core out from reset. Fixed by passing all the
relevant PRCM data from hwmod data, which was previously partly
omitted on OMAP4+ case.

This set also removes some redundant AM33xx hwmod code and just
re-uses the OMAP4+ version of the same.

Thanks to Dave Gerlach and Anna Suman for reporting this. Dave, care
to give this patch set a try to see if it fixes the problem you see?

Testing done:
- am335x-bone: boot
- am437x-gp-evm: boot
- omap4-panda-es: boot, suspend/resume, cpuidle

-Tero

