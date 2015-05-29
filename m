From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: Remove L3 compatible value for dm816x
Date: Fri, 29 May 2015 13:39:38 -0700
Message-ID: <20150529203937.GU30984@atomide.com>
References: <1432920112-21539-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:54751 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756539AbbE2Ujk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 May 2015 16:39:40 -0400
Content-Disposition: inline
In-Reply-To: <1432920112-21539-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [150529 10:28]:
> The interconnects on dm816x are like on omap4, so we should use
> l3-noc instead of l3-smx. But as the related SoC specific
> l3_target_data is still missing from omap_l3_noc let's just
> remove the entry for now.
> 
> Cc: Brian Hutchinson <b.hutchman@gmail.com>
> Reported-by: Matthijs van Duin <matthijsvanduin@gmail.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/boot/dts/dm816x.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
> index 289806a..3c99cfa 100644
> --- a/arch/arm/boot/dts/dm816x.dtsi
> +++ b/arch/arm/boot/dts/dm816x.dtsi
> @@ -58,7 +58,7 @@
>  	 * the whole bus hierarchy.
>  	 */
>  	ocp {
> -		compatible = "ti,omap3-l3-smx", "simple-bus";
> +		compatible = "simple-bus";
>  		reg = <0x44000000 0x10000>;
>  		interrupts = <9 10>;
>  		#address-cells = <1>;

We should remove reg and interrupts too, updated patch below.

Regards,

Tony

8< ---------------
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 16 Mar 2015 18:04:20 -0700
Subject: [PATCH] ARM: dts: Remove L3 compatible value for dm816x

The interconnects on dm816x are like on omap4, so we should use
l3-noc instead of l3-smx. But as the related SoC specific
l3_target_data is still missing from omap_l3_noc let's just
remove the entry for now. And as we're updating the dts files
to follow the interconnect layout, this module will not be at
the top level.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Reported-by: Matthijs van Duin <matthijsvanduin@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -58,9 +58,7 @@
 	 * the whole bus hierarchy.
 	 */
 	ocp {
-		compatible = "ti,omap3-l3-smx", "simple-bus";
-		reg = <0x44000000 0x10000>;
-		interrupts = <9 10>;
+		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
