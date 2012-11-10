From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Prevent redefinition errors for soc.h
Date: Fri, 9 Nov 2012 16:21:42 -0800
Message-ID: <20121110002142.GC6801@atomide.com>
References: <1352477961-7634-1-git-send-email-jon-hunter@ti.com>
 <20121109162259.GO6801@atomide.com>
 <509D2F77.6090702@ti.com>
 <20121109211052.GS6801@atomide.com>
 <509D94F7.8010707@ti.com>
 <20121109235006.GB6801@atomide.com>
 <509D9876.9040301@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:42345 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751659Ab2KJAVp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Nov 2012 19:21:45 -0500
Content-Disposition: inline
In-Reply-To: <509D9876.9040301@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

* Jon Hunter <jon-hunter@ti.com> [121109 15:59]:
> 
> Sorry, I meant in the fixes series I have posted for dmtimer, I am
> adding a new function called omap_dm_timer_populate_errata() that is
> using cpu_is_xxxx() [1]. I had done this a while back, but now I see
> that we want to get away from doing that right?

Yes. Looks like everything we have under plat-omap can be moved
to live under drivers eventually, so let's not use cpu_is_omap
there either. For legacy boot, you can use pdata->timer_capability
for passing that?
 
> I was planning on sending you a pull request for that series on Monday
> but now I am wondering if I should fix this now or later. I was hoping
> this series would make 3.8.

Yeah, sounds like that should be fixed though as we still have a bit
of time early next week.

Regards,

Tony
 
> [1] http://marc.info/?l=linux-omap&m=135249008128365&w=2
