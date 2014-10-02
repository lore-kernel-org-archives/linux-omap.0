From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.17-rc7
Date: Thu, 2 Oct 2014 15:10:25 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1410021447590.31530@utopia.booyaka.com>
References: <alpine.DEB.2.02.1409291709020.7233@utopia.booyaka.com> <20140929172049.GD3122@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:56866 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684AbaJBPK0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Oct 2014 11:10:26 -0400
In-Reply-To: <20140929172049.GD3122@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

Hi Tony,

On Mon, 29 Sep 2014, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [140929 10:14]:
> >
> > PM: chip off except CORE via suspend:
> >     Pass ( 1/ 1): 3730beaglexm
> > 
> > PM: chip off except CORE via dynamic idle:
> >     Pass ( 1/ 1): 3730beaglexm
> 
> Most likely the two tests above should now also work also for 37xxevm,
> 3530es3beagle and 3530es31beagle in case you want to enable that.

I think this might be an issue of my own inability to communicate clearly 
what's being tested here and why :-)

That "chip off except CORE" PM validation test is only needed due to the 
3630/37xx ES1.0 errata that forces us to disable CORE off-mode on that 
revision:

----------
echo 1 > /debug/pm_debug/enable_off_mode
[   60.351837] omap3_pm_off_mode_enable: Core OFF disabled due to errata i583
----------

(from 
http://www.pwsan.com/omap/testlogs/test_v3.17-rc6/20140921213558/pm/3730beaglexm/3730beaglexm_log.txt)

If we were to enable that test for the other four OMAP3 boards, they would 
probably all show up as failing, since they are all able to enter core-off 
mode successfully :-)

Maybe you have some ideas for how this can be communicated better in the 
test results?  One thing that would probably help is if the board was 
renamed to "3730es10beaglexm" or something like that.  Also maybe 
mentioning the fact that the test is only needed due to errata, like:

-----------
PM: chip off (except CORE, due to errata) via dynamic idle:
    Pass ( 1/ 1): 3730es10beaglexm
-----------

At some point, will probably also generate an HTML version of the summary, 
where the test name and board names can link to some explanatory 
information about what is being tested, and why.

Anyway, any thoughts are welcome.

> > PM: chip off via suspend:
> >     Pass ( 4/ 4): 37xxevm, 3530es3beagle, 3530es31beagle,
> > 		  3730es12beaglexm
> > 
> > PM: chip off via dynamic idle:
> >     Pass ( 4/ 4): 37xxevm, 3530es3beagle, 3530es31beagle,
> > 		  3730es12beaglexm
> 
> Since looks like these are working finally :)

Thanks largely to your hard work!  Hooray!


- Paul
