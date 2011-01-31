From: David Cohen <david.cohen@nokia.com>
Subject: [PATCH 0/2] IOMMU error message cleanup
Date: Mon, 31 Jan 2011 19:25:06 +0200
Message-ID: <1296494708-17569-1-git-send-email-david.cohen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:64708 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752227Ab1AaRZP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Jan 2011 12:25:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com

From: David Cohen <david@dhcppc2.(none)>

Hi,

OMAP IOMMU prints error messages twice. These patches remove the error
message from the OMAP2,3 specific implementation and let them to be
printed on the above layer only.

Br,

David
---

David Cohen (2):
  OMAP: Add generic IOMMU errors code
  OMAP: Cleanup IOMMU error messages

 arch/arm/mach-omap2/iommu2.c            |   33 +++++++++++++--------------
 arch/arm/plat-omap/include/plat/iommu.h |    9 +++++++-
 arch/arm/plat-omap/iommu.c              |   36 ++++++++++++++++++++----------
 3 files changed, 48 insertions(+), 30 deletions(-)

