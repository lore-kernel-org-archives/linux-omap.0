From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] Drop legacy support for omap3517
Date: Tue, 13 Jan 2015 12:42:20 -0800
Message-ID: <20150113204219.GJ2419@atomide.com>
References: <1421171865-5209-1-git-send-email-tony@atomide.com>
 <10549142.7lWnPtPtZG@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:63886 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751322AbbAMUqJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2015 15:46:09 -0500
Content-Disposition: inline
In-Reply-To: <10549142.7lWnPtPtZG@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>

* Arnd Bergmann <arnd@arndb.de> [150113 12:27]:
> On Tuesday 13 January 2015 09:57:41 Tony Lindgren wrote:
> > 
> > It seems we can now drop omap3517 legacy booting support to get
> > a bit closer to making all of omap3 boot in device tree only mode.
> > 
> > All these boards have at least minimal support for booting with
> > device tree, and pretty much anything supported with the legacy
> > board files can be configured also for device tree based booting
> > if not done already.
> 
> Ah, very nice.
> 
> Just out of curiosity, what are the remaining showstoppers for
> the 3430 and 3530 based boards?

Not much really. We're now printing a warning to get a people to
upgrade their systems. So with some boards we need to wait a while.

Then here are the remaining items that I'm aware of:

- A regression at least on some n900 with appended DTB not booting
  properly any longer reported by Pali

- A regression where the legacy ATAGs don't seem to get properly
  translated by the uncompress code for atag_rev at least reported
  by Pali

- A few missing .dts files for devkit8000, omap3logic, omap3stalker,
  omap3pandora and omap3touchbook

Pali and Sebastian probably know best of any other remaining
issues to drop n900 legacy booting.

If people have the boards listed above, please pitch in to do the
.dts files or send the boards to me and I can do minimal .dts
files for them.

Regards,

Tony
