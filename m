From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 0/1] omap2/3: Update revision identification
Date: Mon, 16 Aug 2010 21:22:41 +0530
Message-ID: <1281973961-2432-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35175 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754671Ab0HPPws (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Aug 2010 11:52:48 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o7GFqjKc009340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 16 Aug 2010 10:52:48 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This patch unifies the definition of revision bits
that used different base(nibble) since the OMAP3630
revisions.

Summary of changes that may not seem apparent:
1) Specific ES revision definitions are derived from
   the associated class and ORing of the revision bits.

2) To do so, "dummy" OMAP363X_CLASS was defined.

Since, the patch impacts many targets that I cannot test
against, would be good to know if it works well. I need
to test against multiple OMAP3EVMs as well.

Printing the cpu revision string seems to be okay for
now, but we may need to go for a look-up based approach
for each processor family. The switch-case in id.c may
end up quite complicated.
...something to work in future.

Sanjeev Premi (1):
  omap2/3: Update revision identification

 arch/arm/mach-omap2/id.c              |   22 +++++++++++---------
 arch/arm/plat-omap/include/plat/cpu.h |   36 ++++++++++++++++----------------
 2 files changed, 30 insertions(+), 28 deletions(-)

