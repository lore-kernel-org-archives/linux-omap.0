From: David Cohen <dacohen@gmail.com>
Subject: [RFC/PATCH 0/3] IOMMU fault callback support
Date: Sat, 12 Feb 2011 12:42:50 +0200
Message-ID: <1297507373-1520-1-git-send-email-dacohen@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:38649 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab1BLKnB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Feb 2011 05:43:01 -0500
Received: by ewy5 with SMTP id 5so1719507ewy.19
        for <linux-omap@vger.kernel.org>; Sat, 12 Feb 2011 02:43:00 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi.DOYU@nokia.com
Cc: linux-omap@vger.kernel.org, David Cohen <dacohen@gmail.com>

Hi,

These are RFC patches. They're intended to add fault callback support so
IOMMU users can debug or react when a fault happens.
IOMMU faults might be very difficult to reproduce and then to figure out
the source of the problem. Currently IOMMU driver prints not so useful
debug message and does not notice user about such issue.
With a fault callback, IOMMU user may debug much more useful information
and/or react to go back to a valid state or, in worse cases, to leave device
in a state where it's still possible to use it and proceed with some
investigation.

Comments are welcome.

Br,

David
---

David Cohen (3):
  OMAP: IOMMU: Add generic IOMMU errors code
  OMAP2+: IOMMU: change OMAP2+ error message to dev_dbg()
  OMAP: IOMMU: add support to callback during fault handling

 arch/arm/mach-omap2/iommu2.c            |   23 ++++++++++++++---
 arch/arm/plat-omap/include/plat/iommu.h |   15 ++++++++++-
 arch/arm/plat-omap/iommu.c              |   41 ++++++++++++++++++++++++++++---
 3 files changed, 70 insertions(+), 9 deletions(-)

