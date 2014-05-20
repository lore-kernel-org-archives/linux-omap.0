From: Joachim Eastwood <manabian@gmail.com>
Subject: Re: [PATCH] ARM: dts: duovero-parlor: Add HDMI output
Date: Tue, 20 May 2014 20:09:06 +0200
Message-ID: <CAGhQ9VxtJwrKzW77mo=y9_gvCRW_8TJEp90OVN+YPg2RpC=b_w@mail.gmail.com>
References: <1400595946-1294-1-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:44126 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853AbaETSJI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 May 2014 14:09:08 -0400
In-Reply-To: <1400595946-1294-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org

On 20 May 2014 16:25, Florian Vaussard <florian.vaussard@epfl.ch> wrote:
> Add the necessary DTS nodes to enable the micro-HDMI output on Parlor
> board.
>
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> ---
>  arch/arm/boot/dts/omap4-duovero-parlor.dts | 42 ++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/arch/arm/boot/dts/omap4-duovero-parlor.dts b/arch/arm/boot/dts/omap4-duovero-parlor.dts
> index 96f51d8..3b234b8 100644
> --- a/arch/arm/boot/dts/omap4-duovero-parlor.dts
> +++ b/arch/arm/boot/dts/omap4-duovero-parlor.dts
> @@ -15,6 +15,10 @@
>         model = "OMAP4430 Gumstix Duovero on Parlor";
>         compatible = "gumstix,omap4-duovero-parlor", "gumstix,omap4-duovero", "ti,omap4430", "ti,omap4";
>
> +       aliases {
> +               display0 = &hdmi0;
> +       };
> +
>         leds {
>                 compatible = "gpio-leds";
>                 led0 {
> @@ -35,6 +39,19 @@
>                         gpio-key,wakeup;
>                 };
>         };
> +
> +       hdmi0: connector@0 {
> +               compatible = "hdmi-connector";
> +               label = "hdmi";
> +
> +               type = "d";
> +
> +               port {
> +                       hdmi_connector_in: endpoint {
> +                               remote-endpoint = <&hdmi_out>;
> +                       };
> +               };
> +       };
>  };

No, HPD (hotplug) pin?

I think Parlor has one and the "hdmi-connector" binding now supports
it. See Tomi's 3.16/fbdev-omap branch.

regards
Joachim Eastwood
