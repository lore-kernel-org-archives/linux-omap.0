From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 4/7] ARM: dts: omap3-overo: Add HSUSB PHY
Date: Wed, 5 Mar 2014 11:39:03 -0800
Message-ID: <20140305193903.GB7599@atomide.com>
References: <1393839247-6516-1-git-send-email-florian.vaussard@epfl.ch>
 <1393839247-6516-5-git-send-email-florian.vaussard@epfl.ch>
 <53146166.4050906@ti.com>
 <53147A19.5070009@epfl.ch>
 <53147E82.6030300@ti.com>
 <5316D9D7.9070100@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:48453 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754326AbaCETjM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Mar 2014 14:39:12 -0500
Content-Disposition: inline
In-Reply-To: <5316D9D7.9070100@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: Roger Quadros <rogerq@ti.com>, Benoit Cousson <bcousson@baylibre.com>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Florian Vaussard <florian.vaussard@epfl.ch> [140305 00:04]:
> On 03/03/2014 02:07 PM, Roger Quadros wrote:
> > 
> > Putting usb host pins in omap3-overo.dtsi implies that all Overo expansion boards will use it
> > but that is not always the case. Any expansion board vendor can decide not to use USB host feature.
> > 
> 
> I do agree that this can be the case. So it makes sense to push the
> USB host down to expansion boards.
> 
> Now how to do it? The omap3_pmx_core part can be put in
> omap3-overo-tobi-common.dtsi. But unfortunately, the omap3_pmx_core2
> part cannot
> be factorized between the two variants, as one has to use a different
> macro for each case (OMAP3430_CORE2_IOPAD vs. OMAP3630_CORE2_IOPAD).
> Including the right .dtsi file is not enough.

FYI, it's best to have the mux registers board specific and separate
because the mux settings can depend on the SoC revision or even
packaging.
 
> As it can be seen from include/dt-bindings/pinctrl/omap.h, even if the
> padconf register physical address is identical for both SoCs, the offset
> inside omap3_pmx_core2 will be different (as the start of
> omap3_pmx_core2 is 0x480025d8 for omap34xx and 0x480025a0 for omap36xx).
> 
> Thus the pins belonging to omap3_pmx_core2 must be in a SoC-dependent
> .dtsi file.

It seems we need a top level .dts file incuding the right SoC and
pinconf settings.
 
> I will post a v4 with a new proposition. Thanks for your inputs.

OK as that might change the other patches too let's wait for that.

Regards,

Tony
