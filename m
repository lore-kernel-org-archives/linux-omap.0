From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] staging: tidspbridge: enable iva2 iommu
Date: Mon, 11 Oct 2010 12:53:50 +0300
Message-ID: <1286790830-13505-3-git-send-email-felipe.contreras@gmail.com>
References: <1286790830-13505-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42832 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706Ab0JKJyI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Oct 2010 05:54:08 -0400
Received: by mail-bw0-f46.google.com with SMTP id 15so1557587bwz.19
        for <linux-omap@vger.kernel.org>; Mon, 11 Oct 2010 02:54:07 -0700 (PDT)
In-Reply-To: <1286790830-13505-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Yogesh Marathe <yogesh_marathe@ti.com>

Needed now that the migration to iommu is done.

Cc: Fernando Guzman Lugo <fernando.lugo@ti.com>
Cc: Yogesh Marathe <yogesh_marathe@ti.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/staging/tidspbridge/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/tidspbridge/Kconfig b/drivers/staging/tidspbridge/Kconfig
index ff64d46..05716ad 100644
--- a/drivers/staging/tidspbridge/Kconfig
+++ b/drivers/staging/tidspbridge/Kconfig
@@ -7,6 +7,7 @@ menuconfig TIDSPBRIDGE
 	depends on ARCH_OMAP3
 	select OMAP_MBOX_FWK
 	select OMAP_IOMMU
+	select OMAP_IOMMU_IVA2
 	help
 	  DSP/BIOS Bridge is designed for platforms that contain a GPP and
 	  one or more attached DSPs.  The GPP is considered the master or
-- 
1.7.3.1.2.g7fe2b

