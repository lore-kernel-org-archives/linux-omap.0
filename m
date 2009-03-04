From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] ARM: OMAP: Fix compile error if pm.h is included
Date: Wed, 04 Mar 2009 10:26:36 -0800
Message-ID: <20090304182635.27331.34439.stgit@localhost>
References: <20090304182342.27331.35004.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63462 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbZCDS0k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Mar 2009 13:26:40 -0500
In-Reply-To: <20090304182342.27331.35004.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Change the error to a warning.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/mach/pm.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/pm.h b/arch/arm/plat-omap/include/mach/pm.h
index 2a9c27a..37e2f0f 100644
--- a/arch/arm/plat-omap/include/mach/pm.h
+++ b/arch/arm/plat-omap/include/mach/pm.h
@@ -108,7 +108,7 @@
 	!defined(CONFIG_ARCH_OMAP15XX) && \
 	!defined(CONFIG_ARCH_OMAP16XX) && \
 	!defined(CONFIG_ARCH_OMAP24XX)
-#error "Power management for this processor not implemented yet"
+#warning "Power management for this processor not implemented yet"
 #endif
 
 #ifndef __ASSEMBLER__

