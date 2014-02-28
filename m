From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/11] ARM: dts: sbc-t3x: add support for more boards
Date: Fri, 28 Feb 2014 14:12:20 -0800
Message-ID: <20140228221219.GH13624@atomide.com>
References: <1389532975-28281-1-git-send-email-lifshitz@compulab.co.il>
 <52FB6B2E.9070106@compulab.co.il>
 <5309E9EE.2040705@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:14822 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751711AbaB1WMe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Feb 2014 17:12:34 -0500
Content-Disposition: inline
In-Reply-To: <5309E9EE.2040705@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>, Benoit Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [140223 04:33]:
> ping x2!

Thanks applying into omap-for-v3.15/dt finally.

Is it OK to remove the board-cm-*.c files for v3.15?

Regards,

Tony
 
> On 02/12/14 14:38, Igor Grinberg wrote:
> > ping!
> > 
> > On 01/12/14 15:22, Dmitry Lifshitz wrote:
> >> Add support for CompuLab SBC-T3530 and SBC-T3517 boards:
> >>
> >> https://compulab.co.il/products/sbcs/sbc-t3530/
> >> https://compulab.co.il/products/sbcs/sbc-t3517/
> >>
> >> along with respective CoMs - CM-T3530 and CM-T3517:
> >>
> >> https://compulab.co.il/products/computer-on-modules/cm-t3530/
> >> https://compulab.co.il/products/computer-on-modules/cm-t3517/
> >>
> >> The device tree files have the following structure:
> >>
> >> omap3-cm-t3x.dtsi
> >>  |
> >>  |<-- omap3-cm-t3x30.dtsi
> >>  |     |
> >>  |     |
> >>  |     |     -----                  -------          ------------
> >>  |     |    | CoM |                | Board |        | Base board |
> >>  |     |     -----                  -------          ------------
> >>  |     |                                            omap3-sb-t35.dtsi
> >>  |     |                                                  |
> >>  |     |<-- omap3-cm-t3730.dts <-- omap3-sbc-t3730.dts -->|
> >>  |     |                                                  |
> >>  |     |<-- omap3-cm-t3530.dts <-- omap3-sbc-t3530.dts -->|
> >>  |                                                        |
> >>  |<-------- omap3-cm-t3517.dts <-- omap3-sbc-t3517.dts -->|
> >>
> >>
> >> where omap3-cm-t3730.dts, omap3-cm-t3530.dts, omap3-cm-t3517.dts
> >> contain CoMs specific data, while omap3-sbc-t3730.dts, omap3-sbc-t3530.dts,
> >> omap3-sbc-t3517.dts represent eval boards with respective core modules.
> >>
> >> This series is based on Tony's omap-for-v3.14/dt branch
> >>
> >> Dmitry Lifshitz (11):
> >>   ARM: dts: sbc-t3x: refactor DT support
> >>   ARM: dts: sbc-t3x: disable mmc3
> >>   ARM: dts: sb-t35: fix Ethernet power supply
> >>   ARM: dts: cm-t3x: add gpio-led pinmux
> >>   ARM: dts: cm-t3x30: add twl4030 gpio pullups
> >>   ARM: dts: cm-t3x30: add HS USB Host support
> >>   ARM: dts: sbc-t3730: add pinmux for usb hub reset
> >>   ARM: dts: cm-t3x30: add USB OTG support
> >>   ARM: dts: sbc-t3530: add support for sbc-t3530
> >>   ARM: dts: sbc-t3517: add support for sbc-t3517
> >>   ARM: OMAP2+: make reset pulse for sbc-t3x usb hubs
> >>
> >>  arch/arm/boot/dts/Makefile            |    4 +
> >>  arch/arm/boot/dts/omap3-cm-t3517.dts  |  137 +++++++++++++++++++++++++++++++++
> >>  arch/arm/boot/dts/omap3-cm-t3530.dts  |   13 +++
> >>  arch/arm/boot/dts/omap3-cm-t3730.dts  |   40 ----------
> >>  arch/arm/boot/dts/omap3-cm-t3x.dtsi   |  112 +++++++++++++++++++++++++++
> >>  arch/arm/boot/dts/omap3-cm-t3x30.dtsi |   74 +++++++++++++-----
> >>  arch/arm/boot/dts/omap3-sb-t35.dtsi   |   30 +++++++-
> >>  arch/arm/boot/dts/omap3-sbc-t3517.dts |   44 +++++++++++
> >>  arch/arm/boot/dts/omap3-sbc-t3530.dts |   37 +++++++++
> >>  arch/arm/boot/dts/omap3-sbc-t3730.dts |   24 +++---
> >>  arch/arm/mach-omap2/pdata-quirks.c    |   67 ++++++++++++++++-
> >>  11 files changed, 506 insertions(+), 76 deletions(-)
> >>  create mode 100644 arch/arm/boot/dts/omap3-cm-t3517.dts
> >>  create mode 100644 arch/arm/boot/dts/omap3-cm-t3530.dts
> >>  create mode 100644 arch/arm/boot/dts/omap3-cm-t3x.dtsi
> >>  create mode 100644 arch/arm/boot/dts/omap3-sbc-t3517.dts
> >>  create mode 100644 arch/arm/boot/dts/omap3-sbc-t3530.dts
> >>
> > 
> 
> -- 
> Regards,
> Igor.
