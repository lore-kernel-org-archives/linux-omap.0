From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 2/5] OMAP4: prm: Remove wrong clockdomain offsets
Date: Fri, 1 Jul 2011 22:27:37 +0200
Message-ID: <1309552060-4547-3-git-send-email-b-cousson@ti.com>
References: <1309552060-4547-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33795 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755314Ab1GAU15 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 16:27:57 -0400
In-Reply-To: <1309552060-4547-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, rnayak@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

The following commit introduced new macros to define an offset
per clock domain in an instance.

commit e4156ee52fe617c2c2d80b5db993ff4bf07d7c3c

    OMAP4: CM instances: add clockdomain register offsets

The PRM contains only two clock controls management entities:
EMU and WKUP.
Remove the other ones.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Reviewed-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/prm44xx.h |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/prm44xx.h b/arch/arm/mach-omap2/prm44xx.h
index 2aec8c8..6e53120 100644
--- a/arch/arm/mach-omap2/prm44xx.h
+++ b/arch/arm/mach-omap2/prm44xx.h
@@ -57,19 +57,7 @@
 #define OMAP4430_PRM_INSTR_INST		0x1f00
 
 /* PRM clockdomain register offsets (from instance start) */
-#define OMAP4430_PRM_MPU_MPU_CDOFFS		0x0000
-#define OMAP4430_PRM_TESLA_TESLA_CDOFFS		0x0000
-#define OMAP4430_PRM_ABE_ABE_CDOFFS		0x0000
-#define OMAP4430_PRM_CORE_CORE_CDOFFS		0x0000
-#define OMAP4430_PRM_IVAHD_IVAHD_CDOFFS		0x0000
-#define OMAP4430_PRM_CAM_CAM_CDOFFS		0x0000
-#define OMAP4430_PRM_DSS_DSS_CDOFFS		0x0000
-#define OMAP4430_PRM_GFX_GFX_CDOFFS		0x0000
-#define OMAP4430_PRM_L3INIT_L3INIT_CDOFFS	0x0000
-#define OMAP4430_PRM_L4PER_L4PER_CDOFFS		0x0000
-#define OMAP4430_PRM_CEFUSE_CEFUSE_CDOFFS	0x0000
 #define OMAP4430_PRM_WKUP_CM_WKUP_CDOFFS	0x0000
-#define OMAP4430_PRM_EMU_EMU_CDOFFS		0x0000
 #define OMAP4430_PRM_EMU_CM_EMU_CDOFFS		0x0000
 
 /* OMAP4 specific register offsets */
-- 
1.7.0.4

