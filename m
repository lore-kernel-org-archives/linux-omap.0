From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2: Fix a cpu type check problem.
Date: Wed, 11 Aug 2010 13:27:18 +0300
Message-ID: <20100811102718.GF26637@atomide.com>
References: <1281443797-7062-1-git-send-email-stanley.miao@windriver.com>
 <4C6162F4.7030500@compulab.co.il>
 <20100811092005.GB26637@atomide.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E80ACA1F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53507 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714Ab0HKK10 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 06:27:26 -0400
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E80ACA1F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, "Stanley.Miao" <stanley.miao@windriver.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Premi, Sanjeev <premi@ti.com> [100811 12:45]:
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org 
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tony Lindgren
> > Sent: Wednesday, August 11, 2010 2:50 PM
> > To: Igor Grinberg
> > Cc: Stanley.Miao; linux-omap@vger.kernel.org
> > Subject: Re: [PATCH] OMAP2: Fix a cpu type check problem.
> > 
> > * Igor Grinberg <grinberg@compulab.co.il> [100810 17:25]:
> > > On 08/10/10 15:36, Stanley.Miao wrote:
> > > > cpu_is_omap3517() and cpu_is_omap3505() are the subgroups 
> > of cpu_is_omap34xx(),
> > > > so we should check cpu_is_omap3517() and 
> > cpu_is_omap3505() first, then check
> > > > cpu_is_omap34xx().
> > > >
> > > > Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
> > > >   
> > > 
> > > Tested-by: Igor Grinberg <grinberg@compulab.co.il>
> > > 
> > > I've just ran into this yesterday evening.
> > > Having a patch for this on the next day made me :)
> > > Tested on AM3517.
> > 
> > Can you please describe what breaks so we can merge this as a fix?
> > 
> 
> cpu_is_34xx() will be true for all OMAP3 based devices including
> AM3517. So, if we want to perform operations specific to AM3517, the
> check for AM3517 should be done first else you match for 34xx would
> return true; and you wouldn't go far enough to check for am3517.

Understood, but we need some concrete error like "otherwise booting
xyz board fails with non-working USB" or similar.

Tony
