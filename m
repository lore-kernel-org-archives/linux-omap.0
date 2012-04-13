From: Juan Gutierrez <jgutierrez@ti.com>
Subject: [PATCH v2 0/3] Fixes in preparation for enabling Dsp in omap4
Date: Fri, 13 Apr 2012 18:39:49 -0500
Message-ID: <1334360392-1494-1-git-send-email-jgutierrez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:50087 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757263Ab2DMXkJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Apr 2012 19:40:09 -0400
Received: by obbta17 with SMTP id ta17so4139135obb.29
        for <linux-omap@vger.kernel.org>; Fri, 13 Apr 2012 16:40:08 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ohad@wizery.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Juan Gutierrez <jgutierrez@ti.com>

This set of patches provides the foundation for enabling
OMAP4 Dsp (Tesla) as remote processor.

The first patch is a generic fix for mailbox in mach-omap2.
Without this patch, the irq for a mailbox instance other than
the first one is not properly enabled.

The second patch fixes the clock and irq names for the Tesla
iommu in omap4 and enable it by default.

The third patch adds a generic mechanism in remoteproc for
loading the boot address in a special bootloader register, if
needed by the remoteproc like is the case for Tesla in omap4.

History:
=======
Changes from v1:
  - Whitespaces and tabs were added when sending the patches
    by the mailer, due to wrong configuration. 
  - No code changes.

Juan Gutierrez (3):
  omap: mailbox: enable mailbox irq per instance
  OMAP4: iommu: fix irq and clock name for dsp-iommu
  omap: remoteproc: add support for a boot register

 arch/arm/mach-omap2/mailbox.c                |    2 --
 arch/arm/mach-omap2/omap-iommu.c             |    6 ++----
 arch/arm/plat-omap/include/plat/remoteproc.h |    2 ++
 arch/arm/plat-omap/mailbox.c                 |    3 +++
 drivers/remoteproc/omap_remoteproc.c         |   19 +++++++++++++++++++
 5 files changed, 26 insertions(+), 6 deletions(-)

