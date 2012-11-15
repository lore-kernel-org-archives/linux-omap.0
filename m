From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 1/5] omap non critical fixes for v3.8 merge window
Date: Thu, 15 Nov 2012 09:35:59 -0800
Message-ID: <20121115173559.GJ6801@atomide.com>
References: <pull-1352948204-277861>
 <201211151651.59049.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:21509 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1768446Ab2KORgE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Nov 2012 12:36:04 -0500
Content-Disposition: inline
In-Reply-To: <201211151651.59049.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [121115 08:54]:
> On Thursday 15 November 2012, Tony Lindgren wrote:
> > The following changes since commit 3d70f8c617a436c7146ecb81df2265b4626dfe89:
> > 
> >   Linux 3.7-rc4 (2012-11-04 11:07:39 -0800)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/fixes-non-critical-v4-signed
> 
> Pulled all five. Please have a look to make sure everything you need is
> there now and still works.

Thanks! Diffs fine against what I have in omap-for-v3.8/tmp-merge
except for the following bit that breaks compile for omap2plus_defconfig,
maybe apply it directly to one of your branches?

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Thu, 15 Nov 2012 09:22:34 -0800
Subject: [PATCH] ARM: OMAP2+: Fix build for board-generic after a merge conflict

Commit 187e3e06 (ARM: OMAP2+: board files: use SoC-specific system
restart functions) changed to use SoC specific restart functions to
simplify the PRCM code. The changes done to board-generic.c in commit
7dd9d502 (ARM: OMAP3: Add generic machine descriptor for boards with
OMAP3 GP devices) need to be updated accordingly.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -122,7 +122,7 @@ DT_MACHINE_START(OMAP3_GP_DT, "Generic OMAP3-GP (Flattened Device Tree)")
 	.init_machine	= omap_generic_init,
 	.timer		= &omap3_secure_timer,
 	.dt_compat	= omap3_gp_boards_compat,
-	.restart	= omap_prcm_restart,
+	.restart	= omap3xxx_restart,
 MACHINE_END
 #endif
 
