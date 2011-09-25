From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [RFC 1/5] ARM: dev_archdata: add private iommu extension
Date: Sun, 25 Sep 2011 13:58:53 +0300
Message-ID: <1316948337-7924-2-git-send-email-ohad@wizery.com>
References: <1316948337-7924-1-git-send-email-ohad@wizery.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1316948337-7924-1-git-send-email-ohad@wizery.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Joerg Roedel <Joerg.Roedel@amd.com>, iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Cousson Benoit <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Ohad Ben-Cohen <ohad@wizery.com>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

Add a private iommu pointer to the ARM-specific arch data in the
device struct, which will be used to attach iommu-specific data
to devices which require iommu support.

Different iommu implementations (on different platforms) will attach
different types of data to this pointer, so 'void *' is currently used
(the downside is reduced typesafety).

Note: ia64, x86 and sparc have this exact iommu extension as well, and
if others are likely to adopt it too, we might want to consider
adding this to the device struct itself directly.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/include/asm/device.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
index 9f390ce..6615f03 100644
--- a/arch/arm/include/asm/device.h
+++ b/arch/arm/include/asm/device.h
@@ -10,6 +10,9 @@ struct dev_archdata {
 #ifdef CONFIG_DMABOUNCE
 	struct dmabounce_device_info *dmabounce;
 #endif
+#ifdef CONFIG_IOMMU_API
+	void *iommu; /* private IOMMU data */
+#endif
 };
 
 struct pdev_archdata {
-- 
1.7.4.1
