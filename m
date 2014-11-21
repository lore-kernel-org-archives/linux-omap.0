From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] ARM: OMAP2+: Move GPMC initcall to devices.c
Date: Fri, 21 Nov 2014 08:17:05 -0800
Message-ID: <20141121161705.GR7046@atomide.com>
References: <1416522501-14999-1-git-send-email-tony@atomide.com>
 <1416522501-14999-3-git-send-email-tony@atomide.com>
 <546F08C2.4090903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:40637 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755412AbaKUQRQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2014 11:17:16 -0500
Content-Disposition: inline
In-Reply-To: <546F08C2.4090903@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>

* Roger Quadros <rogerq@ti.com> [141121 01:43]:
> On 11/21/2014 12:28 AM, Tony Lindgren wrote:
> > This will us allow to just move gpmc.c to live under drivers
> > in the next patch.
> > 
> > Note that we now also remove the omap specific check for the
> > initcall. That's OK as gpmc_probe() checks for the pdata
> > and bails out for other platforms compiled in.
> > 
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Roger Quadros <rogerq@ti.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> I guess gpmc_init can't still be put under module_init() till we have fixed up
> some more issues in the GPMC driver. But it shouldn't prevent us from making
> the move to drivers/, so
> 
> Acked-by: Roger Quadros <rogerq@ti.com>

Yeah I figured it's too close to the merge cycle to start playing
with the initcall levels. It may already be possible to make it
just module_init() but let's do that as separate patches after
the move.

Regards,

Tony
