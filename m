From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH v3 07/11] arm/dts: twl4030: Add DTS file for twl4030 PM
 + Audio IC
Date: Tue, 20 Dec 2011 10:47:16 -0600
Message-ID: <4EF0BC14.7080205@gmail.com>
References: <1324398444-23296-1-git-send-email-b-cousson@ti.com> <1324398444-23296-8-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:57705 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407Ab1LTQrS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Dec 2011 11:47:18 -0500
Received: by yhr47 with SMTP id 47so4802609yhr.19
        for <linux-omap@vger.kernel.org>; Tue, 20 Dec 2011 08:47:18 -0800 (PST)
In-Reply-To: <1324398444-23296-8-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca

On 12/20/2011 10:27 AM, Benoit Cousson wrote:
> Add a dedicated DTS file for the twl4030/5030 Power + Audio IC.
> This chip is a big SoC that will be reused in a lot of various
> OMAP3 boards.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Rob Herring <rob.herring@calxeda.com>
> ---
>  arch/arm/boot/dts/twl4030.dtsi |   21 +++++++++++++++++++++
>  1 files changed, 21 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/twl4030.dtsi
> 
> diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
> new file mode 100644
> index 0000000..8be5223
> --- /dev/null
> +++ b/arch/arm/boot/dts/twl4030.dtsi
> @@ -0,0 +1,21 @@
> +/*
> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/*
> + * Integrated Power Management Chip
> + */
> +&twl {
> +	compatible = "ti,twl4030";
> +	interrupt-controller;
> +	#interrupt-cells = <1>;
> +
> +	rtc {
> +		compatible = "ti,twl4030-rtc";
> +		interrupts = <11>;

Can't this vary? Not only the irq#, but the parent controller's number
of cells can vary.

Rob
