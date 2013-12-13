From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 16/26] ARM: omap4-sdp.dts: add display information
Date: Fri, 13 Dec 2013 14:57:13 +0530
Message-ID: <52AAD2F1.2040208@ti.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com> <1386160133-24026-17-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48765 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752068Ab3LMJ1R (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Dec 2013 04:27:17 -0500
In-Reply-To: <1386160133-24026-17-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>

On Wednesday 04 December 2013 05:58 PM, Tomi Valkeinen wrote:
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   arch/arm/boot/dts/omap4-sdp.dts | 91 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 91 insertions(+)
>
> diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
> index 5fc3f43c5a81..e3048f849612 100644
> --- a/arch/arm/boot/dts/omap4-sdp.dts
> +++ b/arch/arm/boot/dts/omap4-sdp.dts
> @@ -550,3 +550,94 @@
>   	mode = <3>;
>   	power = <50>;
>   };
> +
> +&dsi1 {
> +	vdds_dsi-supply = <&vcxio>;
> +
> +	dsi1_out_ep: endpoint {
> +		remote-endpoint = <&lcd0_in>;
> +		lanes = <0 1 2 3 4 5>;

In the previous revision omapdss DT patchset, the lanes node was a 
member of the panel DT node, and not the dsi DT node. Any reason to 
change this? Does it make more sense this way?

I suppose it's more suitable for dsi to hold the property if 2 panels 
are connected on the same bus. Say, one with 4 data lanes, and other 
with 2. It would be tricky for the dsi driver to get lane params from 2 
different places and merge them somehow.

> +	};
> +
> +	lcd0: display@0 {
> +		compatible = "tpo,taal", "panel-dsi-cm";
> +
> +		gpios = <&gpio4 6 0>;	/* 102, reset */
> +
> +		lcd0_in: endpoint {
> +			remote-endpoint = <&dsi1_out_ep>;
> +		};
> +	};

Is there a reason why lcd0 and lcd1 are children nodes of dsi1 and dsi2 
respectively? I don't see this for panels on other boards.

Archit

