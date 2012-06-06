From: Tony Lindgren <tony@atomide.com>
Subject: Re: Please help! AM35xx mm/slab.c BUG
Date: Wed, 6 Jun 2012 00:10:25 -0700
Message-ID: <20120606071024.GP12766@atomide.com>
References: <1338878255.13133.YahooMailNeo@web125205.mail.ne1.yahoo.com>
 <20120605070853.GE12766@atomide.com>
 <1338913755.88514.YahooMailNeo@web125201.mail.ne1.yahoo.com>
 <1338963298.87083.YahooMailNeo@web125204.mail.ne1.yahoo.com>
 <CAMQu2gw2bGNwot_xVPdAsYjZChzzNib2USg8Ci+W5aLbenPnqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:39360 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754203Ab2FFHK2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jun 2012 03:10:28 -0400
Content-Disposition: inline
In-Reply-To: <CAMQu2gw2bGNwot_xVPdAsYjZChzzNib2USg8Ci+W5aLbenPnqA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: CF Adad <cfadad@rocketmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [120605 23:41]:
> 
> I don't know the AMXX architecture that well but looking at the
> crash-log, am not sure GPMC should play in role here.
> What I think is, it is mostly memory corruption and can be caused by
> many reasons as Tony outlined.

Bad GPMC timings can cause corruption on the smsc fifo, which can
cause random oopses especially with nfsroot.

I was seeing that on my zoom3 with nfsroot with bad muxing for GPMC
until we applied bce492c0 (ARM: OMAP2+: UART: Fix incorrect population of
default uart pads). That's easy to test by leaving out GPMC.
 
> To ensure that, your memory is in good state, can you run memtester
> for long duration and see that you
> are not getting any memory failures. Try to give the maximum memory
> size as a an input to memtester.

Yes and that should be left running for a few weeks on a group of
devices to verify things work once you think you have all the issues
fixed.

Regards,

Tony

 
> You can download one from [1]
> 
> Regards
> Santosh
> [1] http://pyropus.ca/software/memtester/
