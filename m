From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] omap: hwmod: fix section mismatch warnings
Date: Fri, 15 Sep 2017 21:45:12 +0200
Message-ID: <20170915194527.1171677-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Older compilers choose not to inline _setup_clkctrl_provider(),
leading to a harmless warning:

WARNING: vmlinux.o(.text+0x27b34): Section mismatch in reference from the function _setup_clkctrl_provider() to the function .init.text:memblock_virt_alloc_try_nid()
The function _setup_clkctrl_provider() references
the function __init memblock_virt_alloc_try_nid().
This is often because _setup_clkctrl_provider lacks a __init
annotation or the annotation of memblock_virt_alloc_try_nid is wrong.

This annotates it as __init as well, which lets the linker
see that it is actually correct.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap2/omap_hwmod.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 2dbd63239c54..91ec0ca4822b 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -732,7 +732,7 @@ static int _match_clkdm(struct clockdomain *clkdm, void *user)
 	return 0;
 }
 
-static int _setup_clkctrl_provider(struct device_node *np)
+static int __init _setup_clkctrl_provider(struct device_node *np)
 {
 	const __be32 *addrp;
 	struct clkctrl_provider *provider;
@@ -761,7 +761,7 @@ static int _setup_clkctrl_provider(struct device_node *np)
 	return 0;
 }
 
-static int _init_clkctrl_providers(void)
+static int __init _init_clkctrl_providers(void)
 {
 	struct device_node *np;
 	int ret = 0;
-- 
2.9.0
