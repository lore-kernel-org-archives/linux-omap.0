From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 7/7] ARM: dts: Enable emmc on hp t410
Date: Fri, 4 Dec 2015 08:00:38 -0800
Message-ID: <20151204160038.GI23396@atomide.com>
References: <1449192335-10137-1-git-send-email-tony@atomide.com>
 <1449192335-10137-8-git-send-email-tony@atomide.com>
 <56615AF9.5000208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <56615AF9.5000208@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Philipp Rosenberger <ilu@linutronix.de>, Delio Brignoli <dbrignoli@audioscience.com>, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [151204 01:21]:
> On 12/04/2015 03:25 AM, Tony Lindgren wrote:
> > There's a 2GB emmc on hp t410 that's wired to the sd_2 interface.
> > Note that we also need to configure the evtmux using edma_xbar for
> > edma channels.
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> One question inlined for the mmc3, other than that:
> Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> > ---
> >  arch/arm/boot/dts/dm8148-t410.dts | 35 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/dm8148-t410.dts b/arch/arm/boot/dts/dm8148-t410.dts
> > index 79838dd..d1927a7 100644
> > --- a/arch/arm/boot/dts/dm8148-t410.dts
> > +++ b/arch/arm/boot/dts/dm8148-t410.dts
> > @@ -15,6 +15,13 @@
> >  		device_type = "memory";
> >  		reg = <0x80000000 0x40000000>;	/* 1 GB */
> >  	};
> > +
> > +	vmmcsd_fixed: fixedregulator@0 {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vmmcsd_fixed";
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +	};
> >  };
> >  
> >  &cpsw_emac0 {
> > @@ -26,3 +33,31 @@
> >  	phy_id = <&davinci_mdio>, <1>;
> >  	phy-mode = "rgmii";
> >  };
> > +
> > +&mmc3 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&sd2_pins>;
> > +	vmmc-supply = <&vmmcsd_fixed>;
> > +	bus-width = <8>;
> > +	dmas = <&edma_xbar 8 0 1	/* use SDTXEVT1 instead of MCASP0TX */
> > +		&edma_xbar 9 0 2>;	/* use SDRXEVT1 instead of MCASP0RX */
> > +	dma-names = "tx", "rx";
> 
> Do you happened to know how the audio is connected on the board?
> The DM814x-EVM seams to be using McASP2 with aic3106 so it is possible that HP
> copied the design from there...

I grepped the sources for it and these are the evtmux channels the original
code is using. So maybe they have some different audio setup, the hacks in the
original board file mention "hdmi-dai".

Regards,

Tony
