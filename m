From: Mike Turquette <mturquette@ti.com>
Subject: Re: [PATCH v2 00/26] Move OMAP2+ over to common clk framework
Date: Fri, 9 Nov 2012 14:18:13 -0800
Message-ID: <20121109221813.17381.31431@nucleus>
References: <1352337181-29427-1-git-send-email-mturquette@ti.com>
 <alpine.DEB.2.00.1211092058540.20703@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52136 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756661Ab2KIWSg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Nov 2012 17:18:36 -0500
In-Reply-To: <alpine.DEB.2.00.1211092058540.20703@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, rnayak@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

Quoting Paul Walmsley (2012-11-09 13:12:24)
> Hi
> 
> With the fixes that have been posted, this is testing clean here.  Mike 
> and Rajendra have put in months of work on these patches under 
> often-difficult conditions, and it's really great that we've arrived at 
> this point with zero obvious remaining regressions from the current code. 
> 
> The branch has been posted for the time being at 
> git://git.pwsan.com/linux-2.6 in the branch 'common_clk_devel_3.8', with 
> the head at commit 376676b429cb6dc95c39cdac82b2be816ea22893, in case 
> anyone else wants to try it.  
> 

Thanks a lot Paul.  You put in a lot of work on this series as well and
that should not go unnoticed.  I'm truly happy to see this series come
together.

> Anyway, barring any further regressions that haven't reared their ugly 
> heads yet, and barring anything truly horrible in the code or data that 
> I've missed so far, will take this branch from here.  It still needs some 
> more work before it's ready to merge.  The clockdomain usecounting fix 
> patch needs to be split and moved earlier in the patch stack so 'git 
> bisect' doesn't result in warnings and broken PM on OMAP3.  And it all is 
> going to be rebased on the second set of PRCM cleanup patches at commit 
> b99db36cdf37decb1b5575c5f293d170cbbc53d6, which I'm assuming Tony is 
> planning to pull.  Then will plan to send that pull request to Tony.
> 

I just did some more testing on your branch and everything looks great.
The only thing that caught my eye was using the clk-private.h header in
the top-most patch.  The following patch will help me sleep better at
night:

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index ba4d14c..3848735 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -22,7 +22,7 @@
 #include <linux/clk.h>
 #include <linux/limits.h>
 #include <linux/err.h>
-#include <linux/clk-private.h>
+#include <linux/clk-provider.h>
 
 #include <linux/io.h>
 


Tested on 3530 ES3.0 Beagleboard, boot + suspend/resume.

Regards,
Mike

> Then after that, if there's still time to merge some of the clock changes 
> that have showed up on the lists for 3.8, those will get stacked onto a 
> topic branch based on the branch that's sent to Tony.
> 
> 
> - Paul
