From: Tony Lindgren <tony@atomide.com>
Subject: Re: Latest additional build warnings
Date: Sat, 9 Feb 2013 19:22:34 -0800
Message-ID: <20130210032234.GE4801@atomide.com>
References: <20130205142218.GB17833@n2100.arm.linux.org.uk>
 <20130209114918.GJ17852@n2100.arm.linux.org.uk>
 <20130210030032.GC4801@atomide.com>
 <CAOesGMgvEVsB7OWs43EWjgsR8af2_RZS9Dod3PURu6Tvdi4QJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:31068 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755368Ab3BJDWj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Feb 2013 22:22:39 -0500
Content-Disposition: inline
In-Reply-To: <CAOesGMgvEVsB7OWs43EWjgsR8af2_RZS9Dod3PURu6Tvdi4QJw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, arm@kernel.org, linux-arm-kernel@lists.infradead.org

* Olof Johansson <olof@lixom.net> [130209 19:08]:
> On Sat, Feb 9, 2013 at 7:00 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [130209 03:53]:
> >> On Tue, Feb 05, 2013 at 02:22:18PM +0000, Russell King - ARM Linux wrote:
> >> > arch/arm/mach-omap2/hwspinlock.c:60:1: warning: data definition has no type or storage class
> >> > arch/arm/mach-omap2/hwspinlock.c:60:1: warning: type defaults to 'int' in declaration of 'omap_postcore_initcall'
> >> > arch/arm/mach-omap2/hwspinlock.c:60:1: warning: parameter names (without types) in function declaration
> >> > arch/arm/mach-omap2/hwspinlock.c:31:122: warning: 'hwspinlocks_init' defined but not used
> >>
> >> I'm still seeing the above in the build of Friday's merge.  I'm also
> >> seeing additional warnings in the randconfig similar to the above for
> >> arch/arm/mach-omap2/omap-iommu.c.
> >
> > Thanks for letting me know about the omap-iommu.c one. Looks like
> > there's also one patch for drm.c.
> >
> > Olof, if you did not yet apply the hwspinlock.c warning fix, I'll
> > just do a branch with all three of them for you.
> 
> I haven't (must have missed it), so please just send a branch.

OK will do. Probably you started fixing up the bad Reported-by
line in my patch and then got disrupted :)

Found one more after some grepping, after the following patch they
should be all fixed up. Pull request coming shortly.

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Sat, 9 Feb 2013 19:20:57 -0800
Subject: [PATCH] ARCH: OMAP2+: Make sure files with omap initcalls include soc.h

Looks like there are few more places that I missed that can cause
compiler warnings. After grepping for omap initcall, all files
needing soc.h should now have it.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/omap-iommu.c
+++ b/arch/arm/mach-omap2/omap-iommu.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 
 #include <linux/platform_data/iommu-omap.h>
+#include "soc.h"
 #include "omap_hwmod.h"
 #include "omap_device.h"
 
--- a/arch/arm/mach-omap2/smartreflex-class3.c
+++ b/arch/arm/mach-omap2/smartreflex-class3.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/power/smartreflex.h>
+#include "soc.h"
 #include "voltage.h"
 
 static int sr_class3_enable(struct omap_sr *sr)
