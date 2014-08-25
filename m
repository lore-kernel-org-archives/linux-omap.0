From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: fix gpmc_cs_remap: re-allocating
 chip-select address space based on DT
Date: Mon, 25 Aug 2014 09:45:32 -0700
Message-ID: <20140825164532.GJ17254@atomide.com>
References: <1406139458-11676-1-git-send-email-pekon@ti.com>
 <20140822230132.GI10066@atomide.com>
 <53FB124F.5000408@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:29850 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbaHYQph (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Aug 2014 12:45:37 -0400
Content-Disposition: inline
In-Reply-To: <53FB124F.5000408@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: pekon <pekon@pek-sem.com>, linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier@dowhile0.org>

* Roger Quadros <rogerq@ti.com> [140825 03:39]:
> Hi Tony,
> 
> On 08/23/2014 02:01 AM, Tony Lindgren wrote:
> > * Pekon Gupta <pekon@ti.com> [140723 11:20]:
> >> Each GPMC chip-select needs to be configured for (base-address,CS-size) so that
> >> GPMC understands the address-space allocated to device connected externally.
> >> These chip-select configurations (base-address, CS-size) follow some basic
> >> mapping rules like:
> >> - The CS size is programmable from 256 MBytes to 16 MBytes (must be a power of 2)
> >>   and is defined by the mask field. Attached memory smaller than the programmed
> >>   CS region size is accessed through the entire CS region (aliasing).
> >> - The programmed 'base-address' must be aligned to the 'CS-size' boundary and
> >>   be a power of 2.
> >> - Valid CS-size values are {256MB(max), 128MB, 64MB, 32MB and 16MB (min)}
> >>   Any intermediate values creates holes in the chip-select memory-map.
> >>
> >> This patch adds above checks in gpmc_cs_remap() so that any invalid value
> >> passed by DT <reg> property can be filtered before actually allocating the
> >> address space.
> >>
> >> Signed-off-by: Pekon Gupta <pekon@ti.com>
> > 
> > Looks like size typos Roger mentioned are fixed in this one, so
> > applying into omap-for-v3.17/fixes thanks.
> 
> I don't see the typos fixed here. I'll reply with a v2 patch.

Oops indeed. I'll redo the fixes branch to avoid extra churn
and apply your updated version into omap-for-v3.17/fixes-v2.

Regards,

Tony
