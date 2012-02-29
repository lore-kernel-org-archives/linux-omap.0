From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 5/5] Clean-up for omap
Date: Wed, 29 Feb 2012 13:24:55 -0800
Message-ID: <20120229212455.GQ18901@atomide.com>
References: <0M0SaL-1SHLTi0asf-00u7ia@mx.kundenserver.de>
 <201202292120.07286.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:10599 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756291Ab2B2VY7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Feb 2012 16:24:59 -0500
Content-Disposition: inline
In-Reply-To: <201202292120.07286.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [120229 12:48]:
> On Wednesday 29 February 2012, Tony Lindgren wrote:
> > This is mostly changes needed for io.h removal, and one
> > patch to remove unused flag for McSPI. Note that these
> > are based on RMK's for-armsoc.
> > 
> > Also, these cause a minor merge conflict for mach-omap2/Kconfig
> > with the fixes-non-critical posted in this series of pull
> > requests.
> 
> Hmm, I did not see the conflict in this one, but I saw one in the
> dt branch that I fixed.

OK sounds like I did not remember correctly where the conflict was.
 
> I pulled this one into next/cleanup.

Thanks.

Tony
