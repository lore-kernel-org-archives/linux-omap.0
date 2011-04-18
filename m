From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH v2] Consolidate SRAM support
Date: Mon, 18 Apr 2011 14:33:36 +0300
Message-ID: <20110418113335.GL12272@atomide.com>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
 <20110418085259.GA26044@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:22880 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267Ab1DRLdp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Apr 2011 07:33:45 -0400
Content-Disposition: inline
In-Reply-To: <20110418085259.GA26044@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110418 11:50]:
> This is the second revision of this patch.  I've not moved it out of
> ARM yet as I haven't had a positive response from SH yet.
> 
> It's now called pv_pool (for phys/virt pool) rather than sram_pool,
> and I've included MXC's iram support in this.  Hopefully, if OMAP can
> remove the FB stuff from SRAM we can clean the OMAP bits up a little
> more.  Neither have I sorted out the last reference to omap_sram_ceil.
> Some comments from OMAP people on what's going on there would be good.

I believe the omap_sram_ceil should also disappear with the omapfb
SRAM patch.

Tony
