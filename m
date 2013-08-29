From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v2 2/3] ARM: OMAP4+: Move SRAM data to DT
Date: Thu, 29 Aug 2013 18:56:01 +0530
Message-ID: <521F4BE9.60004@ti.com>
References: <1377775391-13103-1-git-send-email-rnayak@ti.com> <1377775391-13103-3-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51266 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752573Ab3H2N0c (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Aug 2013 09:26:32 -0400
In-Reply-To: <1377775391-13103-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcousson@baylibre.com, santosh.shilimkar@ti.com, paul@pwsan.com

On 8/29/2013 4:53 PM, Rajendra Nayak wrote:
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 22d9f2b..1ba6a77 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -126,6 +126,11 @@
>  			pinctrl-single,function-mask = <0x7fff>;
>  		};
>  
> +		ocmcram: ocmcram@40304000 {

This can now be changed to 0x40300000 now that you have moved to
gen_pool_alloc()?

Thanks,
Sekhar
