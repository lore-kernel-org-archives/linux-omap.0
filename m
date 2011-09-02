From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 7/7] OMAP3: beagleboard: Remove DT support from regular
 board
Date: Fri, 2 Sep 2011 11:12:46 +0300
Message-ID: <20110902081246.GQ3548@atomide.com>
References: <1314897912-18178-1-git-send-email-b-cousson@ti.com>
 <1314897912-18178-8-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:40083 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758175Ab1IBIMt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Sep 2011 04:12:49 -0400
Content-Disposition: inline
In-Reply-To: <1314897912-18178-8-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: grant.likely@secretlab.ca, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, manjugk@ti.com

* Benoit Cousson <b-cousson@ti.com> [110901 19:52]:
> In order to avoid conflict with the new board-omap3-dt.c file,
> remove the .dt_compat entry from the beagle regular board
> file.
> 
> Any DT work for OMAP3 will have to be done on the generic DT
> board file to avoid breaking the legacy board support until
> DT migration is done.

In general we should not keep duplicate old non-DT data around
now that we have the DT append support. Instead we should just
require the .dts file appended to zImage for all mach-omap2
machines. Otherwise we'll end up with double bloat :)

So it's OK to have the DT entries in board files so drivers
that get converted will work with them.

Tony
