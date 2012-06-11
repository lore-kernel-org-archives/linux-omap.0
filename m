From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCHv2 03/12] ARM: OMAP4+: hwmod: fix issue causing IPs not going
 back to Smart-Standby
Date: Sun, 10 Jun 2012 18:46:02 -0600
Message-ID: <20120611004559.20034.69230.stgit@dusk>
References: <20120611004502.20034.8840.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42545 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559Ab2FKAwJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Jun 2012 20:52:09 -0400
In-Reply-To: <20120611004502.20034.8840.stgit@dusk>
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
index 096474c..2d1111d 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -530,7 +530,7 @@ static int _disable_wakeup(struct omap_hwmod *oh, u32 *v)
 	if (oh->class->sysc->idlemodes & SIDLE_SMART_WKUP)
 		_set_slave_idlemode(oh, HWMOD_IDLEMODE_SMART, v);
 	if (oh->class->sysc->idlemodes & MSTANDBY_SMART_WKUP)
-		_set_master_standbymode(oh, HWMOD_IDLEMODE_SMART_WKUP, v);
+		_set_master_standbymode(oh, HWMOD_IDLEMODE_SMART, v);
 
 	/* XXX test pwrdm_get_wken for this hwmod's subsystem */
 


