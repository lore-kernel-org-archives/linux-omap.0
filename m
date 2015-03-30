From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH] arm: dts: omap3: Add #iommu-cells to isp iommu
Date: Tue, 31 Mar 2015 02:18:37 +0300
Message-ID: <20150330231837.GF18321@valkosipuli.retiisi.org.uk>
References: <1427757203-6347-1-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:39137 "EHLO
	hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753343AbbC3XTO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Mar 2015 19:19:14 -0400
Content-Disposition: inline
In-Reply-To: <1427757203-6347-1-git-send-email-sre@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Sebastian,

On Tue, Mar 31, 2015 at 01:13:23AM +0200, Sebastian Reichel wrote:
> Add missing #iommu-cells property to the image signal processor's iommu
> node. This fixes the binding (property is required according to the
> generic iommu binding) and removes the following kernel warning
> triggered once the iommu node is referenced:
> 
> [    0.647521] /ocp/isp@480bc000: could not get #iommu-cells for /ocp/mmu@480bd400
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> Cc: Sakari Ailus <sakari.ailus@iki.fi>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  arch/arm/boot/dts/omap3.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index fe0b293..77751ef 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -440,6 +440,7 @@
>  		};
>  
>  		mmu_isp: mmu@480bd400 {
> +			#iommu-cells = <0>;

Could you add one for mmu_iva below, too, please?

>  			compatible = "ti,omap2-iommu";
>  			reg = <0x480bd400 0x80>;
>  			interrupts = <24>;

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
