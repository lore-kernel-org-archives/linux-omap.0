From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] omap: enable iva2 iommu
Date: Mon, 11 Oct 2010 12:53:48 +0300
Message-ID: <1286790830-13505-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42832 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426Ab0JKJyE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Oct 2010 05:54:04 -0400
Received: by bwz15 with SMTP id 15so1557587bwz.19
        for <linux-omap@vger.kernel.org>; Mon, 11 Oct 2010 02:54:02 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>

Hi,

It seems the migration to iommu is already merged (perhaps prematurely... can't
get it working). So iva2 iommu needs to be enabled.

Felipe Contreras (2):
  omap: iommu: make iva2 iommu selectable
  staging: tidspbridge: enable iva2 iommu

 arch/arm/mach-omap2/omap-iommu.c    |    2 +-
 arch/arm/plat-omap/Kconfig          |    3 +++
 drivers/staging/tidspbridge/Kconfig |    1 +
 3 files changed, 5 insertions(+), 1 deletions(-)

-- 
1.7.3.1.2.g7fe2b

