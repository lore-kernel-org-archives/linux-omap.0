From: David Cohen <dacohen@gmail.com>
Subject: [PATCH 0/2] IOMMU fault callback support
Date: Tue, 15 Feb 2011 15:20:31 +0200
Message-ID: <1297776033-8579-1-git-send-email-dacohen@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:47794 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751241Ab1BONPh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 08:15:37 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi.DOYU@nokia.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

Hi,

This patch set adds fault callback support to allow IOMMU users to debug or
react when a fault happens.
IOMMU faults might be very difficult to reproduce and then to figure out
the source of the problem. Currently IOMMU driver prints not so useful
debug message and does not notice user about such issue.
With a fault callback, IOMMU user may debug much more useful information
and/or react to go back to a valid state.

Br,

David
---

David Cohen (2):
  OMAP2+: IOMMU: change OMAP2+ error message to dev_dbg()
  OMAP: IOMMU: add support to callback during fault handling

 arch/arm/mach-omap2/iommu2.c            |   27 ++++++++++++++++----
 arch/arm/plat-omap/include/plat/iommu.h |   15 ++++++++++-
 arch/arm/plat-omap/iommu.c              |   41 ++++++++++++++++++++++++++++---
 3 files changed, 72 insertions(+), 11 deletions(-)

-- 
1.7.2.3

