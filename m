From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.9
Date: Tue, 14 May 2013 21:19:12 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1305142116001.4368@utopia.booyaka.com>
References: <alpine.DEB.2.00.1305081933270.19747@utopia.booyaka.com> <20130514211328.GC5600@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:35272 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757626Ab3ENVTN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 May 2013 17:19:13 -0400
In-Reply-To: <20130514211328.GC5600@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>

On Tue, 14 May 2013, Tony Lindgren wrote:

> Hi,
> 
> * Paul Walmsley <paul@pwsan.com> [130508 12:45]:
> > 
> > PM off, dynamic idle:
> >     FAIL ( 2/ 5): 4430es2panda, 4460pandaes
> >     Pass ( 3/ 5): 3530es3beagle, 3730beaglexm, 37xxevm
> 
> Looking at your pm logs, 3730beaglexm won't hit off-idle.
> I've pasted the relevant lines from your logs below.
> 
> Is this a known issue?

Yes, the Beagle XM in my testbed is a 3630ES1.0.  From the PM logs:

[   63.154418] omap3_pm_off_mode_enable: Core OFF disabled due to errata 
i583

I should probably clarify how this is reported in the test results.


- Paul
