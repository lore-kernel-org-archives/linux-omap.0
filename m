From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 06/12] ARM: omap2: mark unused functions as __maybe_unused
Date: Thu, 20 Jul 2017 17:51:44 +0200
Message-ID: <20170720155209.3250880-3-arnd@arndb.de>
References: <20170720154616.3250481-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170720154616.3250481-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Lokesh Vutla <lokeshvutla@ti.com>, Keerthy <j-keerthy@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sebastian Reichel <sre@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The omap_generic_init() and omap_hwmod_init_postsetup() functions are
used in the initialization for all OMAP2+ SoC types, but in the
extreme case that those are all disabled, we get a warning about
unused code:

arch/arm/mach-omap2/io.c:412:123: error: 'omap_hwmod_init_postsetup' defined but not used [-Werror=unused-function]
arch/arm/mach-omap2/board-generic.c:30:123: error: 'omap_generic_init' defined but not used [-Werror=unused-function]

This annotates both as __maybe_unused to shut up that warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Tony Lindgren <tony@atomide.com>
---
Originally sent in Feb 2016, but it got lost for some reason.
---
 arch/arm/mach-omap2/board-generic.c | 2 +-
 arch/arm/mach-omap2/io.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index dc9e34e670a2..b1e661bb5521 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -28,7 +28,7 @@ static const struct of_device_id omap_dt_match_table[] __initconst = {
 	{ }
 };
 
-static void __init omap_generic_init(void)
+static void __init __maybe_unused omap_generic_init(void)
 {
 	pdata_quirks_init(omap_dt_match_table);
 
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 1d739d1a0a65..1cd20e4d56b0 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -410,7 +410,7 @@ static int _set_hwmod_postsetup_state(struct omap_hwmod *oh, void *data)
 	return omap_hwmod_set_postsetup_state(oh, *(u8 *)data);
 }
 
-static void __init omap_hwmod_init_postsetup(void)
+static void __init __maybe_unused omap_hwmod_init_postsetup(void)
 {
 	u8 postsetup_state;
 
-- 
2.9.0
