From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 4/4] Documentation: dt: OMAP: Update Overo/Tobi
Date: Thu, 13 Feb 2014 08:43:53 -0600
Message-ID: <52FCDA29.90605@ti.com>
References: <1392287116-4548-1-git-send-email-florian.vaussard@epfl.ch> <1392287116-4548-5-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37252 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861AbaBMOoU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Feb 2014 09:44:20 -0500
In-Reply-To: <1392287116-4548-5-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>, Tony Lindgren <tony@atomide.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Kevin Hilman <khilman@linaro.org>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On 02/13/2014 04:25 AM, Florian Vaussard wrote:
> Update the compatible string for Overo/Tobi to reflect the latest
> changes.
> 
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> ---
>  Documentation/devicetree/bindings/arm/omap/omap.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
> index 34dc40c..af9b4a0 100644
> --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
> @@ -91,7 +91,7 @@ Boards:
>    compatible = "ti,omap3-beagle", "ti,omap3"
>  
>  - OMAP3 Tobi with Overo : Commercial expansion board with daughter board
> -  compatible = "ti,omap3-tobi", "ti,omap3-overo", "ti,omap3"
> +  compatible = "gumstix,omap3-overo-tobi", "gumstix,omap3-overo", "ti,omap3"
omap3-overo-storm-tobi.dts is not covered here, so, I wonder as the
number of boards supported keep increasing, is'nt it better we drop
the board information from omap.txt?

>  
>  - OMAP4 SDP : Software Development Board
>    compatible = "ti,omap4-sdp", "ti,omap4430"
> 
-- 
Regards,
Nishanth Menon
