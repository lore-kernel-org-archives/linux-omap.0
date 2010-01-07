From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 12/12] omap3: EVM: Choose OMAP_PACKAGE_CBB
Date: Wed, 06 Jan 2010 16:20:54 -0800
Message-ID: <20100107002054.21352.23704.stgit@baageli.muru.com>
References: <20100107001728.21352.38471.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56977 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932266Ab0AGAUy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 19:20:54 -0500
In-Reply-To: <20100107001728.21352.38471.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

Without this the kernel doesn't boot, it craches in
omap_mux_package_fixup(), since the package_subset becomes NULL.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 10eafa7..606bf04 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -80,6 +80,7 @@ config MACH_OVERO
 config MACH_OMAP3EVM
 	bool "OMAP 3530 EVM board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+	select OMAP_PACKAGE_CBB
 
 config MACH_OMAP3517EVM
 	bool "OMAP3517/ AM3517 EVM board"

