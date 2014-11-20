From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 1/2] omap non-urgent fixes for v3.19
Date: Thu, 20 Nov 2014 08:03:52 -0800
Message-ID: <20141120160352.GN7046@atomide.com>
References: <pull-1415725783-562282>
 <201411201046.44262.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:34605 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418AbaKTQEM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Nov 2014 11:04:12 -0500
Content-Disposition: inline
In-Reply-To: <201411201046.44262.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: arm@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [141120 01:48]:
> On Tuesday 11 November 2014, Tony Lindgren wrote:
> > ----------------------------------------------------------------
> > Fixes for omap3 that are not urgent. Mostly to remove unnecessary
> > noise during the boot with pointless errors and warnings.
> > 
> 
> 
> Pulled into next/fixes-non-critical. We didn't have any other patches in there,
> so I started out with -rc3 to avoid the back-merge problem. Any reason why
> you didn't base this on -rc1 like the other branches?

I was probably originally planning to have the dmesg warning
and error fixes merged into omap-for-v3.18/fixes branch and
have that automatically fast forward to -rc3 without rebasing.

No other dependency that I can think of.

Regards,

Tony
