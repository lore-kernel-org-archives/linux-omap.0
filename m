From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/3] ARM: omap2: mark unused functions as __maybe_unused
Date: Tue, 23 Feb 2016 14:57:51 +0100
Message-ID: <1456235876-4088840-2-git-send-email-arnd@arndb.de>
References: <1456235876-4088840-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456235876-4088840-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The omap_generic_init() and omap_hwmod_init_postsetup() functions are
used in the initialization for all OMAP2+ SoC types, but in the
extreme case that those are all disabled, we get a warning about
unused code:

arch/arm/mach-omap2/io.c:412:123: error: 'omap_hwmod_init_postsetup' defined but not used [-Werror=unused-function]
arch/arm/mach-omap2/board-generic.c:30:123: error: 'omap_generic_init' defined but not used [-Werror=unused-function]

This annotates both as __maybe_unused to shut up that warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap2/board-generic.c | 2 +-
 arch/arm/mach-omap2/io.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index bab814d2f37d..d75ec64ae0b5 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -28,7 +28,7 @@ static const struct of_device_id omap_dt_match_table[] __initconst = {
 	{ }
 };
 
-static void __init omap_generic_init(void)
+static void __init __maybe_unused omap_generic_init(void)
 {
 	omapdss_early_init_of();
 
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 3c87e40650cf..f192fc7fd4f7 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -409,7 +409,7 @@ static int _set_hwmod_postsetup_state(struct omap_hwmod *oh, void *data)
 	return omap_hwmod_set_postsetup_state(oh, *(u8 *)data);
 }
 
-static void __init omap_hwmod_init_postsetup(void)
+static void __init __maybe_unused omap_hwmod_init_postsetup(void)
 {
 	u8 postsetup_state;
 
-- 
2.7.0
