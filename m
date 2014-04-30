From: Joachim Eastwood <manabian@gmail.com>
Subject: Re: [PATCH 1/4] ARM: dts: Add support for OMAP4 Variscite OM44 family
Date: Wed, 30 Apr 2014 03:24:23 +0200
Message-ID: <CAGhQ9Vw8sxifmG5Y3xbywm9B9e36VHxCk_oKLmh1qCgoOUOBSQ@mail.gmail.com>
References: <1397833849-22396-1-git-send-email-manabian@gmail.com>
	<1397833849-22396-2-git-send-email-manabian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f171.google.com ([209.85.220.171]:34562 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbaD3BYX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Apr 2014 21:24:23 -0400
Received: by mail-vc0-f171.google.com with SMTP id ld13so1363150vcb.30
        for <linux-omap@vger.kernel.org>; Tue, 29 Apr 2014 18:24:23 -0700 (PDT)
In-Reply-To: <1397833849-22396-2-git-send-email-manabian@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, Joachim Eastwood <manabian@gmail.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>

On 18 April 2014 17:10, Joachim Eastwood <manabian@gmail.com> wrote:
> Add support for VAR-SOM-OM44[1] SODIMM system on module from Variscite. SoM
> features a OMAP4460, 1GB RAM, Gigabit Ethernet (LAN7500) and optional WLAN/BT.
>
> Also add support for VAR-STK-OM44 development board from Variscite. This kit
> features a VAR-SOM-OM44 and the carrier board VAR-OM44CustomBoard[2]. The
> VAR-STK-OM44 is the same as VAR-DVK-OM44 but without the LCD display.
>
> omap4-var-stk-om44.dts replace the old and very limited omap4-var-som.dts.
>
> [1] http://www.variscite.com/products/system-on-module-som/cortex-a9/var-som-om44-cpu-ti-omap-4-omap4460
> [2] http://www.variscite.com/products/single-board-computers/var-om44customboard
>
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> ---

Tomi,

Do you plan to push the patch that add hpd-gpios to the
"hdmi-connector" for 3.16? (nodes for my board below)
https://patchwork.kernel.org/patch/4006021/

Also in the patch set I am using your DT bindings for "panel-dpi". See
patch [2 of 4] for nodes.
https://patchwork.kernel.org/patch/4047241/

Will this patch be upstream in 3.16?

As I am about to send out a new version of this patch set it would be
nice to know if I need to split out the display stuff, for later
inclusion, or if it can go in as it is.

regards
Joachim Eastwood

> +       hdmi0: connector@0 {
> +               compatible = "hdmi-connector";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&hdmi_hpd_pins>;
> +               label = "hdmi";
> +               type = "a";
> +
> +               hpd-gpios = <&gpio2 31 GPIO_ACTIVE_HIGH>; /* gpio_63 */
> +
> +               port {
> +                       hdmi_connector_in: endpoint {
> +                               remote-endpoint = <&hdmi_out>;
> +                       };
> +               };
> +       };
> +};
