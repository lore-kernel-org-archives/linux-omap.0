From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH V4 12/12] ARM: OMAP2+: Simplify dmtimer clock aliases
Date: Fri, 15 Jun 2012 19:38:46 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206151937541.25436@utopia.booyaka.com>
References: <1338917700-29174-1-git-send-email-jon-hunter@ti.com> <1338917700-29174-13-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37784 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754165Ab2FPBir (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jun 2012 21:38:47 -0400
In-Reply-To: <1338917700-29174-13-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>

On Tue, 5 Jun 2012, Jon Hunter wrote:

> The OMAP dmtimer driver allows you to dynamically configure the functional
> clock that drives the timer logic. The dmtimer driver uses the device name and
> a "con-id" string to search for the appropriate functional clock.
> 
> Currently, we define a clock alias for each functional clock source each timer
> supports. Some functional clock sources are common to all of the timers on a
> device and so for these clock sources we can use a single alias with a unique
> con-id string.
> 
> The possible functional clock sources for an OMAP device are a 32kHz clock,
> a system (MHz range) clock and (for OMAP2 only) an external clock. By defining
> a unique con-id name for each of these (timer_32k_ck, timer_sys_ck and
> timer_ext_ck) we can eliminate a lot of the clock aliases for timers. This
> reduces code, speeds-up searches and clock initialisation time.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Acked-by: Paul Walmsley <paul@pwsan.com>

At some point we should probably investigate moving these aliases into the 
hwmod optional clocks, but this requires more thought.


- Paul
