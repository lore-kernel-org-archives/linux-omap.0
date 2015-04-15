From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC PATCH 13/35] ARM: OMAP2+: VP: remove code from __init section
Date: Wed, 15 Apr 2015 15:53:00 +0300
Message-ID: <1429102402-5276-14-git-send-email-t-kristo@ti.com>
References: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52079 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755140AbbDOMwy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Apr 2015 08:52:54 -0400
In-Reply-To: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org

Needed for hwmod module boot.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/vp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
index a3c3065..f757e94 100644
--- a/arch/arm/mach-omap2/vp.c
+++ b/arch/arm/mach-omap2/vp.c
@@ -35,7 +35,7 @@ static u32 _vp_set_init_voltage(struct voltagedomain *voltdm, u32 volt)
 }
 
 /* Generic voltage init functions */
-void __init omap_vp_init(struct voltagedomain *voltdm)
+void omap_vp_init(struct voltagedomain *voltdm)
 {
 	struct omap_vp_instance *vp = voltdm->vp;
 	u32 val, sys_clk_rate, timeout, waittime;
-- 
1.7.9.5

