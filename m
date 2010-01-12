From: Alexander Shishkin <virtuoso@slind.org>
Subject: Re: [PATCH] save and restore etm state across core OFF modes
Date: Tue, 12 Jan 2010 23:46:54 +0200
Message-ID: <20100112214654.GH29059@shisha.kicks-ass.net>
References: <1263315891-4440-1-git-send-email-virtuoso@slind.org>
 <4B4CADA9.4020502@ti.com>
 <20100112173022.GG29059@shisha.kicks-ass.net>
 <4B4CB259.2010301@ti.com>
 <20100112210404.GB2986@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:43656 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161Ab0ALVsd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jan 2010 16:48:33 -0500
Content-Disposition: inline
In-Reply-To: <20100112210404.GB2986@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Woodruff, Richard" <r-woodruff2@ti.com>

On Tue, Jan 12, 2010 at 01:04:04 -0800, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [100112 09:31]:
> > Alexander Shishkin had written, on 01/12/2010 11:30 AM, the following:
> > >On Tue, Jan 12, 2010 at 11:13:13 -0600, Nishanth Menon wrote:
> > >>Alexander Shishkin had written, on 01/12/2010 11:04 AM, the following:
> > 
> > >>>diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
> > >>>index 69521be..0a5ec86 100644
> > >>>--- a/arch/arm/mach-omap2/sleep34xx.S
> > >>>+++ b/arch/arm/mach-omap2/sleep34xx.S
> > [...]
> > >>>	/* Store current cpsr*/
> > >>>	mrs	r2, cpsr
> > >>>	stmia	r8!, {r2}
> > >>>@@ -520,6 +616,7 @@ clean_caches:
> > >>>	cmp	r9, #1 /* Check whether L2 inval is required or not*/
> > >>>	bne	skip_l2_inval
> > >>>clean_l2:
> > >>>+#if 0
> > >>my aversion to #if 0 kicks in here :(.. do we have an alternative
> > >>like using the CONFIG_ENABLE_OFF_MODE_JTAG_ETM_DEBUG or something
> > >>else?
> > >
> > >Fair enough. I could replace it with "#if !defined(...)" as the first
> > >thing that comes to mind. This way it will only take disabling the
> > >config option to catch any possible regressions in between. Does this
> > >sound reasonable?
> > sounds ok to me.. unless folks have ideas coz of clean_l2 label..
> > more comments might be useful before a rev2 of the patch..
> 
> The best solution would be to be able to toggle this via sysfs or
> debugfs by swapping the sram code for idle loop when JTAG support
> is needed.

Well, if you say, compile the ETM driver in, this will be needed most of
the time.

Regards,
--
Alex
