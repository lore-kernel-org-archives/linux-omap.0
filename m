Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88104C43334
	for <linux-omap@archiver.kernel.org>; Mon, 20 Jun 2022 15:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243022AbiFTPy5 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 20 Jun 2022 11:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiFTPy5 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 20 Jun 2022 11:54:57 -0400
Received: from mail-m965.mail.126.com (mail-m965.mail.126.com [123.126.96.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8D931D33D
        for <linux-omap@vger.kernel.org>; Mon, 20 Jun 2022 08:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=5dn32
        gPbrVIGVw+wSe7v6SJ3wdZJ9bQ8bEOiRJat8mI=; b=JXTHIgGdREtxxgvra76ll
        gibvbb4TH94Jej9AZNBqpN0V15ZBvGXlTHGHJGZGwQ3owq/Rpl6nZu9uELQJbY1Q
        vHqgKzwoAGcA9wiO0IbTGy2mI3ptJ0ZvfgWxWBX1Pzk+QyHD4NhQm5Kdf4VnVt42
        1DizOLlolbPM1GjZeZdKso=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp10 (Coremail) with SMTP id NuRpCgBnf4AumLBiZhoWFA--.25613S2;
        Mon, 20 Jun 2022 23:54:23 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     tony@atomide.com, linux@armlinux.org.uk
Cc:     windhl@126.com, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org
Subject: [PATCH v2] arm/mach-omap2: Fix refcount leak bugs
Date:   Mon, 20 Jun 2022 23:54:21 +0800
Message-Id: <20220620155421.4076532-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NuRpCgBnf4AumLBiZhoWFA--.25613S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxurW5ZryrWr48CF1fKFyUWrg_yoW5uFyUp3
        4vk3yv9r1UWwsrG3ykt34vqrWxtw1kWrWjyrWYk34xZan7ArWfAF1ftasIka43JrWru3Wr
        ZF10y3WUXa1qy37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UeT5JUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi3A8mF1pEDw0grwAAsx
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

We need to add of_node_put() to keep refcount balance for of_find_xxx()
which will return a node pointer with refcount incremented.

Signed-off-by: Liang He <windhl@126.com>
---
 changelog:

 v2:(1) we find several new leak bugs
    (2) we merge all mach-omap2 related bugs in to one commit

 v1: we send a patch for each missing of_node_put bug 



 arch/arm/mach-omap2/display.c      | 1 +
 arch/arm/mach-omap2/omap4-common.c | 1 +
 arch/arm/mach-omap2/omap_hwmod.c   | 6 ++++++
 arch/arm/mach-omap2/pdata-quirks.c | 2 ++
 4 files changed, 10 insertions(+)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 21413a9b7b6c..eb09a25e3b45 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -211,6 +211,7 @@ static int __init omapdss_init_fbdev(void)
 	node = of_find_node_by_name(NULL, "omap4_padconf_global");
 	if (node)
 		omap4_dsi_mux_syscon = syscon_node_to_regmap(node);
+	of_node_put(node);
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 6d1eb4eefefe..e981bf57e64f 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -135,6 +135,7 @@ static int __init omap4_sram_init(void)
 		pr_warn("%s:Unable to allocate sram needed to handle errata I688\n",
 			__func__);
 	sram_pool = of_gen_pool_get(np, "sram", 0);
+	of_node_put(np);
 	if (!sram_pool)
 		pr_warn("%s:Unable to get sram pool needed to handle errata I688\n",
 			__func__);
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 31d1a21f6041..814546c10bb8 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2365,6 +2365,7 @@ static int __init _init(struct omap_hwmod *oh, void *data)
 
 	r = _init_mpu_rt_base(oh, NULL, index, np);
 	if (r < 0) {
+		of_node_put(bus);
 		WARN(1, "omap_hwmod: %s: doesn't have mpu register target base\n",
 		     oh->name);
 		return 0;
@@ -2372,6 +2373,7 @@ static int __init _init(struct omap_hwmod *oh, void *data)
 
 	r = _init_clocks(oh, np);
 	if (r < 0) {
+		of_node_put(bus);
 		WARN(1, "omap_hwmod: %s: couldn't init clocks\n", oh->name);
 		return -EINVAL;
 	}
@@ -2385,6 +2387,8 @@ static int __init _init(struct omap_hwmod *oh, void *data)
 			parse_module_flags(oh, child);
 	}
 
+	of_node_put(bus);
+
 	oh->_state = _HWMOD_STATE_INITIALIZED;
 
 	return 0;
@@ -3648,6 +3652,7 @@ static void __init omap_hwmod_setup_earlycon_flags(void)
 	np = of_find_node_by_path("/chosen");
 	if (np) {
 		uart = of_get_property(np, "stdout-path", NULL);
+		of_node_put(np);
 		if (uart) {
 			np = of_find_node_by_path(uart);
 			if (np) {
@@ -3661,6 +3666,7 @@ static void __init omap_hwmod_setup_earlycon_flags(void)
 				}
 				if (oh)
 					oh->flags |= DEBUG_OMAPUART_FLAGS;
+				of_node_put(np);
 			}
 		}
 	}
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 13f1b89f74b8..5b99d602c87b 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -540,6 +540,8 @@ pdata_quirks_init_clocks(const struct of_device_id *omap_dt_match_table)
 
 		of_platform_populate(np, omap_dt_match_table,
 				     omap_auxdata_lookup, NULL);
+
+		of_node_put(np);
 	}
 }
 
-- 
2.25.1

