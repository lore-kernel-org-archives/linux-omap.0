From: Mike Turquette <mturquette@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: clockdomain: disabling unused clks
Date: Thu, 8 Nov 2012 17:17:38 -0800
Message-ID: <20121109011738.17381.88199@nucleus>
References: <alpine.DEB.2.00.1211081800210.20703@utopia.booyaka.com>
 <1352417516-15213-1-git-send-email-mturquette@ti.com>
 <alpine.DEB.2.00.1211090052100.20703@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54960 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757368Ab2KIBR5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Nov 2012 20:17:57 -0500
In-Reply-To: <alpine.DEB.2.00.1211090052100.20703@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Quoting Paul Walmsley (2012-11-08 16:58:21)
> On Thu, 8 Nov 2012, Mike Turquette wrote:
> 
> > The OMAP port to the common clk framework[1] resulted in spurious WARNs
> > while disable unused clocks.  This is due to _clkdm_clk_hwmod_disable
> > catching clkdm->usecount's with a value of zero.  Even less desirable it
> > would not allow the clkdm_clk_disable function pointer to get called due
> > to an early return of -ERANGE.
> > 
> > This patch adds a check for such a corner case by skipping the WARN and
> > early return in the event that clkdm->usecount and clk->enable_usecount
> > are both zero.  Presumably this could only happen during the check for
> > unused clocks at boot-time.
> > 
> > [1] http://article.gmane.org/gmane.linux.ports.arm.omap/88824
> > 
> > Signed-off-by: Mike Turquette <mturquette@ti.com>
> 
> I don't think this is going to work, as it currently stands.  The code 
> will just bypass the warning and the error return.  The clockdomain 
> usecount still will be decremented, which is going to cause problems since 
> the usecount will be inaccurate.
> 

You're right.  In my rush I glossed over the clkdm decrement part.  In
light of the suspend/resume issues I'm not sure this approach is really
valid.  I think getting to the bottom of those issues will give the
final word.

Regards,
Mike

> 
> - Paul
