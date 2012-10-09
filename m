From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP: move old debug-devices.c and debug-leds.c to
 be OMAP2+ only for now
Date: Tue, 9 Oct 2012 20:11:20 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210092008370.5736@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210080145080.5736@utopia.booyaka.com> <20121008221333.GZ13011@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:58496 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753189Ab2JIULU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Oct 2012 16:11:20 -0400
In-Reply-To: <20121008221333.GZ13011@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grinberg@compulab.co.il

On Mon, 8 Oct 2012, Tony Lindgren wrote:

> Hmm are you sure that omap1 is not using debug-leds.c?
> At least the initcall seems like it should run on omap1
> if enabled.

You're right, it's probably able to run on OMAP1.  Looks like I got 
confused by the bogus Kconfig dependency from OMAP_DEBUG_LEDS -> 
OMAP_DEBUG_DEVICES, since debug_card_init() is only called from the H4 
board init.

> The sideways include here is OK, it does not get exposed to
> the drivers, it seems that plat-omap is still the right location
> for at least debug-leds.c code.

OK if you want to leave it there, it's fine with me.  Looks like it 
should go into drivers/ at some point though?

Will send a patch to do the sideways include to fix the sparse warning.


- Paul
