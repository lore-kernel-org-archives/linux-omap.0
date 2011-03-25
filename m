From: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>
Subject: [PATCH 0/4] iommu: Prevent oops in iommu_get() and while arch_iommu
 is in use
Date: Fri, 25 Mar 2011 17:13:10 +0200
Message-ID: <4D8CB106.7030608@maxwell.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:63879 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750922Ab1CYPNQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Mar 2011 11:13:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Cohen

Hi,

This patchset is aimed to fix a problem in arch_iommu implementation
references. When an actual arch_iommu implementation is not loaded while
iommu_get() is being called results to a kernel oops, as well as
removing an arch_iommu implementation which is in use.

This patchset fixes both issues.

The patchset assumes the arch_iommu is uninstalled at module unload
time. Is this an acceptable requirement?

Serialisation of the access to arch_iommu is done using mutex called
arch_iommu_mutex.

module_put() doesn't need to have the arch_iommu_mutex since when this
gets called there won't be any users on the arch_iommu anyway.

Comments are welcome. :-)

Cheers,

-- 
Sakari Ailus
sakari.ailus@maxwell.research.nokia.com
