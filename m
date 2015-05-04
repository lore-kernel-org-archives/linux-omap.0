From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: dts: am57xx-beagle-x15: Switch UART mux pins
Date: Mon, 4 May 2015 09:24:31 -0700
Message-ID: <20150504162430.GM24469@atomide.com>
References: <1428618797-17190-1-git-send-email-nm@ti.com>
 <1428618797-17190-2-git-send-email-nm@ti.com>
 <20150409225600.GA17542@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:49003 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751374AbbEDQYd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 May 2015 12:24:33 -0400
Content-Disposition: inline
In-Reply-To: <20150409225600.GA17542@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [150409 15:57]:
> On 17:33-20150409, Nishanth Menon wrote:
> > BeagleBoard-X15 pre-production change includes switching over to UART
> > pins that now allow for UART download capability. All original boards
> > should either have been returned for modifications or already modified
> > for the required change and maintaining compatibility for older boards
> > are no longer needed.
> > 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> >  arch/arm/boot/dts/am57xx-beagle-x15.dts |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> > index 15f198e4864d..cea3be3a051c 100644
> > --- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
> > +++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> > @@ -130,8 +130,8 @@
> >  
> >  	uart3_pins_default: uart3_pins_default {
> >  		pinctrl-single,pins = <
> > -			0x248 (PIN_INPUT_SLEW | MUX_MODE0) /* uart3_rxd.rxd */
> > -			0x24c (PIN_INPUT_SLEW | MUX_MODE0) /* uart3_txd.txd */
> > +			0x3f8 (PIN_INPUT_SLEW | MUX_MODE2) /* uart2_ctsn.uart3_rxd */
> > +			0x3fc (PIN_INPUT_SLEW | MUX_MODE1) /* uart2_rtsn.uart3_txd */
> >  		>;
> >  	};
> >  
> > -- 
> > 1.7.9.5
> > 
> 
> Drat!.. I missed the daisychain merge that took place :( updated V2 patch
> below. Do let me know if you'd like me to repost this.

No need to repost, applying both into omap-for-v4.1/fixes thanks.

Regards,

Tony
