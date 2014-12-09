From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH 3/7] arm: omap: hwmod: drop 'const' qualifier from omap_hwmod_class name
Date: Tue, 9 Dec 2014 16:27:48 -0600
Message-ID: <1418164072-19087-4-git-send-email-balbi@ti.com>
References: <1418164072-19087-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39830 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753263AbaLIW2V (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Dec 2014 17:28:21 -0500
In-Reply-To: <1418164072-19087-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, Felipe Balbi <balbi@ti.com>

We will be allocating struct omap_hwmod_class for
any DT which passes sysc data. Because of that,
class->name cannot be const.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index fcf55f5..0ee0116 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -588,7 +588,7 @@ struct omap_hwmod_omap4_prcm {
  * unusual reset sequences - usually processor IP blocks like the IVA.
  */
 struct omap_hwmod_class {
-	const char				*name;
+	char					*name;
 	struct omap_hwmod_class_sysconfig	*sysc;
 	u32					rev;
 	int					(*pre_shutdown)(struct omap_hwmod *oh);
-- 
2.2.0

