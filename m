From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] ARM: dts: Add cppi41 support for dm816x MUSB
Date: Tue, 17 Mar 2015 18:18:37 -0700
Message-ID: <20150318011836.GK31346@atomide.com>
References: <1426637961-4197-1-git-send-email-tony@atomide.com>
 <1426637961-4197-4-git-send-email-tony@atomide.com>
 <20150318003121.GA12911@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:38229 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753211AbbCRBXW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Mar 2015 21:23:22 -0400
Content-Disposition: inline
In-Reply-To: <20150318003121.GA12911@saruman.tx.rr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bin Liu <binmlist@gmail.com>, Brian Hutchinson <b.hutchman@gmail.com>, Matthijs van Duin <matthijsvanduin@gmail.com>

* Felipe Balbi <balbi@ti.com> [150317 17:32]:
> Hi,
> 
> On Tue, Mar 17, 2015 at 05:19:20PM -0700, Tony Lindgren wrote:
> > Looks like we have cppi41 on dm816x just like on am335x.
> > 
> > Cc: Bin Liu <binmlist@gmail.com>
> > Cc: Brian Hutchinson <b.hutchman@gmail.com>
> > Cc: Felipe Balbi <balbi@ti.com>
> > Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Any logs available ? Any throughput improvements with DMA ?

So far I only logged with the debug option on. I can do some
test runs with your for-next branch to a USB mass storage device
if you prefer that, or got some other test in mind?

Regards,

Tony
