From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Documentation: dt: update properties in TI GPMC NAND example
Date: Tue, 16 Apr 2013 11:01:24 +0100
Message-ID: <20130416100124.78A3B3E14C0@localhost>
References: <1365528215-5030-1-git-send-email-jon-hunter@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:32927 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935469Ab3DPKBa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Apr 2013 06:01:30 -0400
Received: by mail-wg0-f47.google.com with SMTP id j13so271194wgh.26
        for <linux-omap@vger.kernel.org>; Tue, 16 Apr 2013 03:01:29 -0700 (PDT)
In-Reply-To: <1365528215-5030-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, Jon Hunter <jon-hunter@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Tue, 9 Apr 2013 12:23:35 -0500, Jon Hunter <jon-hunter@ti.com> wrote:
> The GPMC timing properties for device-tree have been updated
> by adding a "-ns" or "-ps" suffix to indicate the units of
> time the property represents. Therefore, update the timing
> property names for TI GPMC NAND example.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  .../devicetree/bindings/mtd/gpmc-nand.txt          |   28 ++++++++++----------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> index e7f8d7e..6a983c1 100644
> --- a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> @@ -56,20 +56,20 @@ Example for an AM33xx board:
>  			nand-bus-width = <16>;
>  			ti,nand-ecc-opt = "bch8";
>  
> -			gpmc,sync-clk = <0>;
> -			gpmc,cs-on = <0>;
> -			gpmc,cs-rd-off = <44>;
> -			gpmc,cs-wr-off = <44>;
> -			gpmc,adv-on = <6>;
> -			gpmc,adv-rd-off = <34>;
> -			gpmc,adv-wr-off = <44>;
> -			gpmc,we-off = <40>;
> -			gpmc,oe-off = <54>;
> -			gpmc,access = <64>;
> -			gpmc,rd-cycle = <82>;
> -			gpmc,wr-cycle = <82>;
> -			gpmc,wr-access = <40>;
> -			gpmc,wr-data-mux-bus = <0>;
> +			gpmc,sync-clk-ps = <0>;
> +			gpmc,cs-on-ns = <0>;
> +			gpmc,cs-rd-off-ns = <44>;
> +			gpmc,cs-wr-off-ns = <44>;
> +			gpmc,adv-on-ns = <6>;
> +			gpmc,adv-rd-off-ns = <34>;
> +			gpmc,adv-wr-off-ns = <44>;
> +			gpmc,we-off-ns = <40>;
> +			gpmc,oe-off-ns = <54>;
> +			gpmc,access-ns = <64>;
> +			gpmc,rd-cycle-ns = <82>;
> +			gpmc,wr-cycle-ns = <82>;
> +			gpmc,wr-access-ns = <40>;
> +			gpmc,wr-data-mux-bus-ns = <0>;
>  
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
