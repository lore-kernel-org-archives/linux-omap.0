From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [RFC/PATCH v2 09/13] dt: omap4: add soc file for handling i2c
 controllers
Date: Tue, 23 Aug 2011 13:53:54 +0530
Message-ID: <4E53639A.10606@ti.com>
References: <1314074021-25186-1-git-send-email-manjugk@ti.com> <1314074021-25186-10-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:34972 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752587Ab1HWIYD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 04:24:03 -0400
Received: by mail-gw0-f44.google.com with SMTP id 20so4439109gwb.31
        for <linux-omap@vger.kernel.org>; Tue, 23 Aug 2011 01:24:01 -0700 (PDT)
In-Reply-To: <1314074021-25186-10-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 8/23/2011 10:33 AM, G, Manjunath Kondaiah wrote:
>
> Add omap4 soc dts file for handling omap4 soc i2c
> controllers existing on l4-core bus.
>
> Signed-off-by: G, Manjunath Kondaiah<manjugk@ti.com>
> ---
>   arch/arm/boot/dts/omap4-panda.dts |    7 +---
>   arch/arm/boot/dts/omap4.dtsi      |   68 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 69 insertions(+), 6 deletions(-)
>   create mode 100644 arch/arm/boot/dts/omap4.dtsi
>
> diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
> index 58909e9..c28aa95 100644
> --- a/arch/arm/boot/dts/omap4-panda.dts
> +++ b/arch/arm/boot/dts/omap4-panda.dts
> @@ -1,9 +1,4 @@
> -/dts-v1/;
> -
> -/memreserve/ 0x9D000000 0x03000000; /* Frame buffer */
> -/memreserve/ 0xB0000000 0x10000000; /* Top 256MB is unaccessable */
> -
> -/include/ "skeleton.dtsi"
> +/include/ "omap4.dtsi"
>
>   / {
>   	model = "TI OMAP4 PandaBoard";
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> new file mode 100644
> index 0000000..cb055f5
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -0,0 +1,68 @@
> +/*
> + * Device Tree Source for OMAP4 SoC
> + *
> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +/dts-v1/;
> +
> +/memreserve/ 0x9D000000 0x03000000; /* Frame buffer */
> +/memreserve/ 0xB0000000 0x10000000; /* Top 256MB is unaccessable */
> +
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	#address-cells =<1>;
> +	#size-cells =<1>;
> +	model = "ti,omap4";
> +
> +	aliases {
> +		i2c1 =&i2c1;
> +		i2c2 =&i2c2;
> +		i2c3 =&i2c3;
> +		i2c4 =&i2c4;
> +	};
> +
> +	l4-core {
> +		compatible = "ti,omap4-l4-core", "sonics,s3220";
> +		#address-cells =<1>;
> +		#size-cells =<1>;
> +		ranges =<0 0x48000000 0x1000000>;
> +
> +		i2c1: i2c@70000 {
> +			#address-cells =<1>;
> +			#size-cells =<0>;

Are these really needed, given there are no child nodes defined?
Same with all other instances.

> +			compatible = "ti,omap-i2c", "ti,omap-device";
> +			reg =<0x70000 0x100>;
> +			interrupts =<  88>;
> +		};
> +
> +		i2c2: i2c@72000 {
> +			#address-cells =<1>;
> +			#size-cells =<0>;
> +			compatible = "ti,omap-i2c", "ti,omap-device";
> +			reg =<0x72000 0x100>;
> +			interrupts =<  89>;
> +		};
> +
> +		i2c3: i2c@60000 {
> +			#address-cells =<1>;
> +			#size-cells =<0>;
> +			compatible = "ti,omap-i2c", "ti,omap-device";
> +			reg =<0x60000 0x100>;
> +			interrupts =<  93>;
> +		};
> +
> +		i2c4: i2c@350000 {
> +			#address-cells =<1>;
> +			#size-cells =<0>;
> +			compatible = "ti,omap-i2c", "ti,omap-device";
> +			reg =<0x350000 0x100>;
> +			interrupts =<  94>;
> +		};
> +	};
> +};

