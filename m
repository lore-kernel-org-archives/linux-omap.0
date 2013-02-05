From: Tony Lindgren <tony@atomide.com>
Subject: Re: Latest additional build warnings
Date: Tue, 5 Feb 2013 09:51:26 -0800
Message-ID: <20130205175126.GH25185@atomide.com>
References: <20130205142218.GB17833@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:34473 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754018Ab3BERvd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Feb 2013 12:51:33 -0500
Content-Disposition: inline
In-Reply-To: <20130205142218.GB17833@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, arm@kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [130205 06:25]:
> arch/arm/mach-omap2/hwspinlock.c:60:1: warning: data definition has no type or storage class
> arch/arm/mach-omap2/hwspinlock.c:60:1: warning: type defaults to 'int' in declaration of 'omap_postcore_initcall'
> arch/arm/mach-omap2/hwspinlock.c:60:1: warning: parameter names (without types) in function declaration
> arch/arm/mach-omap2/hwspinlock.c:31:122: warning: 'hwspinlocks_init' defined but not used

Thanks looks like I missed that one somehow. Here's a fix for
it.

Arnd & Olof, care to apply this directly into the arm-soc multiplatform
branch?

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Tue, 5 Feb 2013 09:48:08 -0800
Subject: [PATCH] ARM: OMAP2+: Fix warning for hwspinlock omap_postcore_initcall

Commit 816a65ef4 (ARM: OMAP2+: Limit omap initcalls to omap only on
multiplatform kernels) fixed up things for multiplatform booting
but failed to include soc.h causing a new warning:

arch/arm/mach-omap2/hwspinlock.c:60:1: warning: data definition has no type or storage class
arch/arm/mach-omap2/hwspinlock.c:60:1: warning: type defaults to 'int' in declaration of 'omap_postcore_initcall'
arch/arm/mach-omap2/hwspinlock.c:60:1: warning: parameter names (without types) in function declaration
arch/arm/mach-omap2/hwspinlock.c:31:122: warning: 'hwspinlocks_init' defined but not used

Reported-by: Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/hwspinlock.c b/arch/arm/mach-omap2/hwspinlock.c
index ce1b5b6..bcb357e 100644
--- a/arch/arm/mach-omap2/hwspinlock.c
+++ b/arch/arm/mach-omap2/hwspinlock.c
@@ -21,6 +21,7 @@
 #include <linux/err.h>
 #include <linux/hwspinlock.h>
 
+#include "soc.h"
 #include "omap_hwmod.h"
 #include "omap_device.h"
 
