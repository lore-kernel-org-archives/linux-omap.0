From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 1/1] gpio: omap: dts: Move interrupt-controller from #interrupt-cells
 description
Date: Mon, 4 Mar 2013 13:23:52 -0600
Message-ID: <5134F4C8.4010003@ti.com>
References: <1362422157-32196-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54716 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758166Ab3CDTYD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Mar 2013 14:24:03 -0500
In-Reply-To: <1362422157-32196-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@nvidia.com>, devicetree-discuss@lists.ozlabs.org, linux-omap <linux-omap@vger.kernel.org>


On 03/04/2013 12:35 PM, Javier Martinez Canillas wrote:
> The binding documentation for the OMAP GPIO controller has the description
> for the "#interrupt-cells" property after the "interrupt-controller"
> definition. This is confusing so is better to move "interrupt-controller"
> after the "#interrupt-cells" description.
> 
> Reported-by: Stephen Warren <swarren@nvidia.com>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  .../devicetree/bindings/gpio/gpio-omap.txt         |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-omap.txt b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
> index bff51a2..8b9914c 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-omap.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
> @@ -10,7 +10,6 @@ Required properties:
>    - second cell is used to specify optional parameters (unused)
>  - gpio-controller : Marks the device node as a GPIO controller.
>  - #interrupt-cells : Should be 2.
> -- interrupt-controller: Mark the device node as an interrupt controller
>    The first cell is the GPIO number.
>    The second cell is used to specify flags:
>      bits[3:0] trigger type and level flags:
> @@ -18,6 +17,7 @@ Required properties:
>        2 = high-to-low edge triggered.
>        4 = active high level-sensitive.
>        8 = active low level-sensitive.
> +- interrupt-controller: Mark the device node as an interrupt controller.
>  
>  OMAP specific properties:
>  - ti,hwmods: Name of the hwmod associated to the GPIO:
> 

Thanks. Do you mind putting "interrupt-controller" before
"#interrupt-cells" as I see this is how they have it in
Documenation/devicetree/bindings/interrupt-controller/interrupts.txt?
Otherwise ...

Acked-by: Jon Hunter <jon-hunter@ti.com>

Cheers
Jon
