From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] OMAPDSS: DT support for N900 panel
Date: Thu, 19 Dec 2013 08:42:31 -0800
Message-ID: <20131219163557.GM27438@atomide.com>
References: <1386958650-2404-1-git-send-email-sre@debian.org>
 <52AFFF3F.7020807@ti.com>
 <20131217171412.GA10442@earth.universe>
 <52B089FE.8060704@ti.com>
 <20131218215536.GA23674@earth.universe>
 <20131219005151.GA27928@earth.universe>
 <52B2848A.80807@ti.com>
 <20131219100840.GA923@earth.universe>
 <20131219135608.GA11654@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63763 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755877Ab3LSQmj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Dec 2013 11:42:39 -0500
Content-Disposition: inline
In-Reply-To: <20131219135608.GA11654@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org

* Sebastian Reichel <sre@debian.org> [131219 05:57]:
> On Thu, Dec 19, 2013 at 11:08:40AM +0100, Sebastian Reichel wrote:
> > > Are you able to check if the bootloader muxes dat3 to SDI mode?
> > 
> > The bootloader's source code is not available as far as i know.
> > 
> > [...], but I get an external abort on non-linefetch.
> > So I can't check it :(
> 
> Ok. This is fixed by applying [0] (Thanks for the hint, Tomi!).
> This is the mux configuration from the bootloader:
> 
> ...
> pin 96 (480020f0.0) 00000001 pinctrl-single     // sdi dat1n
> pin 97 (480020f2.0) 00000001 pinctrl-single     // sdi dat1p
> pin 98 (480020f4.0) 00000001 pinctrl-single     // sdi dat2n
> pin 99 (480020f6.0) 00000001 pinctrl-single     // sdi dat2p
> pin 100 (480020f8.0) 00000007 pinctrl-single    // sdi dat3n
> pin 101 (480020fa.0) 00000007 pinctrl-single    // sdi dat3p
> pin 102 (480020fc.0) 00000004 pinctrl-single 
> pin 103 (480020fe.0) 00000004 pinctrl-single 
> pin 104 (48002100.0) 00000004 pinctrl-single    // sdi vsync
> pin 105 (48002102.0) 00004104 pinctrl-single    // sdi hsync
> pin 106 (48002104.0) 00000004 pinctrl-single    // sdi den
> pin 107 (48002106.0) 00000004 pinctrl-single    // sdi stp
> pin 108 (48002108.0) 00000001 pinctrl-single    // sdi clkp
> pin 109 (4800210a.0) 00000001 pinctrl-single    // sdi clkn
> ...
> 
> I guess the following entry should be added to the omap3-n900.dts file:
> 
> 	dss_sdi_pins: pinmux_dss_sdi_pins {
> 		pinctrl-single,pins = <
> 			0x0c0 (PIN_OUTPUT | MUX_MODE1)   /* dss_data10.sdi_dat1n */
> 			0x0c2 (PIN_OUTPUT | MUX_MODE1)   /* dss_data11.sdi_dat1p */
> 			0x0c4 (PIN_OUTPUT | MUX_MODE1)   /* dss_data12.sdi_dat2n */
> 			0x0c6 (PIN_OUTPUT | MUX_MODE1)   /* dss_data13.sdi_dat2p */
> 			0x0d8 (PIN_OUTPUT | MUX_MODE1)   /* dss_data22.sdi_clkp */
> 			0x0da (PIN_OUTPUT | MUX_MODE1)   /* dss_data23.sdi_clkn */
> 		>;
> 	};
> 
> [0] https://patchwork.kernel.org/patch/3283781/

Do we need to update Laurent's patch with this? Or can we use it as
it is and maybe you can ack it?

Regards,

Tony
