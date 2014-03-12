From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/7] ARM: dts: overo: Add new expansion boards
Date: Wed, 12 Mar 2014 10:22:48 -0700
Message-ID: <20140312172247.GC30897@atomide.com>
References: <1394540435-25401-1-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:50405 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756103AbaCLRW4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Mar 2014 13:22:56 -0400
Content-Disposition: inline
In-Reply-To: <1394540435-25401-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: Benoit Cousson <bcousson@baylibre.com>, Roger Quadros <rogerq@ti.com>, Nishanth Menon <nm@ti.com>, Ash Charles <ash@gumstix.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Florian Vaussard <florian.vaussard@epfl.ch> [140311 05:24]:
> Hi,
> 
> This series adds the support for 5 new expansion boards from Gumstix:
> - Palo43
> - Gallop43
> - Chestnut43
> - Alto35
> - Summit
> 
> The 1st patch is a preparatory work, in order to factorize some
> peripherals that are common to most Gumstix expansion boards. Patch 2
> adds the support for an accelerometer that is present on most boards.
> 
> Palo43, Gallop43 and Chestnut43 are all pretty similar. I tested
> on a Gallop43 (with both OMAP35xx and OMAP36xx Overo).
> 
> Alto35 is slightly different. Again, I tested with both OMAP35xx and
> OMAP36xx Overo.
> 
> Summit is pretty similar to Tobi. I do not have a Summit at hand,
> but given the similarity with Tobi, it should work fine.
> 
> To avoid unnecessary duplications, I put all the common stuff for each
> board inside an omap3-overo-xxx-common.dsti include file. By doing so,
> I can have minimal SoC-specific omap3-overo-xxx.dts (omap34xx based)
> and omap3-overo-storm-xxx.dts (omap36xx based) device trees.
> 
> This series depends on my previous Overo series [1]. A complete testing
> tree (including the graphics support, soon to be posted) is available
> at [2].

Thanks, applying the whole series into omap-for-v3.15/dt-overo.
As it's this close to the merge window, no guarantees anything
will get pulled in though.

Regards,

Tony
 
> [1] http://thread.gmane.org/gmane.linux.ports.arm.omap/111558
> [2] https://github.com/vaussard/linux.git (overo/for-3.15/review1)
