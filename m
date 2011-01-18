From: Paul Walmsley <paul@pwsan.com>
Subject: Re: NULL deref on sched_clock_poll()
Date: Mon, 17 Jan 2011 23:21:56 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101172321450.13225@utopia.booyaka.com>
References: <20110118051227.GE2436@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38935 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974Ab1ARGV5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 01:21:57 -0500
In-Reply-To: <20110118051227.GE2436@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Tue, 18 Jan 2011, Felipe Balbi wrote:

> with today's mainline plus Russell's v6k patchset, I can't get
> pandaboard to boot with omap2plus_defconfig.
> 
> The problem is that noone seems to be setting sched_clock_update_fn(),
> so we we call sched_clock_poll() we have a NULL pointer deref.
> 
> I have 32k counter enabled but after adding a printk() to
> omap_init_clocksource_32k() I don't see that getting called at all :-(
> 
> Am I missing any patch on top of Linus' tree ?

http://www.spinics.net/lists/linux-omap/msg44013.html


- Paul
