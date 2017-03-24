From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] dt-bindings: bus: TI interconnect target module binding
Date: Thu, 23 Mar 2017 20:55:23 -0500
Message-ID: <20170324015523.dul3j4lc2nyrmvkl@rob-hp-laptop>
References: <20170314212304.2875-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170314212304.2875-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Mar 14, 2017 at 02:23:04PM -0700, Tony Lindgren wrote:
> With the recently introduced omap clkctrl module binding, we can start
> moving omap hwmod data to device tree and drivers from arch/arm/mach-omap2.
> 
> To start doing this, let's introduce a device tree binding for TI
> interconnect target module hardware that manages the individual device IP
> blocks on various interconnects for TI SoCs. The resources managed for the
> child IP blocks are clocks, idlemodes and interconnect level resets.
> 
> TI interconnect target module hardware is the same for modules, and is
> independent of the interconnect. It is used at least with TI L3
> interconnect (Arteris NoC) and TI L4 interconnect (Sonics s3220).
> 
> As all the features may not be supported for a given module, we need to
> use device tree configuration for the revision of the interconnect target
> module and things like supported master and slave idle modes.
> 
> Note that the interconnect target module control registers for the whole
> module (including it's children) are always sprinked into the unused
> address space of the first device IP block that the interconnect target
> module manages.
> 
> To avoid IO range conflicts, we can have the interconnect target module
> probe it's children and provide IO ranges for the children along with
> other services such as implementing runtime PM for the shared module
> clock.
> 
> The reason for doing this is to simplify adding support for new devices.
> Currently we need to modify clock aliases, static hwmod data, device tree
> data and the driver even for simple devices.
> 
> With the recently introduced clkctrl binding the need to modify clock
> aliases will go away. And when the interconnect target module can be
> configured using device tree, the need to modify static hwmod data goes
> away. So eventually we only need to modify the device tree and the
> driver.
> 
> Also further changes for power management will be easier as the
> interconnect, power domain, and clock domain hierarcy can be made
> available in a standard way for Linux PM domains support via device
> tree.
> 
> For a non-intrusive transition from static hwmod data to using device
> tree defined TI interconnect target module binding, we can keep things
> working the existing way if device tree property "ti,hwmods" is
> specified in the dtb.

Seems mostly reasonable...

> Cc: Benoît Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> Cc: Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
> Cc: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
> Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  .../devicetree/bindings/bus/ti-ipwrap.txt          | 153 +++++++++++++++++++++
>  1 file changed, 153 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/ti-ipwrap.txt
> 
> diff --git a/Documentation/devicetree/bindings/bus/ti-ipwrap.txt b/Documentation/devicetree/bindings/bus/ti-ipwrap.txt
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/ti-ipwrap.txt
> @@ -0,0 +1,153 @@
> +Texas Instruments interconnect target module wrapper binding
> +
> +Texas Instruments SoCs can have a generic interconnect target module
> +hardware for devices connected to various interconnects such as L3
> +interconnect (Arteris NoC) and L4 interconnect (Sonics s3220).
> +
> +Each interconnect target module can have one or more devices connected to
> +it. Each interconnect target module has a single set of registers for
> +managing clocks, idle modes and interconnect level resets for the module
> +including all the child devices connected to it.
> +
> +The interconnect target module registers are sprinkled into the unused
> +register address space of the first device IP block managed by the
> +interconnect target module.
> +
> +As an interconnect target module can manage more than one child device,
> +the interconnect target module probes the child devices and implements
> +runtime PM for them. The child device drivers can access individual
> +device registers using register ranges provided by the interconnect
> +target module.
> +
> +Required standard properties:
> +
> +- compatible	shall be one of the following generic types:
> +
> +		"ti,sysc-type1"
> +		"ti,sysc-type2"
> +		"ti,sysc-type3"
> +
> +		or one of the following derivative types for hardware
> +		needing special workarounds:
> +
> +		"ti,sysc-omap3430-sr"
> +		"ti,sysc-omap3630-sr"
> +		"ti,sysc-omap3-sham"
> +		"ti,sysc-omap-aes"
> +		"ti,sysc-mcasp"
> +		"ti,sysc-smartreflex"
> +		"ti,sysc-usb-host-fs"
> +
> +- reg		shall have register areas for the registers implemented
> +		for the interconnect target module in question such as
> +		revision, sysc and syss and ip0
> +
> +- reg-names	shall contain the register names implemented for the
> +		interconnect target module in question such as
> +		"rev, "sysc", "syss" and "ip0"
> +
> +- ranges	shall contain the register ranges available for one or more
> +		child device IP blocks managed by the interconnect target
> +		module, the ranges may include multiple ranges such as
> +		device L4 range for control and parent L3 range for DMA
> +		access
> +
> +- clocks	shall contain the clocks managed by the interconnect target
> +		module, typically at least the clkctrl clock of the module

Where do we document exactly how many clocks?

> +
> +- clock-names	shall contain names of the clock managed by the interconnect
> +		target module such as "clkctrl"
> +
> +Optional custom properties:
> +
> +- ti,sysc-has-clockactivity	interconnect target module supports SYSCONFIG
> +				register CLOCKACTIVITY feature, available for
> +				"ti,sysc-type1" and "ti,sysc-type2"
> +
> +- ti,sysc-has-enawakeup		interconnect target module supports SYSCONFIG
> +				register ENAWAKEUP feature, available for
> +				"ti,sysc-type1" and "ti,sysc-type2"
> +
> +- ti,sysc-has-softreset		interconnect target module supports SYSCONFIG
> +				register SOFTRESET feature, available for
> +				"ti,sysc-type1" and "ti,sysc-type2"
> +
> +- ti,sysc-has-autoidle		interconnect target module supports SYSCONFIG
> +				register AUTOIDLE feature, available for
> +				"ti,sysc-type1" and "ti,sysc-type2"
> +
> +- ti,sysc-has-dmadisable	interconnect target module supports SYSCONFIG
> +				DMADISABLE feature, only available for
> +				"ti,sysc-type2"
> +
> +- ti,sysc-idlemodes-master	list of master idle modes supported by the
> +				interconnect target module as documented for
> +				SYSCONFIG register MIDLEMODE bits, available on
> +				"ti,sysc-type1", "ti,sysc-type2" and
> +				"ti,sysc-type3"
> +
> +- ti,sysc-idlemodes-slave	list of slave idle modes supported by the
> +				interconnect target module as documented for
> +				SYSCONFIG register SIDLEMODE bits, available on
> +				"ti,sysc-type1", "ti,sysc-type2" and
> +				"ti,sysc-type3"
> +
> +- ti,syss-has-reset-status	interconnect target module supports SYSSTATUS
> +				register RESETDONE feature
> +
> +- ti,quirk-swsup-slave-idle	quirk to manually bring module out of idle,
> +				rely on smart-idle to put it back to idle
> +
> +- ti,quirk-swsup-master-standby	quirk to keep MIDLEMODE bits cleared so that
> +				device is kept in force-standby mode
> +
> +Example: Single instance of MUSB controller on omap4 using interconnect ranges:
> +
> +	target_module@2b000 {			/* 0x4a0ab000, ap 84 12.0 */

target-module@

This unit address doesn't look right?

> +		compatible = "ti,sysc-type1", "simple-bus";

Seems fairly complicated to claim "simple-bus"?

> +		#address-cells = <2>;

The target module really needs 64-bits of address space? 

> +		#size-cells = <1>;
> +		reg = <0x54 0x400 0x4
> +		       0x54 0x404 0x4
> +		       0x54 0x408 0x4
> +		       0x54 0 0x001000>;

You have overlapping regions. Don't do that.

And for the first 3, if you have that much variation, maybe you need 
more specific compatible strings?

> +		reg-names = "rev", "sysc", "syss", "ip0";
> +		ranges = <0 0 0x54 0 0x001000>;
> +		clocks = <&cm_l3init_clkctrl OMAP4_OTG_CLKCTRL 0>;
> +		clock-names = "clkctrl";
> +
> +		ti,sysc-has-autoidle;
> +		ti,sysc-has-enawakeup;
> +		ti,sysc-has-softreset;
> +		ti,sysc-idlemodes-master = <TI_SYSC_IDLE_FORCE
> +					    TI_SYSC_IDLE_NONE
> +					    TI_SYSC_IDLE_SMART>;
> +		ti,sysc-idlemodes-slave = <TI_SYSC_IDLE_FORCE
> +					   TI_SYSC_IDLE_NONE
> +					   TI_SYSC_IDLE_SMART
> +					   TI_SYSC_IDLE_SMART_WKUP>;
> +
> +		ti,syss-has-reset-status;
> +
> +		ti,quirk-swsup-slave-idle;
> +		ti,quirk-swsup-master-standby;
> +
> +		usb_otg_hs: usb_otg_hs@0 {
> +			compatible = "ti,omap4-musb";
> +			reg = <0 0 0x7ff>;
> +			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIH>;
> +			interrupt-names = "mc", "dma";
> +			usb-phy = <&usb2_phy>;
> +			phys = <&usb2_phy>;
> +			phy-names = "usb2-phy";
> +			multipoint = <1>;
> +			num-eps = <16>;
> +			ram-bits = <12>;
> +			ctrl-module = <&omap_control_usbotg>;
> +		};
> +	};
> +
> +Note that other SoCs, such as am335x can have multipe child devices. On am335x
> +there are two MUSB instances, two USB PHY instances, and a single CPPI41 DMA
> +instance in a single interconnet target module.
> -- 
> 2.11.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
