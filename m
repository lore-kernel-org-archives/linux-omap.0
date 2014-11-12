From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mtd: nand: omap: Fix NAND enumeration on 3430 LDP
Date: Wed, 12 Nov 2014 10:02:54 -0800
Message-ID: <20141112180253.GJ26481@atomide.com>
References: <1415185258-11747-1-git-send-email-rogerq@ti.com>
 <20141106180333.GZ31454@atomide.com>
 <545C9267.7060301@ti.com>
 <545C97AB.4040402@ti.com>
 <20141107224832.GG31454@atomide.com>
 <545FC08D.8000008@pek-sem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:35411 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbaKLSDg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2014 13:03:36 -0500
Content-Disposition: inline
In-Reply-To: <545FC08D.8000008@pek-sem.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: pekon <pekon@pek-sem.com>
Cc: Roger Quadros <rogerq@ti.com>, computersforpeace@gmail.com, dwmw2@infradead.org, ezequiel@vanguardiasur.com.ar, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, stable@vger.kernel.org

* pekon <pekon@pek-sem.com> [141109 11:31]:
> On Saturday 08 November 2014 04:18 AM, Tony Lindgren wrote:
> >
> >Right. I doubt anybody has bch8 rootfs on LDP.. And considering u-boot
> >must be ham1 to boot at all, that's what we should change for the
> >devices that do not have not standardized on bch8.
> >
> My view on this is slightly different:
> - Lately, everyone seems to have migrated to BCH8.
> 
> - Also HAM1 does not have strength to fix bitflips in aging NAND. So if
> someone already has OMAP3-LDP deployed on field then its NAND would have
> already aged to such an extend that HAM1 may not be sufficient.

OK so it makes sense to keep it as BCH8 then. Would be nice to get
the writing u-boot from kernel issue fixed somehow though as people
are hitting that for sure.
 
> My question is..
> Moving back to HAM1 should be decided based on statistics rather than rule
> of breaking backward compatibility. So please review:
> (1) How many user of OMAP3-Zoom or other old boards complaining about using
> BCH8 in mainline kernel? OR

0

> (2) How many users of OMAP3 legacy boards are migrating to newer kernel?

Quite a few for sure, but are probably also using rootfs on MMC instead.
 
> At-least I have not, rather most of the OMAP3 users I interacted via TI's
> E2E forum wanted to migrate to BCH8 or even BCH16, as HAM1 was not
> sufficient for their usage.
> 
> So whatever you decide on this topic, please be cautious that you don't
> re-invent work for yourself, as I did. It took me lot of time and testing
> effort on multiple boards to migrate HAM1 to BCH8, And add BCH16 for newer
> devices.

Right no objections to using BCH8 for rootfs, except it stopped working
over past year or so.

And it seems the settings should be partition specific because of u-boot
requiring HAM1.

Regards,

Tony
