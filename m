From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/11] ARM: OMAP4+: AESS: enable internal auto-gating
 during initial setup
Date: Thu, 7 Jun 2012 00:19:00 -0700
Message-ID: <20120607071900.GW12766@atomide.com>
References: <20120607060901.25532.68354.stgit@dusk>
 <20120607061306.25532.59488.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55402 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952Ab2FGHTE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 03:19:04 -0400
Content-Disposition: inline
In-Reply-To: <20120607061306.25532.59488.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

* Paul Walmsley <paul@pwsan.com> [120606 23:26]:
> Enable the AESS auto-gating control bit during AESS hwmod setup.  This
> fixes the following boot warning on OMAP4:
> 
> omap_hwmod: aess: _wait_target_disable failed
> 
> Without this patch, the AESS IP block does not indicate to the PRCM
> that it is idle after it is reset.  This prevents some types of SoC
> power management until something sets the auto-gating control bit.

I don't like the idea of having custom platform init code for every driver
to reset it, let's see if there's some better way to deal with stuff like
this.

It seems that most/many IP blocks need their custom reset hacks, and it's
not limited to just few instances?

Maybe we can distribute custom hacks like this to the drivers? If there is
no generic way to reset some IP block, then the driver should pass it's
whatever workaround bits/methdod/ to the bus level (hwmod) code during the
init rather than piling up all the possible hacks to the bus level code.

This way the driver init can still do the bus level reset during it's init,
and bail out after that if the module is not in use for the board in question.
That is already being flagged in device tree with status = "disable" flag,
and can also passed in platform data if necessary.

AFAIK there's no need to reset the IP blocks before the driver init, it's
really needed for PM. So it's not needed early on, and it's OK to require
running  the driver init for driver modules that are not in use to reset
them properly. After all, the hardware is on the device, even if it's not
being used.

Regards,

Tony
