From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/2] Few more omap DT patches for next merge window
Date: Thu, 01 Mar 2012 09:42:12 -0800
Message-ID: <20120301174037.12471.72457.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:15604 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024Ab2CARmQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Mar 2012 12:42:16 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Looks like we need one fix to what's currently queued up in
dt-part2 branch for omaps. And we can make board-generic more
readable by cutting down the ifdefs.

Regards,

Tony

---

Tony Lindgren (2):
      ARM: OMAP2+: Fix build error when only ARCH_OMAP2/3 or 4 is selected
      ARM: OMAP2+: Remove extra ifdefs for board-generic


 arch/arm/mach-omap2/board-generic.c |   83 ++++++++++++++++-------------------
 1 files changed, 39 insertions(+), 44 deletions(-)

-- 
Signature
