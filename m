From: Alexander Shishkin <virtuoso@slind.org>
Subject: Re: [PATCH] save and restore etm state across core OFF modes
Date: Wed, 13 Jan 2010 13:36:16 +0200
Message-ID: <20100113113616.GI29059@shisha.kicks-ass.net>
References: <1263315891-4440-1-git-send-email-virtuoso@slind.org>
 <4B4CADA9.4020502@ti.com>
 <20100112173022.GG29059@shisha.kicks-ass.net>
 <4B4CB259.2010301@ti.com>
 <20100112210404.GB2986@atomide.com>
 <20100112214654.GH29059@shisha.kicks-ass.net>
 <4B4CF2D7.9000200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:35696 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518Ab0AMLha (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 06:37:30 -0500
Content-Disposition: inline
In-Reply-To: <4B4CF2D7.9000200@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Woodruff, Richard" <r-woodruff2@ti.com>, Alexander Shishkin <virtuoso@slind.org>

On Tue, Jan 12, 2010 at 04:08:23 -0600, Nishanth Menon wrote:
> Alexander Shishkin had written, on 01/12/2010 03:46 PM, the following:
> >On Tue, Jan 12, 2010 at 01:04:04 -0800, Tony Lindgren wrote:
> >>* Nishanth Menon <nm@ti.com> [100112 09:31]:
> >>>Alexander Shishkin had written, on 01/12/2010 11:30 AM, the following:
> >>>>On Tue, Jan 12, 2010 at 11:13:13 -0600, Nishanth Menon wrote:
> >>>>>Alexander Shishkin had written, on 01/12/2010 11:04 AM, the following:
> >>>>>>diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
> >>>>>>index 69521be..0a5ec86 100644
> >>>>>>--- a/arch/arm/mach-omap2/sleep34xx.S
> >>>>>>+++ b/arch/arm/mach-omap2/sleep34xx.S
> >>>[...]
> >>>>>>	/* Store current cpsr*/
> >>>>>>	mrs	r2, cpsr
> >>>>>>	stmia	r8!, {r2}
> >>>>>>@@ -520,6 +616,7 @@ clean_caches:
> >>>>>>	cmp	r9, #1 /* Check whether L2 inval is required or not*/
> >>>>>>	bne	skip_l2_inval
> >>>>>>clean_l2:
> >>>>>>+#if 0
> >>>>>my aversion to #if 0 kicks in here :(.. do we have an alternative
> >>>>>like using the CONFIG_ENABLE_OFF_MODE_JTAG_ETM_DEBUG or something
> >>>>>else?
> >>>>Fair enough. I could replace it with "#if !defined(...)" as the first
> >>>>thing that comes to mind. This way it will only take disabling the
> >>>>config option to catch any possible regressions in between. Does this
> >>>>sound reasonable?
> >>>sounds ok to me.. unless folks have ideas coz of clean_l2 label..
> >>>more comments might be useful before a rev2 of the patch..
> >>The best solution would be to be able to toggle this via sysfs or
> >>debugfs by swapping the sram code for idle loop when JTAG support
> >>is needed.
> >
> >Well, if you say, compile the ETM driver in, this will be needed most of
> >the time.
> >
> I can think of reasons for an against a sysfs entry (as part of
> discussion -warning lot of self contradictions below- but I think
> might save a bit of back and froth ;)):
> 
> for sysfs entry:
> a) save and restore will have additional latency when you save a
> chunk such as EMU domain regs - this will not be needed in
> production phones, disabling it might pop up surprises
> 	counter: having a disabled defconfig allows relevant folks to
> 	enable on a need basis
> 		counter to counter: what do you do when a user reports
> 		an issue in a release and you'd want to debug it with 		
> 		ETM on his platform other than doing a rebuild?

Well, my intention is to have it enabled for most of the cases only having
it disabled for testing purposes.

> b) mostly a debug support -> only for blokes using ETM/JTAG
> interfaces - not everyone can afford these (no offense to openOCD
> guys - but they are still a bit away from being able to debug kernel
> yet on OMAP)..

Not really, you can still make use of ETM without any additional hardware
attached.

Regards,
--
Alex
