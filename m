From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap: fix Kconfig warning
Date: Mon, 8 Sep 2014 08:34:00 -0700
Message-ID: <20140908153400.GC3238@atomide.com>
References: <3763111.OttSKCMuxb@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:17198 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206AbaIHPeG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2014 11:34:06 -0400
Content-Disposition: inline
In-Reply-To: <3763111.OttSKCMuxb@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [140908 08:01]:
> A small mistake during the recent Kconfig cleanup has led
> to a harmless warning for OMAP1:
> 
> warning: (ARCH_OMAP1) selects ARCH_OMAP which has unmet direct dependencies (ARCH_MULTI_V6 || ARCH_MULTI_V7)
> 
> We can easily avoid that by moving the ARCH_OMAP symbol outside of the
> OMAP2 submenu.

OK I made a similar patch, but I moved it into plat-omap/Kconfig
as it's also used by omap1. The regression was probably caused by
commit 21278aeafbfa (ARM: use menuconfig for sub-arch menus).

If that works for you, I'll verify the regression causing commit
and post it with a description.

Regards,

Tony

--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -1,9 +1,6 @@
 menu "TI OMAP/AM/DM/DRA Family"
 	depends on ARCH_MULTI_V6 || ARCH_MULTI_V7
 
-config ARCH_OMAP
-	bool
-
 config ARCH_OMAP2
 	bool "TI OMAP2"
 	depends on ARCH_MULTI_V6
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -1,3 +1,6 @@
+config ARCH_OMAP
+	bool
+
 if ARCH_OMAP
 
 menu "TI OMAP Common Features"
