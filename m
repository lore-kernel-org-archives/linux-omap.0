From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/18] omap2: select ARCH_OMAP_OTG for OMAP2430 SDP
Date: Wed, 05 May 2010 12:32:48 -0700
Message-ID: <20100505193248.21568.98322.stgit@baageli.muru.com>
References: <20100505192957.21568.19569.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56307 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758143Ab0EETcs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 15:32:48 -0400
In-Reply-To: <20100505192957.21568.19569.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Viral Mehta <viral.mehta@lntinfotech.com>, linux-omap@vger.kernel.org

From: Viral Mehta <viral.mehta@lntinfotech.com>

Configuration for OMAP2430 should select ARCH_OMAP_OTG just like
it is done for OMAP2420

Signed-off-by: Viral Mehta <viral.mehta@lntinfotech.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 2455dcc..99abac2 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -10,6 +10,7 @@ config ARCH_OMAP2420
 config ARCH_OMAP2430
 	bool "OMAP2430 support"
 	depends on ARCH_OMAP2
+	select ARCH_OMAP_OTG
 
 config ARCH_OMAP3430
 	bool "OMAP3430 support"

