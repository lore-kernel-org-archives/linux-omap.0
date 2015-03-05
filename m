From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: am33xx: Move wkup_m3 node to soc node
 and add ranges
Date: Thu, 5 Mar 2015 07:40:39 -0800
Message-ID: <20150305154039.GD13520@atomide.com>
References: <1425528742-3087-1-git-send-email-d-gerlach@ti.com>
 <1425528742-3087-3-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta1.delivery5.ore.mailhop.org ([54.148.219.64]:43663 "EHLO
	pmta1.delivery5.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756982AbbCEPqD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2015 10:46:03 -0500
Content-Disposition: inline
In-Reply-To: <1425528742-3087-3-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>, Suman Anna <s-anna@ti.com>, Kevin Hilman <khilman@linaro.org>, Felipe Balbi <balbi@ti.com>

* Dave Gerlach <d-gerlach@ti.com> [150304 20:14]:
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
>  arch/arm/boot/dts/am33xx.dtsi | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index acd3705..086415c 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -77,10 +77,23 @@
>  	 */
>  	soc {
>  		compatible = "ti,omap-infra";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x0     0x44d00000 0x4000>,
> +			 <0x80000 0x44d80000 0x2000>;
> +

I think putting the ranges here will cause issues for adding
ranges for anything else.

How about do something like this instead (untested):

ocp {
	l4_wkup: l4_wkup@44c00000 {
		compatible = "am335-l4-wkup", "simple-bus";
		ranges = <0 0x44c00000 0x3fffff>;

		wkup_m3: wkup_m3@44d00000 {
			compatible = "ti,am3353-wkup-m3";
			reg = <0x1000000     0x4000>,	/* M3 UMEM */
			      <0x180000	     0x2000>;	/* M3 DMEM */
			ti,hwmods = "wkup_m3";
			ti,pm-firmware = "am335x-pm-firmware.elf";
		};

		...
	};
};

That way we can start moving also the other l4_wkup components there
eventuallly without having to redo the ranges again for wkup_m3.

You can also look at how the scm_conf was done for dm816x.dtsi for an
example, and the recent large set of patches posted by Tero.

Regards,

Tony
