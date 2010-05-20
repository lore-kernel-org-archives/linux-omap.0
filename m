From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 0/3] omap iommu: kmemleak: Avoid false positive with special scan
Date: Thu, 20 May 2010 07:46:17 +0300
Message-ID: <1274330780-31764-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:60236 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753219Ab0ETErh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 May 2010 00:47:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: h-kanigeri2@ti.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Hi,

[PATCH 3/3] depends on the kmemleak patch sent to LKML as below:

http://groups.google.co.jp/group/linux.kernel/browse_thread/thread/51de33be01acf4e2

[PATCH 1/3] and [PATCH 2/3] are independent of the above.

Hiroshi DOYU (3):
  omap iommu: Introduce iopgd_is_table MACRO
  omap iommu: Rename iopte_[p,v]addr -> iopte_page_[p,v]addr
  omap iommu: kmemleak: Avoid false positive with special scan

 arch/arm/plat-omap/iommu.c     |   23 +++++++++++++++++++----
 arch/arm/plat-omap/iopgtable.h |    8 +++++---
 2 files changed, 24 insertions(+), 7 deletions(-)
