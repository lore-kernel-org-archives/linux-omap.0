From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/7] mfd: twl4030-power: Fix hang on reboot if sleep
 configuration was loaded earlier
Date: Tue, 20 May 2014 10:48:27 -0700
Message-ID: <20140520174827.GF27830@atomide.com>
References: <1400031250-29542-1-git-send-email-tony@atomide.com>
 <1400031250-29542-2-git-send-email-tony@atomide.com>
 <20140520150119.GW24991@lee--X1>
 <20140520150748.GD27830@atomide.com>
 <20140520173705.GA1458@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:36066 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753946AbaETRse (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 May 2014 13:48:34 -0400
Content-Disposition: inline
In-Reply-To: <20140520173705.GA1458@lee--X1>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>

* Lee Jones <lee.jones@linaro.org> [140520 10:38]:
> > > > Looks like we can still hit the issue of wrong load order of
> > > > twl4030 configuration. If we have a sleep configuration loaded,
> > > > and do a warm reset, the device can hang while initializing the
> > > > wakeup12 sequence. We do have a warning message about wrong order
> > > > of twl4030 configuration, but in this case it does not help as
> > > > the sleep configuration was loaded during the previous boot and
> > > > the state of twl4030 is maintained throughout the warm reset.
> > > > 
> > > > Fix the issue by clearing any existing sleep configuration
> > > > before we load the warm reset configuration.
> > > > 
> > > > Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > > > ---
> > > >  drivers/mfd/twl4030-power.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > 
> > > Can't vouch for the semantics of the patch, but the code looks good.
> > > 
> > >   Acked-by: Lee Jones <lee.jones@linaro.org>
> > > 
> > > Can I just apply this, or would you like Peter to review it first?
> > 
> > As far as I'm concerned you can go ahead an apply, it's been
> > floating on the list for a while and Peter is probably busy
> > with other things.
> 
> No problem.  Just a couple of things for you to look at in the other
> patches, then we can go ahead and apply for v3.16.

OK thanks yeah saw those. Will fix them up and test today. Then
maybe you can apply them to the immutable branch we set earlier
or I can send you a pull request against that branch whichever
you prefer.

Regards,

Tony
