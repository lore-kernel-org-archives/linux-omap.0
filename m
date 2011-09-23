From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 07/11] OMAP2+: board-generic: Add DT support to generic
 board
Date: Fri, 23 Sep 2011 16:08:45 -0700
Message-ID: <20110923230845.GD6324@atomide.com>
References: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
 <1316809399-19579-8-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:21599 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900Ab1IWXIv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Sep 2011 19:08:51 -0400
Content-Disposition: inline
In-Reply-To: <1316809399-19579-8-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: grant.likely@secretlab.ca, paul@pwsan.com, khilman@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

* Benoit Cousson <b-cousson@ti.com> [110923 12:50]:
> Re-cycle the original board-generic file to support Device Tree
> for every OMAP2+ variants.
> Note: Since it is a completely new content in the existing file
> I removed the original copyright.

I'd suggest just keeping it, maybe just update the comments
accordingly?

That's because Copyrights in general just don't "disappear".

And the meaning of the board-generic is still the same as originally,
that is do the booting based on board-specific data passed from
the bootloader like the comments say:

> - * Code for generic OMAP2 board. Should work on many OMAP2 systems where
> - * the bootloader passes the board-specific data to the kernel.
> - * Do not put any board specific code to this file; create a new machine
> - * type if you need custom low-level initializations.
> + * Support for generic OMAP2+ device tree boards.

Regards,

Tony
