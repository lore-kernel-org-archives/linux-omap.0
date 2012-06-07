From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 06/11] ARM: OMAP4+: hwmod: fix issue causing IPs not going
 back to Smart-Standby
Date: Thu, 07 Jun 2012 00:13:11 -0600
Message-ID: <20120607061310.25532.60352.stgit@dusk>
References: <20120607060901.25532.68354.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60889 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759846Ab2FGGVi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 02:21:38 -0400
In-Reply-To: <20120607060901.25532.68354.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Djamil Elaidi <d-elaidi@ti.com>

From: Djamil Elaidi <d-elaidi@ti.com>

If an IP is configured in Smart-Standby-Wakeup, when disabling wakeup feature the
IP will not go back to Smart-Standby, but will remain in Smart-Standby-Wakeup.

Signed-off-by: Djamil Elaidi <d-elaidi@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 6b4ae31..d3afac5 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -530,7 +530,7 @@ static int _disable_wakeup(struct omap_hwmod *oh, u32 *v)
 	if (oh->class->sysc->idlemodes & SIDLE_SMART_WKUP)
 		_set_slave_idlemode(oh, HWMOD_IDLEMODE_SMART, v);
 	if (oh->class->sysc->idlemodes & MSTANDBY_SMART_WKUP)
-		_set_master_standbymode(oh, HWMOD_IDLEMODE_SMART_WKUP, v);
+		_set_master_standbymode(oh, HWMOD_IDLEMODE_SMART, v);
 
 	/* XXX test pwrdm_get_wken for this hwmod's subsystem */
 


