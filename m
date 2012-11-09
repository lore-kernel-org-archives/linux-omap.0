From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: clockdomain: disabling unused clks
Date: Fri, 9 Nov 2012 19:52:21 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1211091951080.20703@utopia.booyaka.com>
References: <alpine.DEB.2.00.1211081800210.20703@utopia.booyaka.com> <1352417516-15213-1-git-send-email-mturquette@ti.com> <alpine.DEB.2.00.1211090052100.20703@utopia.booyaka.com> <20121109011738.17381.88199@nucleus> <alpine.DEB.2.00.1211091900250.20703@utopia.booyaka.com>
 <alpine.DEB.2.00.1211091906340.20703@utopia.booyaka.com> <20121109194023.17381.62227@nucleus>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:59789 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655Ab2KITwW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Nov 2012 14:52:22 -0500
In-Reply-To: <20121109194023.17381.62227@nucleus>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 9 Nov 2012, Mike Turquette wrote:

> But I'm OK with the below patch in the short term.  I just have one
> question: did you observe any PM regressions by skipping the clkdm
> programming?

It's still under test here but 3530ES3 Beagle passed the PM tests with it, 
with no obvious warnings.

- Paul
