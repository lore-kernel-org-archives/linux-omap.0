From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 1/3] omap non critical fixes for v3.10 merge window
Date: Mon, 8 Apr 2013 10:06:19 -0700
Message-ID: <20130408170619.GN10155@atomide.com>
References: <pull-1364923751-842943>
 <201304081824.35663.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54549 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934191Ab3DHRGZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Apr 2013 13:06:25 -0400
Content-Disposition: inline
In-Reply-To: <201304081824.35663.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

* Arnd Bergmann <arnd@arndb.de> [130408 09:29]:
> On Tuesday 02 April 2013, Tony Lindgren wrote:
> > The following changes since commit 07961ac7c0ee8b546658717034fe692fd12eefa9:
> > 
> >   Linux 3.9-rc5 (2013-03-31 15:12:43 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/fixes-non-critical-signed
> > 
> > for you to fetch changes up to 105612489bf59386b46b3f9f034e03f70e57aee6:
> > 
> >   Merge branch 'for_3.10/omap5_generic_updates' of git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux into omap-for-v3.10/fixes-non-critical (2013-04-01 09:30:47 -0700)
> > 
> 
> Pulled all three branches, thanks a lot!
> 
> The cleanup branch conflicted with a bug fix from Paul Walmsley that Linus
> already merged, see below for the resolution that I used, adding a modified
> line from the one Paul submitted.

Yes looks good thanks. I think I had the same resolve in one
of the other branches, but that should not cause issues with
your branches I presume.

Regards,

Tony
