From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 2/2] arm/dts: omap4: Add ocp2scp data
Date: Tue, 17 Jul 2012 16:36:08 +0400
Message-ID: <50055C38.3000309@mvista.com>
References: <1342448023-14438-1-git-send-email-kishon@ti.com> <1342448023-14438-3-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:50756 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958Ab2GQMhA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jul 2012 08:37:00 -0400
Received: by lbbgm6 with SMTP id gm6so568435lbb.19
        for <linux-omap@vger.kernel.org>; Tue, 17 Jul 2012 05:36:58 -0700 (PDT)
In-Reply-To: <1342448023-14438-3-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, b-cousson@ti.com, rnayak@ti.com, tony@atomide.com, gregkh@linuxfoundation.org, ohad@wizery.com, linus.walleij@linaro.org, myungjoo.ham@samsung.com, rusty@rustcorp.com.au, swarren@nvidia.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

Hello.

On 16-07-2012 18:13, Kishon Vijay Abraham I wrote:

> Add ocp2scp data node in omap4 device tree file.

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>   arch/arm/boot/dts/omap4.dtsi |    8 ++++++++
>   1 files changed, 8 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 359c497..bda5df3 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -272,5 +272,13 @@
>   			ti,hwmods = "mmc5";
>   			ti,needs-special-reset;
>   		};
> +
> +		ocp2scp@4a0ad000  {

    "reg" property is absent, so why do you give the node name an address postfix?

> +			compatible = "ti,omap-ocp2scp";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			ti,hwmods = "ocp2scp_usb_phy";
> +		};

WBR, Sergei


