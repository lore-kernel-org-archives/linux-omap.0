From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap: fix Kconfig warning
Date: Mon, 8 Sep 2014 14:29:25 -0700
Message-ID: <20140908212924.GL3238@atomide.com>
References: <3763111.OttSKCMuxb@wuerfel>
 <20140908153400.GC3238@atomide.com>
 <2797284.2mFcuQ0Ias@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:42135 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754905AbaIHV3a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2014 17:29:30 -0400
Content-Disposition: inline
In-Reply-To: <2797284.2mFcuQ0Ias@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andreas Ruprecht <rupran@einserver.de>

* Arnd Bergmann <arnd@arndb.de> [140908 11:17]:
> On Monday 08 September 2014 08:34:00 Tony Lindgren wrote:
> > * Arnd Bergmann <arnd@arndb.de> [140908 08:01]:
> > > A small mistake during the recent Kconfig cleanup has led
> > > to a harmless warning for OMAP1:
> > > 
> > > warning: (ARCH_OMAP1) selects ARCH_OMAP which has unmet direct dependencies (ARCH_MULTI_V6 || ARCH_MULTI_V7)
> > > 
> > > We can easily avoid that by moving the ARCH_OMAP symbol outside of the
> > > OMAP2 submenu.
> > 
> > OK I made a similar patch, but I moved it into plat-omap/Kconfig
> > as it's also used by omap1. The regression was probably caused by
> > commit 21278aeafbfa (ARM: use menuconfig for sub-arch menus).
> > 
> > If that works for you, I'll verify the regression causing commit
> > and post it with a description.
> 
> Yes, sounds good. Your version is better than mind.

OK here's the patch again with breaking commit and reported by.

Regards,

Tony


8< -------------
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 8 Sep 2014 07:52:11 -0700
Subject: [PATCH] ARM: OMAP: Fix Kconfig warning for omap1

Commit 21278aeafbfa ("ARM: use menuconfig for sub-arch menus") improved
the sub-arch menus, but accidentally caused new warnings for omap1.
This was because the commit added a menu entry around config ARCH_OMAP
bool entry where the menu had depends on ARCH_MULTI_V6 || ARCH_MULTI_V7.

As ARCH_OMAP is shared between omap1 and omap2plus, let's fix the
issue by defining ARCH_OMAP in the shared plat-omap/Kconfig.

Fixes: 21278aeafbfa ("ARM: use menuconfig for sub-arch menus")
Reported-by: Andreas Ruprecht <rupran@einserver.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Tony Lindgren <tony@atomide.com>

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
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 02fc10d..d055db3 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -1,3 +1,6 @@
+config ARCH_OMAP
+	bool
+
 if ARCH_OMAP
 
 menu "TI OMAP Common Features"
