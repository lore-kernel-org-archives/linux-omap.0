From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V2] arm/dts: omap3-evm: Add i2c and twl4030 support
Date: Thu, 2 Feb 2012 15:23:57 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8317BD828@DBDE01.ent.ti.com>
References: <1328077568-22043-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54863 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751946Ab2BBPYO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Feb 2012 10:24:14 -0500
In-Reply-To: <1328077568-22043-1-git-send-email-hvaibhav@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>

On Wed, Feb 01, 2012 at 11:56:08, Hiremath, Vaibhav wrote:
> Add support for TWL4030, which is interfaced on i2c1 bus.
> Also add clock frequencies for other i2c instances(2 & 3)
> required for client-device exist on OMAP3EVM board.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
> Changes from V1:
> 	- As per comment from Benoit, changed hex representation
> 	  from uppercase to lowercase.
> 
>  arch/arm/boot/dts/omap3-evm.dts |   28 ++++++++++++++++++++++++++++
>  1 files changed, 28 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-evm.dts b/arch/arm/boot/dts/omap3-evm.dts
> index 2eee16e..f349ee9 100644
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
> +	tvp5146@5c {
> +		compatible = "ti,tvp5146m2";
> +		reg = <0x5c>;
> +	};
> +};

Grant,

Can you ack this patch and below patch as well, so that
Benoit can queue it in his tree?

arm/dts: Add support for TI AM3517/05 EVM board

Thanks,
Vaibhav

> --
> 1.7.0.4
> 
> 

