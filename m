From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 04/15] arm/omap: use generic_file_llseek in iommu_debug
Date: Tue, 14 Sep 2010 22:22:32 +0200
Message-ID: <1284495763-7506-5-git-send-email-arnd@arndb.de>
References: <1284495763-7506-1-git-send-email-arnd@arndb.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:64015 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754004Ab0INUXS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Sep 2010 16:23:18 -0400
In-Reply-To: <1284495763-7506-1-git-send-email-arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

In future kernels, debugfs files need to specify
the llseek operation explicitly to allow seeking.
This sets the llseek operation in the omap iommu
debugfs files to generic_file_llseek, which is
appropriate for files using simple_read_from_buffer.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
---
 arch/arm/plat-omap/iommu-debug.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/iommu-debug.c b/arch/arm/plat-omap/iommu-debug.c
index e6c0d53..f07cf2f 100644
--- a/arch/arm/plat-omap/iommu-debug.c
+++ b/arch/arm/plat-omap/iommu-debug.c
@@ -328,12 +328,14 @@ static int debug_open_generic(struct inode *inode, struct file *file)
 		.open = debug_open_generic,				\
 		.read = debug_read_##name,				\
 		.write = debug_write_##name,				\
+		.llseek = generic_file_llseek,				\
 	};
 
 #define DEBUG_FOPS_RO(name)						\
 	static const struct file_operations debug_##name##_fops = {	\
 		.open = debug_open_generic,				\
 		.read = debug_read_##name,				\
+		.llseek = generic_file_llseek,				\
 	};
 
 DEBUG_FOPS_RO(ver);
-- 
1.7.1

