From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 2/2] arm/dts: Add support for TI AM335x EVM board
Date: Fri, 3 Feb 2012 06:42:15 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8317BE7E1@DBDE01.ent.ti.com>
References: <1326870839-19951-1-git-send-email-hvaibhav@ti.com>
 <1326870839-19951-2-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41644 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751249Ab2BCGmc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Feb 2012 01:42:32 -0500
In-Reply-To: <1326870839-19951-2-git-send-email-hvaibhav@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>

On Wed, Jan 18, 2012 at 12:43:59, Hiremath, Vaibhav wrote:
> Add AM335x EVM DTS file to use the omap3.dtsi SoC file,
> along with memory node and i2c information.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/boot/dts/am335x-evm.dts |   39 ++++++++++++++++++++++++++++++++++++++
>  1 files changed, 39 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/am335x-evm.dts
> 
> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
> new file mode 100644
> index 0000000..8cc877f
> --- /dev/null
> +++ b/arch/arm/boot/dts/am335x-evm.dts
> @@ -0,0 +1,39 @@
> +/*
> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +/dts-v1/;
> +
> +/include/ "omap3.dtsi"
> +
> +/ {
> +	model = "TI AM335x EVM";
> +	compatible = "ti,am335x-evm", "ti,am33xx", "ti,omap3";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x80000000 0x10000000>; /* 256 MB */
> +	};
> +};
> +
> +&intc {
> +	/*
> +	 * AM33XX family of devices have 128 interrupts
> +	 */
> +	ti,intc-size = <128>;
> +};
> +
> +&i2c1 {
> +	clock-frequency = <400000>;
> +};
> +
> +&i2c2 {
> +	clock-frequency = <400000>;
> +};
> +
> +&i2c3 {
> +	clock-frequency = <400000>;
> +};

Grant,

If there are not review comments, can you also ack this patch as well?

Thanks,
Vaibhav

> --
> 1.7.0.4
> 
> 

