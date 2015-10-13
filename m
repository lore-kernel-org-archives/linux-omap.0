From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3 27/27] ARM: dts: omap3: Fix gpmc and NAND nodes
Date: Tue, 13 Oct 2015 08:18:33 -0700
Message-ID: <20151013151832.GW23801@atomide.com>
References: <1442588029-13769-1-git-send-email-rogerq@ti.com>
 <1442588029-13769-28-git-send-email-rogerq@ti.com>
 <20151013004335.GU23801@atomide.com>
 <561CA4C3.4@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <561CA4C3.4-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [151012 23:33]:
> On 13/10/15 03:43, Tony Lindgren wrote:
> > * Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [150918 08:00]:
> >> Add compatible id, GPMC register resource and interrupt
> >> resource to NAND controller nodes.
> >>
> >> The GPMC driver now implements gpiochip and irqchip so
> >> enable gpio-controller and interrupt-controller properties.
> >>
> >> With this the interrupt parent of NAND node changes so fix it
> >> accordingly.
> > ...
> >> --- a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
> >> +++ b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
> >> @@ -35,11 +35,14 @@
> >>  };
> >>  
> >>  &gpmc {
> >> -	ranges = <0 0 0x00000000 0x1000000>;	/* CS0: 16MB for NAND */
> >> +	ranges = <0 0 0x08000000 0x1000000>;	/* CS0: 16MB for NAND */
> >>  
> >>  	nand@0,0 {
> >> -		linux,mtd-name = "micron,mt29f4g16abbda3w";
> >> +		compatible = "ti,omap2-nand";
> >>  		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
> >> +		interrupt-parent = <&intc>;
> >> +		interrupts = <20>;
> >> +		linux,mtd-name = "micron,mt29f4g16abbda3w";
> >>  		nand-bus-width = <16>;
> >>  		ti,nand-ecc-opt = "bch8";
> >>  		gpmc,sync-clk-ps = <0>;
> > 
> > At least torpedo breaks for NFSroot as NAND now overlaps with
> > Ethernet.. What's the policy you have for moving the addresses
> > around?
> 
> For OMAP3 I intended to use 0x30000000 for NAND but incorrectly
> used 0x08000000 for the torpedo.

Might be worth adding some documentation of suggested standardized
mappings.. For most of theme we could just add them as 16MB chunks,
then reserve some larger area for NOR?

> Does setting it to 0x30000000 work? If not what is the original
> NAND address for this board?

The u-boot addresses are probably what were used in the .dts* files.
Setting NAND to 0x30000000 is not enough though, looks like there's
a bug where the logicpd-torpedo-37xx-devkit.dts ranges is missing
the NAND range in logicpd-torpedo-som.dtsi. Something like the
patch below seems to make things work again, might be worth
checking what ranges make sense to standardize on though. Please
feel free to fold it into your patches.

> > There may be other similar cases to check too.
> 
> Just checked that all other OMAP3 boards I've set to 0x30000000
> if they were 0x0.

Do you want to reserve a large chunk for NOR at cs0 or what's
the reason for picking 0x30000000 for NAND?

I guess NOR can be also on other chipselects.. Not sure we can
standardize on any specific partition scheme?

Regards,

Tony

8< --------------------
--- a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
+++ b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
@@ -73,7 +73,8 @@
 };
 
 &gpmc {
-	ranges = <1 0 0x08000000 0x1000000>;	/* CS1: 16MB for LAN9221 */
+	ranges = <0 0 0x30000000 0x1000000	/* CS0: 16MB for NAND */
+		  1 0 0x2c000000 0x1000000>;	/* CS1: 16MB for LAN9221 */
 
 	ethernet@gpmc {
 		pinctrl-names = "default";
--- a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
+++ b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
@@ -35,7 +35,7 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x08000000 0x1000000>;	/* CS0: 16MB for NAND */
+	ranges = <0 0 0x30000000 0x1000000>;	/* CS0: 16MB for NAND */
 
 	nand@0,0 {
 		compatible = "ti,omap2-nand";
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
