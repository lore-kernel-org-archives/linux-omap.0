From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] omap3: Allow EHCI to be built on OMAP3
Date: Wed, 16 Dec 2009 11:09:51 -0800
Message-ID: <20091216190951.30032.47819.stgit@localhost>
References: <20091216190601.30032.91535.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60827 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935315AbZLPTJ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2009 14:09:57 -0500
In-Reply-To: <20091216190601.30032.91535.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, Anand Gadiyar <gadiyar@ti.com>

From: Olof Johansson <olof@lixom.net>

OMAP34XX has EHCI, so select USB_ARCH_HAS_EHCI.

Signed-off-by: Olof Johansson <olof@lixom.net>
Acked-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 76c11ee..10eafa7 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -18,6 +18,7 @@ config ARCH_OMAP2430
 config ARCH_OMAP34XX
 	bool "OMAP34xx Based System"
 	depends on ARCH_OMAP3
+	select USB_ARCH_HAS_EHCI
 
 config ARCH_OMAP3430
 	bool "OMAP3430 support"

