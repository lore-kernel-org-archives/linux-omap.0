From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] ARM: OMAP2+: Fix null hwmod for ti-sysc debug
Date: Wed,  8 Aug 2018 01:07:03 -0700
Message-ID: <20180808080706.100389-2-tony@atomide.com>
References: <20180808080706.100389-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180808080706.100389-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We may call omap_hwmod_parse_module_range() with no hwmod allocated yet
and may have debug enabled. Let's fix this by checking for hwmod before
trying to use it's name.

Fixes: 6c72b3550672 ("ARM: OMAP2+: Parse module IO range from dts for legacy
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2220,7 +2220,7 @@ int omap_hwmod_parse_module_range(struct omap_hwmod *oh,
 	size = be32_to_cpup(ranges);
 
 	pr_debug("omap_hwmod: %s %s at 0x%llx size 0x%llx\n",
-		 oh->name, np->name, base, size);
+		 oh ? oh->name : "", np->name, base, size);
 
 	res->start = base;
 	res->end = base + size - 1;
-- 
2.17.1
