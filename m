From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] dmtimer changes for v3.2 merge window
Date: Fri, 30 Sep 2011 22:52:50 +0200
Message-ID: <201109302252.50174.arnd@arndb.de>
References: <20110928220237.GE6324@atomide.com> <201109302213.42435.arnd@arndb.de> <20110930204319.GM6324@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:58547 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737Ab1I3Uwz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Sep 2011 16:52:55 -0400
In-Reply-To: <20110930204319.GM6324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Friday 30 September 2011, Tony Lindgren wrote:
> How about a branch called driver?
> 
> There are still lots of pieces of code under arch/arm that should
> be eventually moved to live under drivers. For example the mux
> code and most of PM code can eventually be under drivers.

Yes, good idea! For the omap/voltage series, I currently plan to
group that with pm changes for that I got for the other socs
this time, but if there was less of it, that could also be drivers.

> But before that can be done some preparation is often needed,
> the actual move to live under drivers should be handled then
> by the driver and subsystem maintainers.

I think in some cases we first need to nominate a subsystem
maintainer who can take the drivers, but that's a different
issue.

	Arnd
