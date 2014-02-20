From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: clock/PRCM/hwmod fixes for v3.14-rc
Date: Thu, 20 Feb 2014 02:58:29 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1402200257060.25798@utopia.booyaka.com>
References: <alpine.DEB.2.02.1402192120200.8777@utopia.booyaka.com> <53052219.9060109@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:46576 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460AbaBTC6a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Feb 2014 21:58:30 -0500
In-Reply-To: <53052219.9060109@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 19 Feb 2014, Nishanth Menon wrote:

> Paul,
> On 02/19/2014 03:22 PM, Paul Walmsley wrote:
> [...]
> > 
> > - ----------------------------------------------------------------
> > Illia Smyrnov (1):
> >       ARM: OMAP4: hwmod: Fix SOFTRESET logic for OMAP4
> > 
> > Suman Anna (1):
> >       ARM: DRA7: hwmod data: correct the sysc data for spinlock
> > 
> > Tomi Valkeinen (1):
> >       ARM: OMAP2+: clock: fix clkoutx2 with CLK_SET_RATE_PARENT
> > 
> > Vaibhav Bedia (1):
> >       ARM: OMAP5: PRM: Fix reboot handling
> > 
> 
> https://patchwork.kernel.org/patch/3585321/ missing?

If that fixes a bug, then that should be documented in the commit 
description.

Otherwise it's 3.15 material.

- Paul
