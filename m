From: Ben Gamari <bgamari.foss@gmail.com>
Subject: Re: [PATCH] omap2: Make OMAP2PLUS select OMAP_DM_TIMER
Date: Thu, 23 Dec 2010 21:53:13 -0500
Message-ID: <87pqsrx4o6.fsf@gmail.com>
References: <1293127631-764-1-git-send-email-bgamari.foss@gmail.com> <1293127631-764-2-git-send-email-bgamari.foss@gmail.com> <20101223204904.GS7771@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:55435 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672Ab0LXCxR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Dec 2010 21:53:17 -0500
Received: by qwa26 with SMTP id 26so6788525qwa.19
        for <linux-omap@vger.kernel.org>; Thu, 23 Dec 2010 18:53:16 -0800 (PST)
In-Reply-To: <20101223204904.GS7771@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, manjugk@ti.com, santosh.shilimkar@ti.com, khilman@deeprootsystems.com

On Thu, 23 Dec 2010 12:49:04 -0800, Tony Lindgren <tony@atomide.com> wrote:
> * Ben Gamari <bgamari.foss@gmail.com> [101223 10:07]:
> > It appears that arch/arm/mach-omap2/timer-gp.o is needed by OMAP2PLUS.
> > Since timer-gp.o has direct dependencies on omap_dm_timer_*, it seems
> > correct for the architecture to depend upon OMAP_DM_TIMER, otherwise
> > unsuspecting integrators will be faced with a whole bunch of linker
> > errors at the end of their kernel build:
> 
> Can you please repost this with linux-arm-kernel list also Cc'd?
> 
Done. Sorry for all of the list noise.

- Ben
