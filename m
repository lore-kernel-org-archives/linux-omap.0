From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/5] ARM: OMAP2+: gpmc: configuration enhancements
Date: Wed, 5 Nov 2014 08:09:46 -0800
Message-ID: <20141105160946.GV31454@atomide.com>
References: <1413895309-9152-1-git-send-email-rogerq@ti.com>
 <20141030151036.GE2560@atomide.com>
 <5452582A.9060505@ti.com>
 <20141104174907.GC28170@atomide.com>
 <545A1C13.1030007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:18405 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932110AbaKEQKt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Nov 2014 11:10:49 -0500
Content-Disposition: inline
In-Reply-To: <545A1C13.1030007@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: pekon@pek-sem.com, javier@dowhile0.org, linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [141105 04:47]:
> On 11/04/2014 07:49 PM, Tony Lindgren wrote:
> > * Roger Quadros <rogerq@ti.com> [141030 08:25]:
> >> On 10/30/2014 05:10 PM, Tony Lindgren wrote:
> >>> * Roger Quadros <rogerq@ti.com> [141021 05:43]:
> >>>> Hi Tony,
> >>>>
> >>>> These patches address GPMC configuration issues and are for v3.19.
> >>>> Patches based on v3.18-rc1.
> >>>>
> >>>> - Make sure to print a user visible error if a requested GPMC timing
> >>>> configuration can't be met.
> >>>>
> >>>> - Don't create GPMC child device if a GPMC timing could not be set.
> >>>>
> >>>> - Always enable address lines A26-A11 for non-NAND devices.
> >>>>
> >>>> - Perform GPMC configuration as per recommended procedure i.e.
> >>>> keep Chip Select disabled while changing GPMC configuration.
> >>>>
> >>>> Tested on dra7-evm, am437x-gp-evm and beagleboard.
> >>>
> >>> For all these, please feel free to add:
> >>>
> >>> Acked-by: Tony Lindgren <tony@atomide.com>
> >>>
> >>
> >> Thanks. These patches are now available at
> >>
> >> git@github.com:rogerq/linux.git		for-v3.19/gpmc-omap
> >>
> > 
> > Merged these on top of the patches I did to omap-for-v3.19/gpmc.
> > There were few merge conflicts so you may want to check.
> 
> Thanks. The conflict resolution seems fine.
> I've also tested NAND to be fine on am335x-evm, am437x-evm and dra7-evm.

OK great thanks,

Tony
