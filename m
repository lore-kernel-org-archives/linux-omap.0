From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2 00/18] I2C: OMAP: Fixes and removal of cpu_... from
 driver
Date: Mon, 14 Mar 2011 10:42:09 -0700
Message-ID: <20110314174209.GC7258@atomide.com>
References: <20110308105934.23531.83540.stgit@otae.warmcat.com>
 <4D76A164.2060801@ti.com>
 <20110308233820.GJ26463@atomide.com>
 <4D778873.4070308@ti.com>
 <20110309191115.GM26463@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55737 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348Ab1CNRm1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Mar 2011 13:42:27 -0400
Content-Disposition: inline
In-Reply-To: <20110309191115.GM26463@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Green <andy@warmcat.com>, Ben Dooks <ben-linux@fluff.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>

Hi Ben & Andy,

* Tony Lindgren <tony@atomide.com> [110309 11:09]:
> * Cousson, Benoit <b-cousson@ti.com> [110309 06:00]:
> > Hi Tony,
> > 
> > On 3/9/2011 12:38 AM, Tony Lindgren wrote:
> > >* Cousson, Benoit<b-cousson@ti.com>  [110308 13:34]:
> > >>Hi Andy,
> > >>
> > >>Thanks for that really fast update. That looks pretty good at first
> > >>glance. I still have to review in details.
> > >
> > >Yes nice job!
> > >
> > >>And we need to find some volunteers for OMAP1&  2 testing.
> > >
> > >I gave it a quick try on osk5912, seems to work just fine.
> > >Will apply these for testing purposes to linux-omap tree while
> > >waiting for the minor fixes.
> > >
> > >Looks like Benoit should take the arch/arm/*omap*/*hwmod*
> > >patches, the rest should go throug Ben. So for all of them:
> > 
> > Paul and I already acked the hwmod data, but the whole series should
> > maybe go through Ben, because the hwmod files will need some defines
> > added in the i2c header file. So we cannot separate the hwmod*
> > patches from the driver files patches.
> 
> Unfortunately the hwmod patches depend on omap-for-linus branch..
> 
> Considering this, it's probably best that I queue the whole series
> assuming we get acks from Ben for the driver related changes.

After looking at this again, I've changed my mind.

It looks like this series can be rebased on v2.6.38-rc8
and should merge just fine with what we have queued in
omap-for-linus. I guess I forgot we already did the i2c-omap
hwmod conversion last merge window :)

Andy, please repost the related patches against v2.6.38-rc8 with
the acks posted earlier.

Then Ben, please feel free to queue it after you get the rebased
series. We've had this series applied for testing for a while.

Regards,

Tony
