From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 00/26] Move OMAP2+ over to common clk framework
Date: Fri, 9 Nov 2012 21:12:24 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1211092058540.20703@utopia.booyaka.com>
References: <1352337181-29427-1-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:60131 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755617Ab2KIVMZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Nov 2012 16:12:25 -0500
In-Reply-To: <1352337181-29427-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@ti.com>, rnayak@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Mike Turquette <mturquette@linaro.org>


Hi

With the fixes that have been posted, this is testing clean here.  Mike 
and Rajendra have put in months of work on these patches under 
often-difficult conditions, and it's really great that we've arrived at 
this point with zero obvious remaining regressions from the current code. 

The branch has been posted for the time being at 
git://git.pwsan.com/linux-2.6 in the branch 'common_clk_devel_3.8', with 
the head at commit 376676b429cb6dc95c39cdac82b2be816ea22893, in case 
anyone else wants to try it.  

Anyway, barring any further regressions that haven't reared their ugly 
heads yet, and barring anything truly horrible in the code or data that 
I've missed so far, will take this branch from here.  It still needs some 
more work before it's ready to merge.  The clockdomain usecounting fix 
patch needs to be split and moved earlier in the patch stack so 'git 
bisect' doesn't result in warnings and broken PM on OMAP3.  And it all is 
going to be rebased on the second set of PRCM cleanup patches at commit 
b99db36cdf37decb1b5575c5f293d170cbbc53d6, which I'm assuming Tony is 
planning to pull.  Then will plan to send that pull request to Tony.

Then after that, if there's still time to merge some of the clock changes 
that have showed up on the lists for 3.8, those will get stacked onto a 
topic branch based on the branch that's sent to Tony.


- Paul
