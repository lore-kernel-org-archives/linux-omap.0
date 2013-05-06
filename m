From: Tony Lindgren <tony@atomide.com>
Subject: Re: mach-omap2/timer.c: Bug introduced while merging patch -
 ff931c82
Date: Mon, 6 May 2013 08:27:06 -0700
Message-ID: <20130506152706.GD28721@atomide.com>
References: <79CD15C6BA57404B839C016229A409A83EC7C45D@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:17773 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753874Ab3EFP1K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 May 2013 11:27:10 -0400
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EC7C45D@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Hiremath, Vaibhav <hvaibhav@ti.com> [130506 00:12]:
> Hi,
> 
> Not sure whether this got discussed and fixed already, but Google didn't give me anything :)
> 
> The below commit got merged wrongly to Mainline (Changes from timer.c got missed), and 
> due to this none of omap boards will boot.
> 
> 
> From ff931c821bab6713a52b768b0cd7ee7e90713b36 Mon Sep 17 00:00:00 2001
> From: Rajendra Nayak <rnayak@ti.com>
> Date: Thu, 21 Mar 2013 11:04:52 +0000
> Subject: ARM: OMAP: clocks: Delay clk inits atleast until slab is initialized
> 
> 
> It seems Linux-omap tree has the fix patch for this, and it should get pushed ASAP. 
> Below are links for Linus's mainline commit [1], the actual patch submitted to the list [2] and
> Commit  present in Linux-omap [3].

Can you please provide a proper patch for the regression since sounds
like you already figured out what happened?

Regards,

Tony 
 
> [1] http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/arch/arm/mach-omap2/io.c?id=ff931c821bab6713a52b768b0cd7ee7e90713b36
> [2] https://patchwork.kernel.org/patch/2300071/
> [3] http://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/commit/arch/arm/mach-omap2/timer.c?id=ff931c821bab6713a52b768b0cd7ee7e90713b36
