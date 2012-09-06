From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/8] ARM/dts: omap2420-h4: Include omap2420.dtsi
 file instead the common omap2
Date: Thu, 6 Sep 2012 13:18:18 -0700
Message-ID: <20120906201818.GG1303@atomide.com>
References: <1346247067-9632-1-git-send-email-peter.ujfalusi@ti.com>
 <1346247067-9632-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64162 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759623Ab2IFUSV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 16:18:21 -0400
Content-Disposition: inline
In-Reply-To: <1346247067-9632-3-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120829 06:31]:
> Since the board is based on OMAP2420 we should include the dedicated dtsi
> file (which includes the common omap2 dtsi).
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  arch/arm/boot/dts/omap2420-h4.dts |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap2420-h4.dts b/arch/arm/boot/dts/omap2420-h4.dts
> index 25b50b7..77b84e1 100644
> --- a/arch/arm/boot/dts/omap2420-h4.dts
> +++ b/arch/arm/boot/dts/omap2420-h4.dts
> @@ -7,7 +7,7 @@
>   */
>  /dts-v1/;
>  
> -/include/ "omap2.dtsi"
> +/include/ "omap2420.dtsi"
>  
>  / {
>  	model = "TI OMAP2420 H4 board";

Oops looks like I have this too in one of my patches. I'll drop
that part in my patches.

Tony
