From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP baseline test results for v3.9
Date: Tue, 14 May 2013 15:52:21 -0700
Message-ID: <20130514225221.GD5600@atomide.com>
References: <alpine.DEB.2.00.1305081933270.19747@utopia.booyaka.com>
 <20130514211328.GC5600@atomide.com>
 <alpine.DEB.2.00.1305142116001.4368@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:62330 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758431Ab3ENWwY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 May 2013 18:52:24 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1305142116001.4368@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>

* Paul Walmsley <paul@pwsan.com> [130514 14:24]:
> On Tue, 14 May 2013, Tony Lindgren wrote:
> 
> > Hi,
> > 
> > * Paul Walmsley <paul@pwsan.com> [130508 12:45]:
> > > 
> > > PM off, dynamic idle:
> > >     FAIL ( 2/ 5): 4430es2panda, 4460pandaes
> > >     Pass ( 3/ 5): 3530es3beagle, 3730beaglexm, 37xxevm
> > 
> > Looking at your pm logs, 3730beaglexm won't hit off-idle.
> > I've pasted the relevant lines from your logs below.
> > 
> > Is this a known issue?
> 
> Yes, the Beagle XM in my testbed is a 3630ES1.0.  From the PM logs:
> 
> [   63.154418] omap3_pm_off_mode_enable: Core OFF disabled due to errata 
> i583
> 
> I should probably clarify how this is reported in the test results.

Thanks that explains. BTW, the "PM off" naming might make some
people think that CONFIG_PM is not set :)

Regards,

Tony
