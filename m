From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.16-rc4
Date: Thu, 31 Jul 2014 19:27:26 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1407311922350.1845@utopia.booyaka.com>
References: <alpine.DEB.2.02.1407251857480.5875@utopia.booyaka.com> <20140729064243.GF29045@atomide.com> <alpine.DEB.2.02.1407290810160.22957@utopia.booyaka.com> <20140729084930.GH29045@atomide.com> <alpine.DEB.2.02.1407291225070.13035@utopia.booyaka.com>
 <alpine.DEB.2.02.1407291256270.13035@utopia.booyaka.com> <20140729145312.GT29045@atomide.com> <alpine.DEB.2.02.1407291922370.13035@utopia.booyaka.com> <20140730053940.GX29045@atomide.com> <alpine.DEB.2.02.1407300725290.4477@utopia.booyaka.com>
 <20140731131107.GB29045@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:40496 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439AbaGaT11 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Jul 2014 15:27:27 -0400
In-Reply-To: <20140731131107.GB29045@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

On Thu, 31 Jul 2014, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [140730 00:55]:
> > On Tue, 29 Jul 2014, Tony Lindgren wrote:
> > 
> > > The following patch should fix the tests above for 3530es3beagle.
> > > Care to test and ack as I don't have one?
> > 
> > 3530es3beagle retention dynamic idle tests hang on next-20140729.  (Maybe 
> > other boards fail too - haven't tested any others).  
> 
> I just checked that today's linux next works for off-idle and
> wake-up events for at least 37xx evm.

I ran the full set of tests across all boards.  The only board that passed 
the dynamic idle testing on next-20140729 was the 3730beaglexm.

http://www.pwsan.com/omap/testlogs/next_20140729/20140730124836/README.txt

37xxevm hangs on the first suspend entry:

http://www.pwsan.com/omap/testlogs/next_20140729/20140730124836/pm/37xxevm/37xxevm_log.txt

If I find some extra time, I'll set up a bisection run.


- Paul
