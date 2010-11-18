From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/5] OMAP4: mux: Initialise OMAP4 mux pins.
Date: Thu, 18 Nov 2010 11:06:51 -0800
Message-ID: <20101118190650.GK9264@atomide.com>
References: <1289806685-20688-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56297 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107Ab0KRTG4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Nov 2010 14:06:56 -0500
Content-Disposition: inline
In-Reply-To: <1289806685-20688-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sricharan <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org

* sricharan <r.sricharan@ti.com> [101114 23:26]:
> This series updates the core device drivers to use mux framework
> for OMAP4 SDP and PANDA board. It's generated against the
> linux-omap master branch. It has a dependency on the Benoit's
> omap4 mux data series.

<snip>
 
> 2. Do PAD configuration independently for each module
> Pros:
> 	a. Avoids repetition of similar data for different boards.
> 	b. Gives a knowledge of how pins are configured for a module
> 	   to the respective owners.
> 	c. Pads are not initialised unless they are really needed.
> Cons:
> 	a. Can become difficult to maintain if lot of data tend to be 
> 	   different across boards.

For the common modules, we should have generic platform init code
using hwmod. And that init code is the logical place to do the muxing.

We also need to consider that the pin muxing is board specific.
So in cases where the are alternative signal paths, we need to pass
the signal names from board-*.c file to the platform driver init code.

Regards,

Tony
