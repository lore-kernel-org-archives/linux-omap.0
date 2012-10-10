From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 2/3] ARM: dts: Correcting size of memory defined for omap5
Date: Wed, 10 Oct 2012 17:15:02 +0200
Message-ID: <507590F6.3050702@ti.com>
References: <1349870716-25511-1-git-send-email-lokeshvutla@ti.com> <1349870716-25511-3-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45539 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932264Ab2JJPPJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Oct 2012 11:15:09 -0400
In-Reply-To: <1349870716-25511-3-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com

On 10/10/2012 02:05 PM, Lokesh Vutla wrote:
> Memory present for omap5 is 2GB. But in dt file

omap5 -> OMAP5
dt -> dts

And this patch is about omap5-evm so you should be more specific in your
changelog and even in the subject:

ARM: dts: omap5-evm: Fix size of memory defined for EVM

> it is specified as 1GB. Correcting the same
> in this patch

No "patch" in the changelog, please add a dot at the end of a sentence
and make a correct sentence.

Regards,
Benoit

> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  arch/arm/boot/dts/omap5-evm.dts |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/omap5-evm.dts b/arch/arm/boot/dts/omap5-evm.dts
> index 9c41a3f..6f87e1a 100644
> --- a/arch/arm/boot/dts/omap5-evm.dts
> +++ b/arch/arm/boot/dts/omap5-evm.dts
> @@ -15,7 +15,7 @@
>  
>  	memory {
>  		device_type = "memory";
> -		reg = <0x80000000 0x40000000>; /* 1 GB */
> +		reg = <0x80000000 0x80000000>; /* 2 GB */
>  	};
>  
>  	vmmcsd_fixed: fixedregulator-mmcsd {
> 

