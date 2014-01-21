From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/6] ARM: dts: Add CPU OPP table for omap37xx100
Date: Tue, 21 Jan 2014 13:58:19 -0600
Message-ID: <52DED15B.10502@ti.com>
References: <1390333660-30573-1-git-send-email-chf.fritz@googlemail.com> <1390333660-30573-2-git-send-email-chf.fritz@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55408 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824AbaAUT6u (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Jan 2014 14:58:50 -0500
In-Reply-To: <1390333660-30573-2-git-send-email-chf.fritz@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, bcousson@baylibre.com, Archit Taneja <archit@ti.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Daniel Mack <zonque@gmail.com>, "Hans J. Koch" <hjk@hansjkoch.de>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org

On 01/21/2014 01:47 PM, Christoph Fritz wrote:
> This patch adds file omap37xx100.dtsi which includs a SoC specific table
> for CPU OPP.
> 
> Please keep in mind that am/dm37xx100 variants differ from am/dm37xx
> SoCs without nomenclature marker prefix "100". This marker indicates
> the maximum cpu frequency. 100 stands for 1 GHz-Cortex-A8, blank means
> maximum 800 MHz.
> 
> For more info, see Datasheet http://www.ti.com/lit/ds/sprs685d/sprs685d.pdf
> section 7.2.1 "Device and Development-Support Tool Nomenclature".
> 
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> ---
>  arch/arm/boot/dts/omap37xx100.dtsi |   44 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 arch/arm/boot/dts/omap37xx100.dtsi
> 
> diff --git a/arch/arm/boot/dts/omap37xx100.dtsi b/arch/arm/boot/dts/omap37xx100.dtsi
> new file mode 100644
> index 0000000..064661e
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap37xx100.dtsi
> @@ -0,0 +1,44 @@
> +/*
> + * Device Tree Source for OMAP37x SoC
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +#include "omap3.dtsi"
> +
> +/ {
> +	aliases {
> +		serial3 = &uart4;
> +	};
> +
> +	cpus {
> +		/* AM/DM37xx */
> +		cpu@0 {
> +			operating-points = <
> +				/* kHz    uV */
> +				 125000   975000
> +				 250000  1075000
> +				 500000  1100000
> +				 600000  1140000
> +				 800000  1270000
> +				1000000  1380000

This is valid even for 3630/DM3730 as well -> unfortunately - you
cannot enable 1GHz without enabling ABB and AVS 1.5.

There is a bunch of internal discussion with respect to lack of this
information available.. but as it stands right now, I dont think this
is valid.

> +			>;
> +			clock-latency = <300000>; /* From legacy driver */
> +		};
> +	};
> +
> +	ocp {
> +		/* uart4 is only available on CBP and CBC packages */
> +		uart4: serial@49042000 {
> +			compatible = "ti,omap3-uart";
> +			reg = <0x49042000 0x400>;
> +			interrupts = <80>;
> +			dmas = <&sdma 81 &sdma 82>;
> +			dma-names = "tx", "rx";
> +			ti,hwmods = "uart4";
> +			clock-frequency = <48000000>;
> +		};
> +	};
> +};
> 
Further, we should be able to reuse 3630.dtsi for this.


-- 
Regards,
Nishanth Menon
