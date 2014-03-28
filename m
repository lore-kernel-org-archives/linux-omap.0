From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH V3 6/6] ARM: DTS: AM43xx: Add DSS nodes
Date: Fri, 28 Mar 2014 15:33:45 +0530
Message-ID: <53354901.7050106@ti.com>
References: <1395658916-9032-1-git-send-email-sathyap@ti.com> <1395658916-9032-7-git-send-email-sathyap@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50779 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751098AbaC1KDu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Mar 2014 06:03:50 -0400
In-Reply-To: <1395658916-9032-7-git-send-email-sathyap@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sathya Prakash M R <sathyap@ti.com>, tomi.valkeinen@ti.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

On Monday 24 March 2014 04:31 PM, Sathya Prakash M R wrote:
> Both the AM437x-Gp evm and Am43x-Epos evm
> use the same LCD panel.
> The lcd timings are added in respective dts files.
> Adds display pinctrl and enables required gpio.
> 
> Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
> ---
>  arch/arm/boot/dts/am437x-gp-evm.dts  |   77 ++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/am43x-epos-evm.dts |   73 ++++++++++++++++++++++++++++++++
>  2 files changed, 150 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
> index 2e79bda..a178e8d 100644
> --- a/arch/arm/boot/dts/am437x-gp-evm.dts
> +++ b/arch/arm/boot/dts/am437x-gp-evm.dts
> @@ -24,6 +24,33 @@
>  		brightness-levels = <0 51 53 56 62 75 101 152 255>;
>  		default-brightness-level = <8>;
>  	};
> +
> +	aliases {
> +		display0 = &lcd0;
> +	};
> +
> +	lcd0: display {
> +		compatible = "osddisplays,osd057T0559-34ts", "panel-dpi";
                                                ^

Lower case 'T' for consistency with how bindings are usually defined?

> +	dss_pinctrl: dss_pinctrl {
> +		pinctrl-single,pins = <
> +			0x020 (PIN_OUTPUT_PULLUP | MUX_MODE1) /*gpmc ad 8 -> DSS DATA 23 */
> +			0x024 (PIN_OUTPUT_PULLUP | MUX_MODE1)
> +			0x028 (PIN_OUTPUT_PULLUP | MUX_MODE1)
> +			0x02C (PIN_OUTPUT_PULLUP | MUX_MODE1)

Lower case hex number here too and everywhere else.

Thanks,
Sekhar
