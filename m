From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/4] ARM: dts: omap5-uevm: Add USB Host support
Date: Wed, 5 Jun 2013 08:57:39 -0500
Message-ID: <20130605135739.GA11193@kahuna>
References: <1370414770-1485-1-git-send-email-r.sricharan@ti.com>
 <1370414770-1485-3-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44352 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755504Ab3FEN6F (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Jun 2013 09:58:05 -0400
Content-Disposition: inline
In-Reply-To: <1370414770-1485-3-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, rnayak@ti.com, b-cousson@ti.com, Roger Quadros <rogerq@ti.com>

On 12:16-20130605, Sricharan R wrote:
> From: Roger Quadros <rogerq@ti.com>
[...]
> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
> index 843a001..cf862df 100644
> --- a/arch/arm/boot/dts/omap5-uevm.dts
> +++ b/arch/arm/boot/dts/omap5-uevm.dts
<snip>
> +	/* hsusb2_phy is clocked by FREF_CLK1 i.e. auxclk1 */
> +	clock_alias {
> +		clock-name = "auxclk1_ck";
> +		clock-alias = "main_clk";
is'nt this better to use with clock node?
> +		device = <&hsusb2_phy>;
> +		clock-frequency = <19200000>; /* 19.2 MHz */
> +	};
>  };
<snip>
-- 
Regards,
Nishanth Menon
