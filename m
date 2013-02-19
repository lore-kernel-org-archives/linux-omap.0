From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] reworked omap usb pdata changes for v3.9 merge
 window
Date: Tue, 19 Feb 2013 14:00:57 -0800
Message-ID: <20130219220057.GK5724@atomide.com>
References: <20130215003543.GF11806@atomide.com>
 <201302192130.33509.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:62617 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934520Ab3BSWBD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Feb 2013 17:01:03 -0500
Content-Disposition: inline
In-Reply-To: <201302192130.33509.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [130219 13:34]:
> On Friday 15 February 2013, Tony Lindgren wrote:
> > Hi Arnd & Olof,
> > 
> > Roger Quadros reworked the OMAP USB patches that were causing
> > a conflict in Linux next and we requested to be dropped from
> > Linux next and reworked to remove the dependencies between
> > core SoC code and the driver code.
> > 
> > Below is a pull request for the mach-omap2 specific parts, the
> > rest is driver specific and queued by Samuel in the MFD tree
> > and Greg for the USB changes.
> > 
> > I've left it unresolved so you can merge it into one of your
> > branches as a dependency so we can avoid the merge conflict
> > in Linux next. A link to the merge resolution done by Stephen
> > is in the pull request. Let me know if you want me to resolve
> > it instead. 
> 
> I've pulled them into next/soc now. I was wondering whether to
> put them into the late/omap branch instead, but this seemed
> like the easiest way to resolve the conflict, and the patches
> are simple enough.

OK thanks!

Tony
