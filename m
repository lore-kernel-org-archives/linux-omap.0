From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/55]: ARM: OMAP2+: PRCM move to drivers
Date: Mon, 31 Mar 2014 15:09:04 -0700
Message-ID: <20140331220903.GA11328@atomide.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:44145 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbaCaWJK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Mar 2014 18:09:10 -0400
Content-Disposition: inline
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [140331 08:20]:
> Hi,
> 
> This set is continuation for the work started earlier to cleanup the CM/PRM
> and attempt to make it a separate driver. This set depends on these
> two sets:
> 
> CM/PRM cleanup set:
> http://marc.info/?l=linux-omap&m=139395000918201&w=2
> 
> OMAP2 clock DT set:
> http://comments.gmane.org/gmane.linux.ports.arm.omap/111257
> 
> This set is pretty huge but the patches can be applied in stages if need be.
> Anyway, it would be good to get some feedback whether the driver folder
> locations etc. are good, and whether the effort taken here will be enough
> to actually move the driver. Clockdomain / powerdomain code can also be
> moved easily under the drivers/power/omap folder (or someplace else if
> requested) once this set is in. Also, clockdomain / powerdomain data
> should be possible to convert to DT format or some sort of firmware
> blob once this is done.

Good to see this happening :)
 
> Patch #55 in this set is pretty massive as it moves all the C files at
> the same time, this should probably be split up as multiple patches.

Maybe try to break this series into few smaller sets of patches?

Then a diffstat with these kind of large patch sets would be nice
in the cover letter to get some kind of idea what's going on :)

Browsing through the set it seems that all the patches in this
series moving register defines "to a public location" are bad news.

We don't want to make access to these registers available without
proper frameworks as that will lead into misuse by various drivers.
And cleaning up that mess later in is a huge pain.

To avoid that, you can probably do something like this:

1. Set up the PRCM registers as multiple regmap areas

See for example these commits in linux next how one of the SCM misc
register areas is now available for drivers as tisyscon defined
in the .dts files:

11469e0bb1c5 regulator: add pbias regulator support
cd042fe5c1f6 ARM: dts: add pbias dt node

So basically we now have drivers/regulators/pbias-regulator.c
that claims some of the tisyscon registers and implements a
regulator. Then the MMC driver can just use the standard regulator
related functions.

It seems that you can set up multiple PRCM register ranges in a
similar way as regmap ranges and that way partition the PRCM
register areas to something that's private to individual drivers.

2. Have the core PRCM driver(s) claim some of the regmap ranges

Some PRCM features can potentially be implemented using existing
Linux generic frameworks where possible for clocks, regulators, reset
drivers etc. That way you can keep the register defines for these
ranges private to the core PRCM driver(s). Ideally with no need
to add _any_ custom exported functions here.

3. Have the other drivers claim some regmap ranges

The register ranges that are clearly owned by some driver should
be claimed by those drivers. Then the defines for those registers
can stay private to that driver. Some drivers that can probably
own some PRCM ranges are clock drivers and voltage related drivers.

Regards,

Tony
