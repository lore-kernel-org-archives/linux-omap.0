From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] arm/dts: omap3-evm: Add i2c and twl4030 support
Date: Mon, 23 Jan 2012 08:49:56 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8317AF2E2@DBDE01.ent.ti.com>
References: <1326869739-27652-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44344 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384Ab2AWIuP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jan 2012 03:50:15 -0500
In-Reply-To: <1326869739-27652-1-git-send-email-hvaibhav@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>

On Wed, Jan 18, 2012 at 12:25:39, Hiremath, Vaibhav wrote:
> Add support for TWL4030, which is interfaced on i2c1 bus.
> Also add clock frequencies for other i2c instances(2 & 3)
> required for client-device exist on OMAP3EVM board.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/boot/dts/omap3-evm.dts |   28 ++++++++++++++++++++++++++++
>  1 files changed, 28 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-evm.dts b/arch/arm/boot/dts/omap3-evm.dts
> index 2eee16e..530bdc0 100644
> --- a/arch/arm/boot/dts/omap3-evm.dts
> +++ b/arch/arm/boot/dts/omap3-evm.dts
> @@ -18,3 +18,31 @@
>  		reg = <0x80000000 0x10000000>; /* 256 MB */
>  	};
>  };
> +
> +&i2c1 {
> +	clock-frequency = <2600000>;
> +
> +	twl: twl@48 {
> +		reg = <0x48>;
> +		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
> +		interrupt-parent = <&intc>;
> +	};
> +};
> +
> +/include/ "twl4030.dtsi"
> +
> +&i2c2 {
> +	clock-frequency = <400000>;
> +};
> +
> +&i2c3 {
> +	clock-frequency = <400000>;
> +
> +	/*
> +	 * TVP5146 Video decoder-in for analog input support.
> +	 */
> +	tvp5146@5C {
> +		compatible = "ti,tvp5146m2";
> +		reg = <0x5C>;
> +	};
> +};
> -- 
> 1.7.0.4
> 
> 

Benoit,

Can this (and also AM3517 DT support patch) be merged to your 
next pull request?

Thanks,
Vaibhav

