From: Mans Rullgard <mans@mansr.com>
Subject: [PATCH] OMAP: Increase VMALLOC_END to allow 256MB RAM
Date: Thu,  2 Oct 2008 09:36:51 +0100
Message-ID: <1222936611-19084-1-git-send-email-mans@mansr.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from agrajag.mansr.com ([78.86.181.102]:42787 "EHLO mail.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754195AbYJBIgx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Oct 2008 04:36:53 -0400
Received: from thrashbarg.mansr.com (thrashbarg.mansr.com [78.86.181.100])
	by mail.mansr.com (Postfix) with ESMTP id 6248B1C0094
	for <linux-omap@vger.kernel.org>; Thu,  2 Oct 2008 09:36:51 +0100 (BST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This increases VMALLOC_END to 0x18000000, making room for 256MB
RAM with the default 128MB vmalloc region.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 arch/arm/plat-omap/include/mach/vmalloc.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/vmalloc.h b/arch/arm/plat-omap/include/mach/vmalloc.h
index d8515cb..b97dfaf 100644
--- a/arch/arm/plat-omap/include/mach/vmalloc.h
+++ b/arch/arm/plat-omap/include/mach/vmalloc.h
@@ -17,5 +17,5 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
-#define VMALLOC_END	  (PAGE_OFFSET + 0x17000000)
+#define VMALLOC_END	  (PAGE_OFFSET + 0x18000000)
 
-- 
1.6.0.2

