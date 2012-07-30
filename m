From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 6/8] ARM: OMAP: pm-debug: enhanced usecount debug
 support
Date: Mon, 30 Jul 2012 11:36:11 +0300
Message-ID: <1343637371.9847.11.camel@sokoban>
References: <1342189185-5306-1-git-send-email-t-kristo@ti.com>
	 <1342189185-5306-7-git-send-email-t-kristo@ti.com>  <87y5m5htcu.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33492 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024Ab2G3IgT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jul 2012 04:36:19 -0400
In-Reply-To: <87y5m5htcu.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On Fri, 2012-07-27 at 12:55 -0700, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > Voltdm, pwrdm, clkdm, hwmod and clk usecounts are now separeted to
> > their own file, 'usecount'. This file shows the usecounts for every
> > active domain and their children recursively. 'count' file now only
> > shows power state counts for powerdomains.
> >
> > This patch also provices a way to do printk dumps from kernel code,
> > by calling the pm_dbg_dump_X functions. The plan is to call these
> > functions once an error condition is detected, e.g. failed suspend.
> >
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Kevin Hilman <khilman@ti.com>
> 
> I think we should separate out the debug stuff as a separate patch set.
> 
> Where I want to go with PM debug is away from in-kernel debug prints and
> towards using tracepoints.  We have tracepoints in the clock code that
> correspond to usecounts, but we need them in the clkdm, pwrdm and voltdm
> code as well.  With that, you can use userspace tools (perf, ftrace) to
> trace a problem (e.g. failed suspend) and see voltdm/pwrdm/clkdm/clks
> are on when they shouldn't be.

Yes, I can split out the debug stuff from this set for next rev. I'll
also take a look at the tracepoints if they can be used reasonably for
this purpose. We can add tracepoints for failed suspend for each
powerdomain, but are tracepoints a good way to do this kind of recursive
dumps (well, we could maybe register a trace event recursively from
clkdm + clk code if a powerdomain fails to transition.)

-Tero

