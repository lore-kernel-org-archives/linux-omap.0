From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC PATCH 16/35] ARM: OMAP2+: voltage: remove code from __init section
Date: Wed, 15 Apr 2015 15:53:03 +0300
Message-ID: <1429102402-5276-17-git-send-email-t-kristo@ti.com>
References: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35754 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755478AbbDOMw7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Apr 2015 08:52:59 -0400
In-Reply-To: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org

Needed by hwmod module boot.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/voltage.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index cba8cad..84512e9 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -230,7 +230,7 @@ int omap_voltage_register_pmic(struct voltagedomain *voltdm,
  * system boot to init the voltage controller and
  * voltage processors.
  */
-int __init omap_voltage_late_init(void)
+int omap_voltage_late_init(void)
 {
 	struct voltagedomain *voltdm;
 
-- 
1.7.9.5

