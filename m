From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH v2] OMAP3: PM: reset USB OTG module on boot
Date: Thu, 25 Jun 2009 00:28:38 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0906250027440.2676@utopia.booyaka.com>
References: <1245857533-2419-1-git-send-email-khilman@deeprootsystems.com> <FCCFB4CDC6E5564B9182F639FC35608702F546233D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34567 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbZFYG2h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jun 2009 02:28:37 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F546233D@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 24 Jun 2009, Pandita, Vikram wrote:

> >-----Original Message-----
> >From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin
> >Hilman
> >
> >Rather than simply setting force-idle mode on boot, do a reset of the
> >OTG module.  This really ensures that any bootloader/bootstrap code
> >that leaves it active will not prevent future retention.  After reset,
> >OTG module will be in force-idle, force-standby mode.
> >
> >In addition, ensure that the iclk is enabled before attempting a write
> >to the module SYSCONFIG register.
> 
> This patch solves MUSB issue, but is not generic for all IP blocks on omap.
> 
> ROM code or u-boot could leave the module sysconfig in a non-idle state.
> 
> I recommend just like CONFIG_OMAP_RESET_CLOCKS for clocks, same could be 
> done generically for all SYSCONFIG registers in some prcm code and not 
> driver specific.

I agree.  Please contribute to the development of the omap_hwmod patchset, 
which does this (among other things).


- Paul
