From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/33] OMAPDSS: platform_enable/disable callback
 removal from panel drivers
Date: Wed, 17 Apr 2013 17:34:20 -0700
Message-ID: <20130418003419.GB10155@atomide.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
 <20130213164647.GF7144@atomide.com>
 <515C2058.8030402@ti.com>
 <20130403154645.GV10155@atomide.com>
 <516BC897.5020802@ti.com>
 <20130415212022.GP10155@atomide.com>
 <516CD17A.5050403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:21796 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934752Ab3DRAeW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Apr 2013 20:34:22 -0400
Content-Disposition: inline
In-Reply-To: <516CD17A.5050403@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [130415 21:25]:
> On 2013-04-16 00:20, Tony Lindgren wrote:
> 
> >> So, to recap, the common header changes are located in:
> >>
> >> git://gitorious.org/linux-omap-dss2/linux.git 3.10/0-dss-headers
> >>
> >> And the branch for linux-omap is:
> >>
> >> git://gitorious.org/linux-omap-dss2/linux.git 3.10-lo/board-cleanup
> >>
> >> After merging those, some displays won't start anymore until the omapdss
> >> changes are in, but things should still compile.
> > 
> > Sounds like it's best that you merge those branches via your
> > tree as the conflicts have been already resolved in linux next.
> 
> The dss changes are going through drm tree this time, as there are some
> drm dependencies also, and I've already sent the pull request for those.
> And when I asked Dave Airlie if he can merge the dss changes, I didn't
> talk about a big chunk of arch file changes getting included.

OK sorry I did not know that and was assuming you will be sending
a pull request to Linus.
 
> Also, the whole division to two independent branches was done only to
> make it possible for the arch changes to go through l-o tree.

Yup. That probably caused you to fix up few other things while doing
it though ;)
 
> There will probably be more these kind of changes in the future, so I
> think we should agree how to handle those and stick to the plan.
> Dividing the arch file changes to a separate branch is often quite
> laborious, and I'd rather not do that for nothing.

Thanks for doing all that. And yes, let's plan on always separating
driver changes from arch/arm changes to cut away the dependencies.

Just one request: Let's do branches like this early on before -rc6,
not what might be five days before the merge window potentially
opens..

I've pulled them into omap-for-v3.10/dss and will send a pull
request for Arnd and Olof.

Regards,

Tony
