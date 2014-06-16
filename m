From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap: rework platform selection
Date: Mon, 16 Jun 2014 07:17:13 -0700
Message-ID: <20140616141712.GL17845@atomide.com>
References: <5701099.0P1SIXsHc1@wuerfel>
 <20140616110042.GD17845@atomide.com>
 <7892694.KrnV5uCBX6@wuerfel>
 <20140616112610.GE17845@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:13482 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753189AbaFPORU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jun 2014 10:17:20 -0400
Content-Disposition: inline
In-Reply-To: <20140616112610.GE17845@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, rob.herring@linaro.org, linux-omap@vger.kernel.org, arm@kernel.org

* Tony Lindgren <tony@atomide.com> [140616 04:31]:
> * Arnd Bergmann <arnd@arndb.de> [140616 04:18]:
> > 
> > Let's see if others have similar opinions Rob's patch as a whole.
> > I'd still like to keep all the parts aside from the OMAP change
> > and just back out the change that caused the problems.
> > 
> > Does that seem reasonable to you?
> 
> Yes makes sense to me if others don't have similar issues. I guess
> it should be possible to verify that by diffing the generated
> .config files compared to the old ones.

If you update Rob's patch and undo the omap2+ changes, you might
want to fold in something like the following to hide the omap
options behind a menu.

So far I have not come up with no great ideas on fixing this
properly short of requiring all omap .config files to add
CONFIG_ARCH_OMAP=y manually. Anybody got good ideas for that?

Regards,

Tony

--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -1,3 +1,5 @@
+menu "TI OMAP/AM/DM/DRA Family"
+
 config ARCH_OMAP
 	bool
 
@@ -342,3 +344,5 @@ config OMAP4_ERRATA_I688
 endmenu
 
 endif
+
+endmenu
