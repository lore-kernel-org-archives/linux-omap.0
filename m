From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 1/3] ARM: dts: Update OMAP3430 SDP NAND and ONENAND properties
Date: Mon, 8 Apr 2013 14:12:44 +0200
Message-ID: <5162B43C.5000307@ti.com>
References: <1365383828-25627-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43281 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759763Ab3DHMMy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Apr 2013 08:12:54 -0400
In-Reply-To: <1365383828-25627-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On 04/08/2013 03:17 AM, Jon Hunter wrote:
> The GPMC timing properties for device-tree have been updated by adding
> a "-ns" or "-ps" suffix to indicate the units of time the property
> represents (as suggested by Rob Herring). Therefore, update the timing
> property names for the OMAP3430 SDP NAND and ONENAND devices.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
> 
> Hi Benoit, this is a changed that is going to be introduced for v3.10.
> Feel free to squash this with the patch "ARM: dts: OMAP3: Add support
> for OMAP3430 SDP board" that you have queued for v3.10 if you prefer.

I applied them like that. I did not want to rebase again the whole series.


Regards,
Benoit


>  arch/arm/boot/dts/omap3430-sdp.dts |   56 ++++++++++++++++++------------------
>  1 file changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dts/omap3430-sdp.dts
> index 05cd8ba..44d2191 100644
> --- a/arch/arm/boot/dts/omap3430-sdp.dts
> +++ b/arch/arm/boot/dts/omap3430-sdp.dts
> @@ -57,20 +57,20 @@
>  
>  		ti,nand-ecc-opt = "sw";
>  		gpmc,device-nand;
> -		gpmc,cs-on = <0>;
> -		gpmc,cs-rd-off = <36>;
> -		gpmc,cs-wr-off = <36>;
> -		gpmc,adv-on = <6>;
> -		gpmc,adv-rd-off = <24>;
> -		gpmc,adv-wr-off = <36>;
> -		gpmc,oe-on = <6>;
> -		gpmc,oe-off = <48>;
> -		gpmc,we-on = <6>;
> -		gpmc,we-off = <30>;
> -		gpmc,rd-cycle = <72>;
> -		gpmc,wr-cycle = <72>;
> -		gpmc,access = <54>;
> -		gpmc,wr-access = <30>;
> +		gpmc,cs-on-ns = <0>;
> +		gpmc,cs-rd-off-ns = <36>;
> +		gpmc,cs-wr-off-ns = <36>;
> +		gpmc,adv-on-ns = <6>;
> +		gpmc,adv-rd-off-ns = <24>;
> +		gpmc,adv-wr-off-ns = <36>;
> +		gpmc,oe-on-ns = <6>;
> +		gpmc,oe-off-ns = <48>;
> +		gpmc,we-on-ns = <6>;
> +		gpmc,we-off-ns = <30>;
> +		gpmc,rd-cycle-ns = <72>;
> +		gpmc,wr-cycle-ns = <72>;
> +		gpmc,access-ns = <54>;
> +		gpmc,wr-access-ns = <30>;
>  
>  		partition@0 {
>  			label = "xloader-nand";
> @@ -102,20 +102,20 @@
>  
>  		gpmc,device-width = <2>;
>  		gpmc,mux-add-data = <2>;
> -		gpmc,cs-on = <0>;
> -		gpmc,cs-rd-off = <84>;
> -		gpmc,cs-wr-off = <72>;
> -		gpmc,adv-on = <0>;
> -		gpmc,adv-rd-off = <18>;
> -		gpmc,adv-wr-off = <18>;
> -		gpmc,oe-on = <30>;
> -		gpmc,oe-off = <84>;
> -		gpmc,we-on = <0>;
> -		gpmc,we-off = <42>;
> -		gpmc,rd-cycle = <108>;
> -		gpmc,wr-cycle = <96>;
> -		gpmc,access = <78>;
> -		gpmc,wr-data-mux-bus = <30>;
> +		gpmc,cs-on-ns = <0>;
> +		gpmc,cs-rd-off-ns = <84>;
> +		gpmc,cs-wr-off-ns = <72>;
> +		gpmc,adv-on-ns = <0>;
> +		gpmc,adv-rd-off-ns = <18>;
> +		gpmc,adv-wr-off-ns = <18>;
> +		gpmc,oe-on-ns = <30>;
> +		gpmc,oe-off-ns = <84>;
> +		gpmc,we-on-ns = <0>;
> +		gpmc,we-off-ns = <42>;
> +		gpmc,rd-cycle-ns = <108>;
> +		gpmc,wr-cycle-ns = <96>;
> +		gpmc,access-ns = <78>;
> +		gpmc,wr-data-mux-bus-ns = <30>;
>  
>  		partition@0 {
>  			label = "xloader-onenand";
> 

