From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/5] ARM: dts: omap3: set mcbsp2 status
Date: Tue, 27 May 2014 13:40:02 -0700
Message-ID: <20140527204002.GC32336@atomide.com>
References: <1400799986-20043-1-git-send-email-chf.fritz@googlemail.com>
 <1400799986-20043-4-git-send-email-chf.fritz@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53373 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbaE0UkK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 May 2014 16:40:10 -0400
Content-Disposition: inline
In-Reply-To: <1400799986-20043-4-git-send-email-chf.fritz@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Pekon Gupta <pekon@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Daniel Mack <zonque@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Christoph Fritz <chf.fritz@googlemail.com> [140522 16:07]:
> This patch fixes audio support for omap3-lilly-a83x.

Applying this into omap-for-v3.16/dt-v2 thanks.

Tony
 
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> ---
>  arch/arm/boot/dts/omap3-lilly-a83x.dtsi |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
> index cc1dce6..2b3af90 100644
> --- a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
> +++ b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
> @@ -357,6 +357,10 @@
>  	power = <50>;
>  };
>  
> +&mcbsp2 {
> +	status = "okay";
> +};
> +
>  &gpmc {
>  	ranges = <0 0 0x30000000 0x1000000>,
>  		<7 0 0x15000000 0x01000000>;
> -- 
> 1.7.10.4
> 
