From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] omap4: pandaboard: machine cleanups
Date: Wed, 6 Oct 2010 13:56:38 -0700
Message-ID: <20101006205638.GA4859@atomide.com>
References: <1285104244-32274-1-git-send-email-x0132446@ti.com>
 <20100927223054.GG16721@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56392 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115Ab0JFU4k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Oct 2010 16:56:40 -0400
Content-Disposition: inline
In-Reply-To: <20100927223054.GG16721@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Anders <x0132446@ti.com>
Cc: jayabharath@ti.com, gadiyar@ti.com, vpasam@ti.com, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [100927 15:22]:
> * David Anders <x0132446@ti.com> [100921 14:15]:
> > PandaBoard machine file related cleanups.
> > 
> > David Anders (4):
> >   omap4: pandaboard: remove unused hsmmc definition
> >   omap4: pandaboard: Fix the init if CONFIG_MMC_OMAP_HS is not set
> >   omap4: pandaboard: Adding card detect support for MMC1
> >   omap4: pandaboard: enable the ehci port on pandaboard
> > 
> >  arch/arm/mach-omap2/board-omap4panda.c |   76 +++++++++++++++++++++++++++++---
> >  1 files changed, 69 insertions(+), 7 deletions(-)
> 
> David, please repost this series one more time with linux-arm-kernel
> list also Cc'd in addition to the linux-omap list.

Ping, we're starting to run out of time!

Tony
