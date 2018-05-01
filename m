From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: omap3-beagle-xm: Add fixed 26MHz clock as fck
 for twl
Date: Tue, 1 May 2018 08:18:16 -0700
Message-ID: <20180501151816.GM5671@atomide.com>
References: <20180405115239.17370-1-peter.ujfalusi@ti.com>
 <1b05ea2c-fa95-e5c7-2a37-4e0b46f62abc@ti.com>
 <065d346a-12a4-3dc6-d8a3-e5351a73a7ab@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <065d346a-12a4-3dc6-d8a3-e5351a73a7ab@ti.com>
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
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, bcousson@baylibre.com, linux-arm-kernel@lists.infradead.org, hns@goldelico.com
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [180406 07:01]:
> 
> 
> On 2018-04-05 16:15, Peter Ujfalusi wrote:
> > 
> > 
> > On 2018-04-05 14:52, Peter Ujfalusi wrote:
> >> The board uses 26MHz oscillator for the twl4030 HFCLK.
> >> This way we will not depend on the bootloader to configure the
> >> CFG_BOOT:HFCLK_FREQ
> >>
> >> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >> ---
> >> Hi,
> >>
> >> there might be other boards (all omap3 boards with twl4030?) which uses the same
> >> setup, but I only have schematics for beagle-xm.
> >>
> >> In order for the driver to actually use the clock the 
> >> [PATCH] mfd: twl-core: Fix clock initialization
> >> need to be applied. W/o the twl-core patch the clock is just ignored.
> >>
> >> Regards,
> >> Peter
> >>
> >>  arch/arm/boot/dts/omap3-beagle-xm.dts | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
> >> index 0349fcc9dc26..d80587de0bbf 100644
> >> --- a/arch/arm/boot/dts/omap3-beagle-xm.dts
> >> +++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
> >> @@ -30,6 +30,13 @@
> >>  		ethernet = &ethernet;
> >>  	};
> >>  
> >> +	/* fixed 26MHz oscillator */
> >> +	hfclk_26m: oscillator {
> >> +		#clock-cells = <0>;
> >> +		compatible = "fixed-clock";
> >> +		clock-frequency = <26000000>;
> >> +	};
> >> +
> >>  	leds {
> >>  		compatible = "gpio-leds";
> >>  
> >> @@ -274,6 +281,9 @@
> >>  		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
> >>  		interrupt-parent = <&intc>;
> >>  
> >> +		clocks = <&hfclk_26m>;
> >> +		clock-names = "fck";
> > 
> > I wonder if we should rename this to hfclk...
> > The DT documentation does not mention it and afaik it is not specified
> > in DT files either.
> > 
> > After all it is the HFCLK clock for the twl4030.
> 
> We should not as it would break compatibility with stable kernels where
> the code expects 'fck' and not hfclk.

OK applying into omap-for-v4.18/dt thanks.

Tony
