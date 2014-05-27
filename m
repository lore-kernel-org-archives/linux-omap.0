From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v7 2/4] ARM: dts: am437x-gp-evm: add support for parallel
 NAND flash
Date: Tue, 27 May 2014 14:19:44 -0700
Message-ID: <20140527211943.GG32336@atomide.com>
References: <1400490948-11571-1-git-send-email-pekon@ti.com>
 <1400490948-11571-3-git-send-email-pekon@ti.com>
 <20140519220659.GF11945@atomide.com>
 <20980858CB6D3A4BAE95CA194937D5E73EACE46E@DBDE04.ent.ti.com>
 <20140520055258.GB27152@atomide.com>
 <20980858CB6D3A4BAE95CA194937D5E73EACE4F3@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:26234 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414AbaE0VTw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 May 2014 17:19:52 -0400
Content-Disposition: inline
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EACE4F3@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Stefan Roese <sr@denx.de>, Javier Martinez Canillas <javier@dowhile0.org>, "Quadros, Roger" <rogerq@ti.com>

* Gupta, Pekon <pekon@ti.com> [140519 23:10]:
> From: Tony Lindgren [mailto:tony@atomide.com]
> >* Gupta, Pekon <pekon@ti.com> [140519 21:07]:
> >> From: Tony Lindgren [mailto:tony@atomide.com]
> >> >* Pekon Gupta <pekon@ti.com> [140519 02:16]:
> >> >> Adds pinmux and DT node for Micron (MT29F4G08AB) x8 NAND device present on
> >> >> am437x-gp-evm board.
> >> >> (1) As NAND Flash data lines are muxed with eMMC, Thus at a given time either
> >> >>     eMMC or NAND can be enabled. Selection between eMMC and NAND is controlled:
> >> >>     (a) By dynamically driving following GPIO pin from software
> >> >>         SPI2_CS0(GPIO) == 0 NAND is selected (default)
> >> >>         SPI2_CS0(GPIO) == 1 eMMC is selected
> >> >>     (b) By statically using Jumper (J89) on the board
> >> >
> >> >So which MMC controller has eMMC then? How do we select which one we
> >> >have enabled in the am437x-gp-evm.dts by default?
> >> >
> >> If there is no Jumper on the board, then driving SPI2_CS0 before device
> >> probe decides the selection between NAND and eMMC. Therefore NAND
> >> pin-mux also includes SPI2_CS0 and enables PULLDOWN on it to select NAND.
> >
> >So do they share lines outside omap, not inside omap?
> >
> >The reason I'm asking is I'm worried about the conflicting
> >pinctrl settings if we try to use both. And I guess that's
> >not an issue if the muxing of lines is done outside the
> >omap?
> >
> Yes, the muxing is outside OMAP SoC, so if SPI2_CS0 is correctly
> driven it will not allow contention on GPMC line (as per board design).
> 
> On am437x-gp-evm board, SPI2_CS0 is used to:
> - route GPMC signals to selected device {eMMC | NAND}.
> - keep the de-selected device {eMMC | NAND} in reset.

OK thanks for clarifying that, applying into omap-for-v3.16/dt-v2.

Regards,

Tony
