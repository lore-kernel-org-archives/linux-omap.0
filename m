From: Anil Kumar <anilk4.v@gmail.com>
Subject: Re: [PATCH 4/9] ARM: dts: OMAP3: Add support for OMAP3430 SDP board
Date: Mon, 11 Mar 2013 08:15:30 +0530
Message-ID: <CABYxbz78Eu_+__5QGrm5bM2ypJSyds_KJcjWF4SRDj+ZOdV43w@mail.gmail.com>
References: <1362763654-9660-1-git-send-email-jon-hunter@ti.com>
	<1362763654-9660-5-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:53015 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753586Ab3CKCpb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Mar 2013 22:45:31 -0400
Received: by mail-ie0-f175.google.com with SMTP id c12so4112234ieb.20
        for <linux-omap@vger.kernel.org>; Sun, 10 Mar 2013 19:45:30 -0700 (PDT)
In-Reply-To: <1362763654-9660-5-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On Fri, Mar 8, 2013 at 10:57 PM, Jon Hunter <jon-hunter@ti.com> wrote:
> Adds basic device-tree support for OMAP3430 SDP board which has 256MB
> of RAM and uses the TWL4030 power management IC.
>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  arch/arm/boot/dts/Makefile         |    1 +
>  arch/arm/boot/dts/omap3430-sdp.dts |   46 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
>  create mode 100644 arch/arm/boot/dts/omap3430-sdp.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 9c62558..89013ed 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -119,6 +119,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
>         omap3-beagle-xm.dtb \
>         omap3-evm.dtb \
>         omap3-tobi.dtb \
> +       omap3430-sdp.dtb \
>         omap4-panda.dtb \
>         omap4-panda-a4.dtb \
>         omap4-panda-es.dtb \
> diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dts/omap3430-sdp.dts
> new file mode 100644
> index 0000000..be0650d
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap3430-sdp.dts
> @@ -0,0 +1,46 @@
> +/*
> + * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
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
> +       model = "TI OMAP3430 SDP";
> +       compatible = "ti,omap3430-sdp", "ti,omap3";
> +
> +       memory {
> +               device_type = "memory";
> +               reg = <0x80000000 0x10000000>; /* 256 MB */
> +       };
> +};
> +
> +&i2c1 {
> +       clock-frequency = <2600000>;
> +
> +       twl: twl@48 {
> +               reg = <0x48>;
> +               interrupts = <7>; /* SYS_NIRQ cascaded to intc */
> +               interrupt-parent = <&intc>;

No need of  "interrupt-parent = <&intc>" as it is with root node
already.

Thanks,
Anil

[...]
