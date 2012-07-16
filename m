From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 6/8] ARM: OMAP: pm-debug: enhanced usecount debug
 support
Date: Mon, 16 Jul 2012 14:45:56 +0300
Message-ID: <1342439156.4672.66.camel@sokoban>
References: <1342189185-5306-1-git-send-email-t-kristo@ti.com>
	 <1342189185-5306-7-git-send-email-t-kristo@ti.com>
	 <5003F1E9.5080700@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39895 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752540Ab2GPLqD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jul 2012 07:46:03 -0400
In-Reply-To: <5003F1E9.5080700@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Mon, 2012-07-16 at 16:20 +0530, Rajendra Nayak wrote:
> On Friday 13 July 2012 07:49 PM, Tero Kristo wrote:
> > Voltdm, pwrdm, clkdm, hwmod and clk usecounts are now separeted to
> > their own file, 'usecount'. This file shows the usecounts for every
> > active domain and their children recursively. 'count' file now only
> > shows power state counts for powerdomains.
> 
> The only comment I had on this patch was what I also said in response
> to PATCH 1/8 about keeping the clock usecounts separate if possible.
> voltdm, pwrdm, clkdm and hwmod are OMAP specific frameworks (and so is
> clock framework for now) but sooner than later we would move to using
> COMMON clock framework and then supporting the clock usecounts in
> /debug/pm_debug/usecount would not be possible.

Well, I guess we can move these patches to a separate debug set for now
in that case, and people who want to use them can do that.

> 
> >
> > This patch also provices a way to do printk dumps from kernel code,
> > by calling the pm_dbg_dump_X functions. The plan is to call these
> > functions once an error condition is detected, e.g. failed suspend.

^
|
This part is the main motivation for this patch imo.

-Tero

