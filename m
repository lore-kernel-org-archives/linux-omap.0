From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/5] OMAP2+: hwmod: fix a documentation bug with
	HWMOD_NO_OCP_AUTOIDLE
Date: Mon, 07 Mar 2011 22:44:33 -0700
Message-ID: <20110308054431.1309.86874.stgit@twilight.localdomain>
References: <20110308054315.1309.10538.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60585 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753593Ab1CHFp1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 00:45:27 -0500
In-Reply-To: <20110308054315.1309.10538.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The documented name of the HWMOD_NO_OCP_AUTOIDLE flag was incorrect; fix it.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index fedd829..c61e126 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -372,7 +372,7 @@ struct omap_hwmod_omap4_prcm {
  *     SDRAM controller, etc. XXX probably belongs outside the main hwmod file
  * HWMOD_INIT_NO_IDLE: don't idle this module at boot - important for SDRAM
  *     controller, etc. XXX probably belongs outside the main hwmod file
- * HWMOD_NO_AUTOIDLE: disable module autoidle (OCP_SYSCONFIG.AUTOIDLE)
+ * HWMOD_NO_OCP_AUTOIDLE: disable module autoidle (OCP_SYSCONFIG.AUTOIDLE)
  *     when module is enabled, rather than the default, which is to
  *     enable autoidle
  * HWMOD_SET_DEFAULT_CLOCKACT: program CLOCKACTIVITY bits at startup


