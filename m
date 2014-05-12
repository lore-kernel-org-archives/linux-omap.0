From: Joachim Eastwood <manabian@gmail.com>
Subject: [PATCH v3 4/4] ARM: OMAP2+: Use pdata quirks for wl12xx on VAR-STK/DVK-OM44
Date: Mon, 12 May 2014 20:32:03 +0200
Message-ID: <1399919523-20330-5-git-send-email-manabian@gmail.com>
References: <1399919523-20330-1-git-send-email-manabian@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:57355 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861AbaELScw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2014 14:32:52 -0400
Received: by mail-la0-f51.google.com with SMTP id gf5so2197960lab.24
        for <linux-omap@vger.kernel.org>; Mon, 12 May 2014 11:32:50 -0700 (PDT)
In-Reply-To: <1399919523-20330-1-git-send-email-manabian@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, bcousson@baylibre.com
Cc: linux-arm-kernel@lists.infradead.org, paul@pwsan.com, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, Joachim Eastwood <manabian@gmail.com>

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/mach-omap2/pdata-quirks.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index c3b73351cb7a..ab94f3a87c32 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -254,6 +254,11 @@ static void __init omap4_panda_legacy_init(void)
 {
 	legacy_init_wl12xx(WL12XX_REFCLOCK_38, 0, 53);
 }
+
+static void __init var_som_om44_legacy_init(void)
+{
+	legacy_init_wl12xx(WL12XX_REFCLOCK_38, 0, 41);
+}
 #endif
 
 #if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5)
@@ -364,6 +369,8 @@ static struct pdata_init pdata_quirks[] __initdata = {
 #ifdef CONFIG_ARCH_OMAP4
 	{ "ti,omap4-sdp", omap4_sdp_legacy_init, },
 	{ "ti,omap4-panda", omap4_panda_legacy_init, },
+	{ "variscite,var-dvk-om44", var_som_om44_legacy_init, },
+	{ "variscite,var-stk-om44", var_som_om44_legacy_init, },
 #endif
 #ifdef CONFIG_SOC_AM33XX
 	{ "ti,am335x-evmsk", am335x_evmsk_legacy_init, },
-- 
1.8.0

