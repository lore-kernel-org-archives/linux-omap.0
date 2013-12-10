From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] make mach-omap2 boot with device tree only for v3.14
Date: Tue, 10 Dec 2013 10:43:49 -0800
Message-ID: <20131210184349.GM13171@atomide.com>
References: <pull-1386643347-596413>
 <20131210143547.GA32243@n2100.arm.linux.org.uk>
 <20131210160144.GG13171@atomide.com>
 <201312101936.54483.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:26769 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750917Ab3LJSn6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Dec 2013 13:43:58 -0500
Content-Disposition: inline
In-Reply-To: <201312101936.54483.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [131210 10:38]:
> On Tuesday 10 December 2013, Tony Lindgren wrote:
> > The crappy part here is the fact that we need to build the kernel with
> > appended DTB. Maybe there's something more we can do to make it easier.
> > 
> 
> You are aware of the impedence matcher project [1], right?

Oh OK cool :) AFAIK the only omaps we're currently supporting in the
mainline tree where the bootloader cannot be updated easily are the
n9* that require a signed bootloader. But I think those already have
some kind of 3rd stage bootloaders available for them.

Regards,

Tony
 
> [1] https://github.com/zonque/pxa-impedance-matcher
