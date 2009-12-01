From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [rfc/rft/patch 4/9] arm: omap: io: kill compile warning
Date: Tue,  1 Dec 2009 15:03:50 +0200
Message-ID: <1259672635-12306-5-git-send-email-felipe.balbi@nokia.com>
References: <1259672635-12306-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:20648 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181AbZLANEr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 08:04:47 -0500
In-Reply-To: <1259672635-12306-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Kalle Valo <kalle.valo@iki.fi>, Jean Pihet <jpihet@mvista.com>, Vikram Pandita <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <felipe.balbi@nokia.com>

when building omap4 defconfigs, io.c will warn about unused
_omap2_init_reprogram_sdrc, that's because that functio is
only used ifndef CONFIG_ARCH_OMAP4, so add the missing
ifndef CONFIG_ARCH_OMAP4 to _omap2_init_reprogram_sdrc
definition.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/io.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 6a4d8e4..a2be3ce 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -278,6 +278,7 @@ void __init omap2_map_common_io(void)
  * -EINVAL if the dpll3_m2_ck cannot be found, 0 if called on OMAP2,
  * or passes along the return value of clk_set_rate().
  */
+#ifndef CONFIG_ARCH_OMAP4
 static int __init _omap2_init_reprogram_sdrc(void)
 {
 	struct clk *dpll3_m2_ck;
@@ -301,6 +302,7 @@ static int __init _omap2_init_reprogram_sdrc(void)
 
 	return v;
 }
+#endif
 
 void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 				 struct omap_sdrc_params *sdrc_cs1)
-- 
1.6.6.rc0

