From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] ARM: omap/dts: Add support for Gumstix Overo with
 Tobi expansion
Date: Thu, 6 Sep 2012 13:52:28 -0700
Message-ID: <20120906205227.GM1303@atomide.com>
References: <1346429172-5902-1-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:21030 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933124Ab2IFUwa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 16:52:30 -0400
Content-Disposition: inline
In-Reply-To: <1346429172-5902-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Benoit Cousson <b-cousson@ti.com>, Steve Sakoman <steve@sakoman.com>, Philippe Retornaz <philippe.retornaz@epfl.ch>, linux-arm-kernel@lists.infradead.org

* Florian Vaussard <florian.vaussard@epfl.ch> [120831 09:07]:
> The Gumstix Overo is a computer on module using an OMAP3 processor.
> This module must be plugged into an expansion board.
> 
> This patchset adds a first device tree support for the Overo, using the
> Tobi expansion board. The current support is able to boot and mount
> the rootfs from MMC, with a few extra features.
> 
> The first patch creates the device tree for both the Overo and the
> Tobi expansion board, and updates the dtb build target.
> 
> The second patch updates the omap/dts documentation.
> 
> This patchset applies on tony's tree [1], devel-dt branch.

Great, I'm assuming Benoit will pick this up as well.

Regards,

Tony
 
> Regards,
> 
> Florian
> 
> [1] http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=summary
> 
> 
> Florian Vaussard (2):
>   ARM: omap/dts: Add support for Gumstix Overo with Tobi expansion
>     board
>   ARM: omap/dts: update the documentation
> 
>  .../devicetree/bindings/arm/omap/omap.txt          |    3 +
>  arch/arm/boot/dts/omap3-overo.dtsi                 |   42 ++++++++++++++++++++
>  arch/arm/boot/dts/omap3-tobi.dts                   |   35 ++++++++++++++++
>  arch/arm/mach-omap2/Makefile.boot                  |    2 +-
>  4 files changed, 81 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/boot/dts/omap3-overo.dtsi
>  create mode 100644 arch/arm/boot/dts/omap3-tobi.dts
> 
> -- 
> 1.7.5.4
> 
