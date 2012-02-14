From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/6] arm: omap: pm-debug: enhanced usecount debug
 support
Date: Tue, 14 Feb 2012 12:27:40 -0800
Message-ID: <20120214202740.GT1426@atomide.com>
References: <1329237402-26008-1-git-send-email-t-kristo@ti.com>
 <1329237402-26008-7-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:45523 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757241Ab2BNU1n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Feb 2012 15:27:43 -0500
Content-Disposition: inline
In-Reply-To: <1329237402-26008-7-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [120214 08:19]:
> Voltdm, pwrdm, clkdm, hwmod and clk usecounts are now separeted to
> their own file, 'usecount'. This file shows the usecounts for every
> active domain and their children recursively. 'count' file now only
> shows power state counts for powerdomains.
> 
> This patch also provices a way to do printk dumps from kernel code,
> by calling the pm_dbg_dump_X functions. The plan is to call these
> functions once an error condition is detected, e.g. failed suspend.

Why don't you replace this all with a userspace tool that deciphers
the registers for you?

Tony
