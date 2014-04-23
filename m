From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 1/3] Documentation: dts: OMAP: Fix typos in DRA752 device
 name
Date: Wed, 23 Apr 2014 14:09:46 +0530
Message-ID: <53577C52.1020809@ti.com>
References: <1394788841-15112-1-git-send-email-rnayak@ti.com> <1394788841-15112-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40583 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217AbaDWIlg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Apr 2014 04:41:36 -0400
In-Reply-To: <1394788841-15112-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, tony@atomide.com, bcousson@baylibre.com, "Menon, Nishanth" <nm@ti.com>

On Friday 14 March 2014 02:50 PM, Rajendra Nayak wrote:
> DRA752 device is wrongly documented as DRA742 device. Fix the typo.

Thanks to Nishanth for pointing out that the device part number is infact
DRA742. The compatible sting infact seems to have a typo. I'll fix
that up a post a v2 of this series soon.

> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  .../devicetree/bindings/arm/omap/omap.txt          |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
> index af9b4a0..0491868 100644
> --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
> @@ -48,7 +48,7 @@ SoC Families:
>    compatible = "ti,omap4"
>  - OMAP5 generic - defaults to OMAP5430
>    compatible = "ti,omap5"
> -- DRA7 generic - defaults to DRA742
> +- DRA7 generic - defaults to DRA752
>    compatible = "ti,dra7"
>  - AM43x generic - defaults to AM4372
>    compatible = "ti,am43"
> @@ -79,7 +79,7 @@ SoCs:
>  - OMAP5432
>    compatible = "ti,omap5432", "ti,omap5"
>  
> -- DRA742
> +- DRA752
>    compatible = "ti,dra7xx", "ti,dra7"
>  
>  - AM4372
> 

