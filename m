From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 1/5] arm/dts: OMAP4: Update DTS file with new GIC
 bindings
Date: Fri, 6 Jan 2012 14:15:58 -0700
Message-ID: <20120106211558.GA7457@ponder.secretlab.ca>
References: <1324388398-2683-1-git-send-email-b-cousson@ti.com>
 <1324388398-2683-2-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:39372 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759171Ab2AFVQA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jan 2012 16:16:00 -0500
Received: by obcwo16 with SMTP id wo16so2375801obc.19
        for <linux-omap@vger.kernel.org>; Fri, 06 Jan 2012 13:16:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1324388398-2683-2-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: rob.herring@calxeda.com, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Dec 20, 2011 at 02:39:54PM +0100, Benoit Cousson wrote:
> The GIC binding was updated in 3.2 and expect 3 interrupt-cells.
> - Update the #interrupt-cells
> - interrupt-parent seems to be needed as well for the top level GIC

Hmmm... it shouldn't be.  If it is then it is a bug.

g.

> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Rob Herring <rob.herring@calxeda.com>
> ---
>  arch/arm/boot/dts/omap4.dtsi |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 4c61c82..bede009 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -95,7 +95,8 @@
>  		gic: interrupt-controller@48241000 {
>  			compatible = "arm,cortex-a9-gic";
>  			interrupt-controller;
> -			#interrupt-cells = <1>;
> +			interrupt-parent;
> +			#interrupt-cells = <3>;
>  			reg = <0x48241000 0x1000>,
>  			      <0x48240100 0x0100>;
>  		};
> -- 
> 1.7.0.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
