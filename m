From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 1/6] omap iommu: tlb and pagetable primitives
Date: Tue, 5 May 2009 15:19:55 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E2AE46B4D@dlee03.ent.ti.com>
References: <20090505123905.4583.69865.stgit@oreo.research.nokia.com>
 <20090505124650.4583.39458.stgit@oreo.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48276 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753357AbZEEUU2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 May 2009 16:20:28 -0400
In-Reply-To: <20090505124650.4583.39458.stgit@oreo.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "sakari.ailus@maxwell.research.nokia.com" <sakari.ailus@maxwell.research.nokia.com>, "tony@atomide.com" <tony@atomide.com>, "Pasam, Vijay" <vpasam@ti.com>

Hi Doyu-san,

+static void iotlb_lock_set(struct iommu *obj, struct iotlb_lock *l) {
+	u32 val;
+
+	BUG_ON(l->base != 0); /* Currently no preservation is used */

-- Did you notice any issues in the IOMMU driver by enabling the preservation? 

Bridge driver is locking the memory segment that is used for IPC in the TLB and by not having the preservation we might see a hit in the performance.

Thank you,
Best regards,
Hari
