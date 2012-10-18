From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH] ARM/dts: omap3: Fix mcbsp2/3 hwmods to be able to probe
 the drivers for audio
Date: Thu, 18 Oct 2012 12:00:12 +0200
Message-ID: <507FD32C.7010108@ti.com>
References: <1350552307-10226-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45146 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932118Ab2JRKAV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Oct 2012 06:00:21 -0400
In-Reply-To: <1350552307-10226-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On 10/18/2012 11:25 AM, Peter Ujfalusi wrote:
> Fixes the following errors:
> [    2.318084] omap-mcbsp 49022000.mcbsp: invalid rx DMA channel
> [    2.324432] omap-mcbsp 49024000.mcbsp: invalid rx DMA channel
> 
> Which is because we failed to link the sidetone hwmod for McBSP2/3. The
> missing sidetone hwmod link will prevent omap_device_alloc() to append the
> DMA resources since we - accidentally - end up having the same number of
> resources provided from DT (IO/IRQ) as we have in hwmod for the McBSP ports
> without the ST resources.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Acked-by: Benoit Cousson <b-cousson@ti.com>

Regards,
Benoit

> ---
> 
> Hi Tony, Benoit,
> 
> Can you please take this patch for 3.7 since if we boot with DT audio will not
> work on BeagleBoard and on boards which uses McBSP2 or 3 for audio.
> 
> Thank you,
> Peter
> 
>  arch/arm/boot/dts/omap3.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index f38ea87..696e929 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -257,7 +257,7 @@
>  			interrupt-names = "common", "tx", "rx", "sidetone";
>  			interrupt-parent = <&intc>;
>  			ti,buffer-size = <1280>;
> -			ti,hwmods = "mcbsp2";
> +			ti,hwmods = "mcbsp2", "mcbsp2_sidetone";
>  		};
>  
>  		mcbsp3: mcbsp@49024000 {
> @@ -272,7 +272,7 @@
>  			interrupt-names = "common", "tx", "rx", "sidetone";
>  			interrupt-parent = <&intc>;
>  			ti,buffer-size = <128>;
> -			ti,hwmods = "mcbsp3";
> +			ti,hwmods = "mcbsp3", "mcbsp3_sidetone";
>  		};
>  
>  		mcbsp4: mcbsp@49026000 {
> 

