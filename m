From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv8 03/13] I2C: OMAP: Remove reset at init
Date: Thu, 21 Jun 2012 00:20:00 -0700
Message-ID: <20120621071959.GV12766@atomide.com>
References: <1340029828-20751-1-git-send-email-shubhrajyoti@ti.com>
 <1340029828-20751-4-git-send-email-shubhrajyoti@ti.com>
 <20120620102905.GC12766@atomide.com>
 <4FE2C750.3020803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:36846 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758485Ab2FUHUE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jun 2012 03:20:04 -0400
Content-Disposition: inline
In-Reply-To: <4FE2C750.3020803@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, w.sang@pengutronix.de

* Shubhrajyoti <shubhrajyoti@ti.com> [120621 00:08]:
> On Wednesday 20 June 2012 03:59 PM, Tony Lindgren wrote:
> > See the comments regarding driver specific resets in hwmod code.
> you mean omap_hwmod.c
> >
> > The way to set this up is to have a shared inline function in
> > i2c-omap.h that both the driver and hwmod code can use.
> hwmod reset function uses oh (omap_hwmod).
> 
> How could the driver also pass oh ?
> Could we keep a local copy in driver data?
> > Eventually hwmod code will do the reset only in late initcall
> > if no driver is loaded for the device in question.
> 

There's no need for the driver to know anything about oh.
The driver just needs to know the iobase.

Tony
