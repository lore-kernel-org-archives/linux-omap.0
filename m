From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/11] Fixes for omap PM for making omap3 DT only
Date: Fri, 11 Apr 2014 14:04:06 -0700
Message-ID: <20140411210405.GA6030@atomide.com>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>
 <20140411204732.GA17997@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:65094 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754432AbaDKVEN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2014 17:04:13 -0400
Content-Disposition: inline
In-Reply-To: <20140411204732.GA17997@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Sebastian Reichel <sre@ring0.de> [140411 13:51]:
> 
> I'm on vacation from tomorrow until next week's weekend, but I will
> have a look the week after next (if still needed).

OK
 
> I have not yet read much of TWL/OMAP PM documentation, but I wonder
> if it makes sense to move the powerscripting stuff into the DTS file
> somehow. On a first look the added N900 tables in
> drivers/mfd/twl4030-power.c seem like a step back to me.

Need to think about it a bit more, but I think we can have generic
scripts based on the tables in "Recommended Sleep Sequences for
the Zoom Platform" pdf at:

http://omappedia.com/wiki/File:Recommended_Sleep_Sequences_Zoom.pdf

Then we can have a function that patches in board specific stuff
as needed as changes to the generic rconfig table.

I'll take a look at that, let's see how that works. If that works,
the board specific increments to the generic data should be pretty
small and the data can easily live in the twl4030-power.c with no
need to stuff it into the .dts files.

BTW, the situation is also a bit different from the original N900
kernel as we now have runtime PM and drivers can easily manage their
regulators.

Regards,

Tony
