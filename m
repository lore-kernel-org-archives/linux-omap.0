From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 7/7] OMAP3: beagleboard: Remove DT support from regular
 board
Date: Fri, 2 Sep 2011 13:48:50 +0300
Message-ID: <20110902104850.GS3548@atomide.com>
References: <1314897912-18178-1-git-send-email-b-cousson@ti.com>
 <1314897912-18178-8-git-send-email-b-cousson@ti.com>
 <20110902081246.GQ3548@atomide.com>
 <4E609B0A.1020804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:31168 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933366Ab1IBKsx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Sep 2011 06:48:53 -0400
Content-Disposition: inline
In-Reply-To: <4E609B0A.1020804@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "G, Manjunath Kondaiah" <manjugk@ti.com>

* Cousson, Benoit <b-cousson@ti.com> [110902 11:26]:
> On 9/2/2011 10:12 AM, Tony Lindgren wrote:
> >* Benoit Cousson<b-cousson@ti.com>  [110901 19:52]:
> >>In order to avoid conflict with the new board-omap3-dt.c file,
> >>remove the .dt_compat entry from the beagle regular board
> >>file.
> >>
> >>Any DT work for OMAP3 will have to be done on the generic DT
> >>board file to avoid breaking the legacy board support until
> >>DT migration is done.
> >
> >In general we should not keep duplicate old non-DT data around
> >now that we have the DT append support. Instead we should just
> >require the .dts file appended to zImage for all mach-omap2
> >machines. Otherwise we'll end up with double bloat :)
> 
> Mmm, I'm not sure to get your point. We are not duplicating, since a
> pure DT generic board will not have anything except a
> of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
> And the regular board files will keep initializing devices statically.
> The drivers will then for the moment support both pdata and DT
> method to get board parameters.

Well when converting a driver to DT, we should just drop pdata
support. No need to keep it around as it will just make it harder
for us to clean up afterwards.
 
> >So it's OK to have the DT entries in board files so drivers
> >that get converted will work with them.
> 
> Well, it will be a little bit more tricky, because having DT in
> current board files will be a mess with a bunch of #ifdef CONFIG_OF,
> and adding DT compatible inside each boards will prevent the pure
> generic DT one to work. In that case we will duplicate the DT
> migration in every legacy boards files...

We should just select CONFIG_OF deal with it that way.
 
> That's why the current strategy is to keep the current board files
> non-DT aware and add the DT support only to the generic DT board
> file.

Well I don't like that, it will be a big mess. We'll end up with
twice the amount of platform_data and init code. It's OK to
require CONFIG_OF as it's known to work with the append support
for older boards.

It's easier just to require DT append for all the boards. In most
cases it's just a trivial include of the common dts file for now.

When we convert something to DT, there's no point going back.

Regards,

Tony
