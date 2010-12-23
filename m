From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap2: Make OMAP2PLUS select OMAP_DM_TIMER
Date: Thu, 23 Dec 2010 12:49:04 -0800
Message-ID: <20101223204904.GS7771@atomide.com>
References: <1293127631-764-1-git-send-email-bgamari.foss@gmail.com>
 <1293127631-764-2-git-send-email-bgamari.foss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:12190 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107Ab0LWUtH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Dec 2010 15:49:07 -0500
Content-Disposition: inline
In-Reply-To: <1293127631-764-2-git-send-email-bgamari.foss@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Gamari <bgamari.foss@gmail.com>
Cc: linux-omap@vger.kernel.org, manjugk@ti.com, santosh.shilimkar@ti.com, khilman@deeprootsystems.com

* Ben Gamari <bgamari.foss@gmail.com> [101223 10:07]:
> It appears that arch/arm/mach-omap2/timer-gp.o is needed by OMAP2PLUS.
> Since timer-gp.o has direct dependencies on omap_dm_timer_*, it seems
> correct for the architecture to depend upon OMAP_DM_TIMER, otherwise
> unsuspecting integrators will be faced with a whole bunch of linker
> errors at the end of their kernel build:

Can you please repost this with linux-arm-kernel list also Cc'd?

Thanks,

Tony
