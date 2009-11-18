From: Tony Lindgren <tony@atomide.com>
Subject: Re: Problem trying to pull particular commit from PM tree
Date: Wed, 18 Nov 2009 08:57:38 -0800
Message-ID: <20091118165738.GJ29266@atomide.com>
References: <1258554311.750.33.camel@blitz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53367 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757746AbZKRQ5e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 11:57:34 -0500
Content-Disposition: inline
In-Reply-To: <1258554311.750.33.camel@blitz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peterb@logicpd.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

* Peter Barada <peterb@logicpd.com> [091118 06:20]:
> Is it possible to back up in time on the PM tree to find a particular
> commit, even across rebasings?  I'm interested in the commit used by TI
> to base their AM3517 work on which is:
> 
> [Commit:ef25c2a0e0]: OMAP3: PM: defconfig: enable SRF by default.
> 
> I tried:
> 
> git clone git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
> git checkout -b pm origin/pm
> git reset --hard ef25c2a0
> 
> But that came back with:
> 
> fatal: ambiguous argument 'ef25c2a0': unknown revision or path not in
> the working tree.
> 
> My git 'fu' is pretty weak.  Any ideas why this doesn't work?
> Thanks in advance!

Maybe ef25c2a0e0 is some TI internal commit?

Tony
