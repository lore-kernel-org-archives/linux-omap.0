From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 2/4] ARM: dts: Add ctrl-core DT node for DRA7
Date: Mon, 21 Apr 2014 08:10:34 -0700
Message-ID: <20140421151034.GA23945@atomide.com>
References: <1397654063-8055-1-git-send-email-archit@ti.com>
 <1397654063-8055-2-git-send-email-archit@ti.com>
 <20140418171854.GJ5354@atomide.com>
 <5354A970.8040605@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:60838 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751287AbaDUPKk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Apr 2014 11:10:40 -0400
Content-Disposition: inline
In-Reply-To: <5354A970.8040605@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Archit Taneja <archit@ti.com> [140420 22:16]:
> Hi,
> 
> On Friday 18 April 2014 10:48 PM, Tony Lindgren wrote:
> >* Archit Taneja <archit@ti.com> [140416 06:20]:
> >>Add DT node for the ctrl-core sub module of the DRA7 control module. We map the
> >>CTRL_MODULE_CORE address region up to 0x4a002d60, this region contains register
> >>fields which configure clocks. The remainder of the registers are related to
> >>pad configurations or cross-bar configurations, and therefore aren't mapped.
> >
> >Can you please check if this can just use the existing
> >regmap syscon mapping:
> >
> >syscon = <&dra7_ctrl_general>;
> >
> >See how the drivers/regulator/pbias-regulator.c is using the
> >syscon to initialize a regulator and then omap_hsmmc.c just does
> >the standard regulator calls.
> 
> The thing is that this bit needs to be set before the the DSS hwmods are
> reset, and that happens very early. If we don't do this, DSS won't reset
> properly, and not get back to an idle state.
> 
> I am not sure where I can configure the syscon register early enough that it
> happens before the hwmods are reset. With a syscon mapping, I guess we would
> access the register when the DSS driver is probed. But that's too late for
> us.
> 
> Ideally, it would be much better to have a syscon mapping. Do you have any
> suggestions how this can be achieved very early in boot?

It's best to move the reset and initialization of DSS happen later. I believe
we already are resetting only some of the hwmods early on.

Regards,

Tony
