From: Ionut Nicu <ionut.nicu@gmail.com>
Subject: [PATCH] tidspbridge: select OMAP_IOMMU dependency
Date: Sat,  9 Oct 2010 14:42:10 +0300
Message-ID: <1286624530-30581-1-git-send-email-ionut.nicu@mindbit.ro>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:52214 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754713Ab0JILmW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Oct 2010 07:42:22 -0400
Received: by ewy20 with SMTP id 20so24998ewy.19
        for <linux-omap@vger.kernel.org>; Sat, 09 Oct 2010 04:42:21 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Ionut Nicu <ionut.nicu@mindbit.ro>

Since the iommu migration patches tidspbridge depends
on the OMAP specific IOMMU implementation. We need to
add this dependency, otherwise we'll have link time
errors.

Signed-off-by: Ionut Nicu <ionut.nicu@mindbit.ro>
---
 drivers/staging/tidspbridge/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/tidspbridge/Kconfig b/drivers/staging/tidspbridge/Kconfig
index 93de4f2..ff64d46 100644
--- a/drivers/staging/tidspbridge/Kconfig
+++ b/drivers/staging/tidspbridge/Kconfig
@@ -6,6 +6,7 @@ menuconfig TIDSPBRIDGE
 	tristate "DSP Bridge driver"
 	depends on ARCH_OMAP3
 	select OMAP_MBOX_FWK
+	select OMAP_IOMMU
 	help
 	  DSP/BIOS Bridge is designed for platforms that contain a GPP and
 	  one or more attached DSPs.  The GPP is considered the master or
-- 
1.7.2.3

