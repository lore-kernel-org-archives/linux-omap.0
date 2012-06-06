From: Tony Lindgren <tony@atomide.com>
Subject: Re: Please help! AM35xx mm/slab.c BUG
Date: Wed, 6 Jun 2012 01:41:24 -0700
Message-ID: <20120606084123.GU12766@atomide.com>
References: <1338878255.13133.YahooMailNeo@web125205.mail.ne1.yahoo.com>
 <20120605070853.GE12766@atomide.com>
 <1338913755.88514.YahooMailNeo@web125201.mail.ne1.yahoo.com>
 <1338963298.87083.YahooMailNeo@web125204.mail.ne1.yahoo.com>
 <CAMQu2gw2bGNwot_xVPdAsYjZChzzNib2USg8Ci+W5aLbenPnqA@mail.gmail.com>
 <20120606071024.GP12766@atomide.com>
 <1338969083.99043.YahooMailNeo@web125201.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:28398 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754983Ab2FFIl1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jun 2012 04:41:27 -0400
Content-Disposition: inline
In-Reply-To: <1338969083.99043.YahooMailNeo@web125201.mail.ne1.yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: CF Adad <cfadad@rocketmail.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* CF Adad <cfadad@rocketmail.com> [120606 00:55]:
> 
> Do you folks know of a good reference for properly calculating these GPMC settings?

In theory you just need to know the timings of connected components,
then check which ones depend on cycles and which ones depend on time.

Also take into account latencies added by level shifters if you have those.
Paul Walmsley noticed a few years ago that those affected the smsc911x
timings if not accounted for.

Probably the closest thing for reference we have are the various
arch/arm/mach-omap2/gpmc*.c files. Then of course verifying the timings
using a scope might help a lot.

Regards,

Tony
