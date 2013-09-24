From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH 2/2] ARM: dts: dra7-evm: Add mmc2 node for eMMC support
Date: Tue, 24 Sep 2013 11:41:21 +0200
Message-ID: <52415E41.7050301@baylibre.com>
References: <1377525218-7655-1-git-send-email-balajitk@ti.com> <1377525218-7655-3-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:34955 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab3IXJlZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Sep 2013 05:41:25 -0400
Received: by mail-bk0-f44.google.com with SMTP id mz10so1655756bkb.3
        for <linux-omap@vger.kernel.org>; Tue, 24 Sep 2013 02:41:24 -0700 (PDT)
In-Reply-To: <1377525218-7655-3-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, nm@ti.com, Sekhar Nori <nsekhar@ti.com>

+ Sekhar

Hi Balaji,

On 26/08/2013 15:53, Balaji T K wrote:
> Add mmc2 dt node to dra7-evm board
> and model eMMC vcc as fixed regulator.
>
> Signed-off-by: Balaji T K <balajitk@ti.com>
> ---
>   arch/arm/boot/dts/dra7-evm.dts |   14 ++++++++++++++
>   1 files changed, 14 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
> index a59bbd0..2062724 100644
> --- a/arch/arm/boot/dts/dra7-evm.dts
> +++ b/arch/arm/boot/dts/dra7-evm.dts
> @@ -17,6 +17,13 @@
>   		device_type = "memory";
>   		reg = <0x80000000 0x60000000>; /* 1536 MB */
>   	};
> +
> +	mmc2_3v3: fixedregulator-mmc2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "mmc2_3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
>   };
>
>   &dra7_pmx_core {
> @@ -257,3 +264,10 @@
>   	vmmc-supply = <&ldo1_reg>;
>   	bus-width = <4>;
>   };
> +
> +&mmc2 {
> +	status = "okay";
> +	vmmc-supply = <&mmc2_3v3>;
> +	bus-width = <8>;
> +	ti,non-removable;

Sekhar just posted a series to replace that with a non-TI attribute: 
non-removable.

I'm not sure if this got merged, but it might be good to use the 
standard attribute instead.

Regards,
Benoit
