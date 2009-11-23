From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 3/4] AM3517: MMC: Modifying Makefile to enable MMC init
Date: Mon, 23 Nov 2009 23:55:21 +0530
Message-ID: <1259000722-32222-3-git-send-email-anuj.aggarwal@ti.com>
References: <1259000722-32222-1-git-send-email-anuj.aggarwal@ti.com>
 <1259000722-32222-2-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34263 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753027AbZKWSZT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Nov 2009 13:25:19 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nANIPNLt025950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2009 12:25:25 -0600
In-Reply-To: <1259000722-32222-2-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Anuj Aggarwal <anuj.aggarwal@ti.com>

Modifying Makefile to build mmc-am3517.c for AM3517 platform, this
file has the mmc_init function for 3517 EVM.

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 arch/arm/mach-omap2/Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 59b0ccc..77ec48b 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -93,7 +93,8 @@ obj-$(CONFIG_MACH_IGEP0020)		+= board-igep0020.o \
 
 obj-$(CONFIG_MACH_OMAP_4430SDP)		+= board-4430sdp.o
 
-obj-$(CONFIG_MACH_OMAP3517EVM)     += board-am3517evm.o
+obj-$(CONFIG_MACH_OMAP3517EVM)		+= board-am3517evm.o \
+					   mmc-am3517evm.o
 
 # Platform specific device init code
 obj-y					+= usb-musb.o
-- 
1.6.2.4

