From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] mfd: Immutable branch between MFD and OMAP, due for
 v3.16
Date: Mon, 16 Jun 2014 03:36:16 -0700
Message-ID: <20140616103615.GB17845@atomide.com>
References: <1401214140-9828-1-git-send-email-tony@atomide.com>
 <20140528071313.GH4227@lee--X1>
 <20140528180607.GB4707@atomide.com>
 <20140602163841.GC11004@atomide.com>
 <20140603080632.GC3060@lee--X1>
 <20140612054348.GC17845@atomide.com>
 <20140612074705.GB11421@lee--X1>
 <20140612080030.GD17845@atomide.com>
 <20140612083357.GB14323@lee--X1>
 <20140616101743.GO14323@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:42449 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754997AbaFPKgS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jun 2014 06:36:18 -0400
Content-Disposition: inline
In-Reply-To: <20140616101743.GO14323@lee--X1>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Lee Jones <lee.jones@linaro.org> [140616 03:19]:
> > > > > Still not seeing this branch being merged..
> > > > 
> > > > Oh crap, I see what's happened and it's completely my fault.
> > > > 
> > > > If you read the final merge commit carefully:
> > > > 
> > > > 28fee3f: ("Merge branches 'ib-from-asoc-3.16', 'ib-from-pm-3.16',
> > > > 'ib-from-regulator-3.16', 'ib-mfd-gpio-3.16' and
> > > > 'ib-mfd-mmc-memstick-3.16', tags 'ib-mfd-extcon-3.16',
> > > > 'ib-mfd-omap-3.16' and 'ib-mfd-regulator-3.16' into
> > > > ibs-for-mfd-merged")
> > > > 
> > > > I appear to have a _branch_ AND a _tag_ called ib-mfd-omap-3.16 and it
> > > > looks like Git has taken the tag as a preference. heads/ib-mfd-omap-3.16
> > > > is actually at tag/ib-mfd-omap-3.16-1 (notice the appended '-1'),
> > > > which contains your most recent patches.  Since I created the MFD-OMAP
> > > > shared branch I have changed the naming convention to avoid this sort
> > > > of ambiguity.  I'll send a second MFD pull-request to Linus today.
> > > 
> > > Heh OK yeah I've hit that also at some point :)
> > >  
> > > > Sorry Tony.
> > > 
> > > No problem, good to hear you got it figured out.
> > 
> > Pull-request sent.  Hopefully it's sorted now.
> 
> bae14e7a2dcb726476b5020396923a24ccc4c40b

Yes saw that thanks, omap PM tests are now working for
me with v3.16-rc1.

Regards,

Tony
