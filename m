From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 5/9] ARM: dts: omap3-overo: Add HSUSB PHY
Date: Mon, 10 Mar 2014 11:03:42 -0700
Message-ID: <20140310180341.GC4882@atomide.com>
References: <1394220139-1760-1-git-send-email-florian.vaussard@epfl.ch>
 <1394220139-1760-6-git-send-email-florian.vaussard@epfl.ch>
 <531D9452.6040501@ti.com>
 <531DD6A8.7010406@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:10409 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbaCJSDt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Mar 2014 14:03:49 -0400
Content-Disposition: inline
In-Reply-To: <531DD6A8.7010406@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: Roger Quadros <rogerq@ti.com>, Benoit Cousson <bcousson@baylibre.com>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Florian Vaussard <florian.vaussard@epfl.ch> [140310 08:17]:
> On 03/10/2014 11:30 AM, Roger Quadros wrote:
> >
> > If you don't use the OMAP3x30_CORE2_IOPAD() macro then these definitions can fit in omap3-overo-base.dtsi.
> > The offsets will be taken care of if you place them within &omap3_pmx_core2 {} . e.g.
> > 
> > +                       0x50 (PIN_OUTPUT | MUX_MODE3)           /* etk_d10.hsusb2_clk */
> > +                       0x52 (PIN_OUTPUT | MUX_MODE3)           /* etk_d11.hsusb2_stp */
> > +                       0x54 (PIN_INPUT_PULLDOWN | MUX_MODE3)   /* etk_d12.hsusb2_dir */
> > +                       0x56 (PIN_INPUT_PULLDOWN | MUX_MODE3)   /* etk_d13.hsusb2_nxt */
> > +                       0x58 (PIN_INPUT_PULLDOWN | MUX_MODE3)   /* etk_d14.hsusb2_data0 */
> > +                       0x5a (PIN_INPUT_PULLDOWN | MUX_MODE3)   /* etk_d15.hsusb2_data1 */
> > 
> > Do you think this is better?
> > 
> 
> I do not think that this could work. Let's take for example hsusb2_clk
> et let's do the math. Here, 0x50 is the offset inside omap3_pmx_core2
> pinctrl, so:
> 
>         hsusb2_clk  omap3_pmx_core2      hsusb2_clk
>          offset        base addr.       PADCONF addr.
>           ----        ----------         ----------
> OMAP34xx: 0x50        0x480025d8         0x48002628  *NO*
> OMAP36xx: 0x50        0x480025a0         0x480025F0  *ok*
> 
> Looking at the TRM, the PADCONF address for hsusb2_clk is 0x480025F0 in
> both cases. Thus we will be wrong on OMAP34xx (offset should be 0x18
> instead of 0x50). Thus so far, I do not see any magical solution apart
> putting the omap3_pmx_core2 pins in a SoC-dependant .dtsi file.
> 
> I already expressed my concerns [1] about having a different base
> address for omap3_pmx_core2 depending on the SoC (although I do
> understand the rational behind). This makes cross-SoC platforms more
> difficult to maintain.

Yeah the muxing should always be possible to do at board level.

Just the use of external pulls for some boards will make it hard
to have anything common. If you want something common, you can
have something like omap36xx-usb-xyz.dtsi as long as it's always
wired up the same way.

Regards,

Tony
 
> [1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/289874
> 
