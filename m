From: Juan Gutierrez <jgutierrez@ti.com>
Subject: [PATCH v3 0/2] Fixes in preparation for enabling Dsp in omap4
Date: Wed,  9 May 2012 21:19:28 -0500
Message-ID: <1336616370-28268-1-git-send-email-jgutierrez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:42856 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752532Ab2EJCTq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 22:19:46 -0400
Received: by ggmi1 with SMTP id i1so745911ggm.31
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 19:19:44 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ohad@wizery.com
Cc: Juan Gutierrez <jgutierrez@ti.com>

This set of patches provides the foundation for enabling
OMAP4 Dsp as remote processor.

The first patch is a generic fix for mailbox in mach-omap2.
Without this patch, the irq for a mailbox instance other than
the first one is not properly enabled.

The second patch fixes the clock and irq names for the Tesla
iommu in omap4 and enable it by default.

History:
=======
Changes from v2:
 - Patch 3 is removed from this series. 
   If http://marc.info/?l=linux-omap&m=133601127627420&w=2
   is merged, it might be revisited. 	

 - Changes in patch 1:
   - Use omap_mbox_enable/disable_irq APIs instead of the
     internal ops.
   - Move notifier_block before enabling the mbox's irq to
     avoid possible race.
 - Changes in patch 2:
   - Commit message revisited to clarify the need of the change.

Changes from v1:
  - Whitespaces and tabs were added when sending the patches
    by the mailer, due to wrong configuration. 
  - No code changes.


Juan Gutierrez (2):
  omap: mailbox: enable mailbox irq per instance
  omap4: iommu: fix irq and clock name for dsp-iommu

 arch/arm/mach-omap2/mailbox.c    |    2 --
 arch/arm/mach-omap2/omap-iommu.c |    6 ++----
 arch/arm/plat-omap/mailbox.c     |    9 ++++++---
 3 files changed, 8 insertions(+), 9 deletions(-)

-- 
1.7.5.4

