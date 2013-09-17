From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv6 01/45] CLK: TI: Add DPLL clock support
Date: Tue, 17 Sep 2013 09:09:36 -0700
Message-ID: <20130917160936.GB9994@atomide.com>
References: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
 <1377782197-10611-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1377782197-10611-2-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org> [130829 06:24]:
> The OMAP clock driver now supports DPLL clock type. This patch also
> adds support for DT DPLL nodes.
...

> +- reg-names : array of the register names for controlling the device, sorted
> +  in the same order as the reg property.
> +	"control" - contains the control register base address
> +        "idlest" - contains the idle status register base address
> +        "autoidle" - contains the autoidle register base address
> +        "mult-div1" - contains the multiplier / divider register base address

FYI, looks like there's some tab vs spaces issue with the
formatting above.

> +Examples:
> +	dpll_core_ck: dpll_core_ck@44e00490 {
> +		#clock-cells = <0>;
> +		compatible = "ti,omap4-dpll-core-clock";
> +		clocks = <&sys_clkin_ck>, <&sys_clkin_ck>;
> +		reg = <0x44e00490 0x4>, <0x44e0045c 0x4>, <0x0 0x4>,
> +				<0x44e00468 0x4>;
> +		reg-names = "control", "idlest", "autoidle", "mult-div1";
> +	};
> +
> +	dpll2_ck: dpll2_ck@48004004 {
> +		#clock-cells = <0>;
> +		compatible = "ti,omap3-dpll-clock";
> +		clocks = <&sys_ck>, <&dpll2_fck>;
> +		ti,modes = <0xa2>;
> +		reg = <0x48004004 0x4>, <0x48004024 0x4>, <0x48004034 0x4>,
> +			<0x48004040 0x4>;
> +		reg-names = "control", "idlest", "autoidle", "mult-div1";
> +		ti,clkdm-name = "dpll2_clkdm";
> +	};

Do you need the reg-names at all? You may be able to do that
automatically in the driver based on the compatible flags if
you only have few different types.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
