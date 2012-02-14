From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/6] arm: omap: pm-debug: enhanced usecount debug
 support
Date: Tue, 14 Feb 2012 15:52:18 -0800
Message-ID: <20120214235218.GX1426@atomide.com>
References: <1329237402-26008-1-git-send-email-t-kristo@ti.com>
 <1329237402-26008-7-git-send-email-t-kristo@ti.com>
 <20120214202740.GT1426@atomide.com>
 <87fwed58dm.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:11835 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757276Ab2BNXwV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Feb 2012 18:52:21 -0500
Content-Disposition: inline
In-Reply-To: <87fwed58dm.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

* Kevin Hilman <khilman@ti.com> [120214 14:28]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Tero Kristo <t-kristo@ti.com> [120214 08:19]:
> >> Voltdm, pwrdm, clkdm, hwmod and clk usecounts are now separeted to
> >> their own file, 'usecount'. This file shows the usecounts for every
> >> active domain and their children recursively. 'count' file now only
> >> shows power state counts for powerdomains.
> >> 
> >> This patch also provices a way to do printk dumps from kernel code,
> >> by calling the pm_dbg_dump_X functions. The plan is to call these
> >> functions once an error condition is detected, e.g. failed suspend.
> >
> > Why don't you replace this all with a userspace tool that deciphers
> > the registers for you?
> 
> This patch isn't deciphering registers, it's just dumping usecounts, and
> I think that is extremely useful to have in debugfs.
> 
> I've already removed all the register dumping from the kernel in the
> hopes that someone will write a userspace tool for that.

OK good to hear you're already considering it.

Tony
