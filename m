From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2 2/2] ARM: dts: DRA7: Add node for RTC
Date: Wed, 9 Jul 2014 02:12:32 -0700
Message-ID: <20140709091232.GJ28884@atomide.com>
References: <alpine.DEB.2.02.1407060031120.23762@utopia.booyaka.com>
 <1404894932-26677-1-git-send-email-lokeshvutla@ti.com>
 <1404894932-26677-3-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:38487 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751268AbaGIJMd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jul 2014 05:12:33 -0400
Content-Disposition: inline
In-Reply-To: <1404894932-26677-3-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rnayak@ti.com, devicetree@vger.kernel.org, nm@ti.com, j-keerthy@ti.com, nsekhar@ti.com

* Lokesh Vutla <lokeshvutla@ti.com> [140709 01:37]:
> Add node for RTC.
> And also making RTC regulator always-on, as RTC should be powered
> always.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> [nm@ti.com: update with rtc crossbar number]
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> This patch depends on the crossbar dt patch series by Sricharan:
> https://www.mail-archive.com/linux-omap@vger.kernel.org/msg106910.html
> 
>  arch/arm/boot/dts/dra7-evm.dts |    1 +
>  arch/arm/boot/dts/dra7.dtsi    |    9 +++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
> index 4adc280..bca6d4a 100644
> --- a/arch/arm/boot/dts/dra7-evm.dts
> +++ b/arch/arm/boot/dts/dra7-evm.dts
> @@ -249,6 +249,7 @@
>  					regulator-min-microvolt = <1050000>;
>  					regulator-max-microvolt = <1050000>;
>  					regulator-boot-on;
> +					regulator-always-on;
>  				};
>  

Is this regulator really always on?

Regards,

Tony
