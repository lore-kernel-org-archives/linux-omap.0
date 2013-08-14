From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 0/4] Add USB Host support for OMAP5 uevm
Date: Wed, 14 Aug 2013 11:10:57 +0300
Message-ID: <520B3B91.9080408@ti.com>
References: <1374676356-31286-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49825 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759491Ab3HNIMj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Aug 2013 04:12:39 -0400
In-Reply-To: <1374676356-31286-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Roger Quadros <rogerq@ti.com>, tony@atomide.com, t-kristo@ti.com, mturquette@linaro.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

+Benoit

On 07/24/2013 05:32 PM, Roger Quadros wrote:
> Hi,
> 
> These patches provide USB host support for the OMAP5 uEVM board.
> 
> They depend on the OMAP clock tree DT data series by Tero Kristo [1]
> 
> In patch 3 we also provide USB PHY clock for Panda. This should make
> the clock alias patch [2] redundant and it should be reverted when
> this series gets in.
> 
> [1] - http://thread.gmane.org/gmane.linux.ports.arm.omap/101582
> 
> [2] - ARM: OMAP2+: Provide alias to USB PHY clock
> http://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/commit/?h=omap-for-v3.11/fixes&id=741532c4a995be11815cb72d4d7a48f442a22fea
> 
> cheers,
> -roger
> 
> ---
> Roger Quadros (4):
>   ARM: OMAP5: hwmod data: Add USB Host and TLL modules
>   ARM: dts: OMAP5: Add 60MHz clock reference to USB Host module
>   ARM: dts: omap4-panda: Provide USB PHY clock
>   ARM: dts: omap5-uevm: Provide USB PHY clock
> 
>  arch/arm/boot/dts/omap4-panda-common.dtsi  |    8 +-
>  arch/arm/boot/dts/omap5-uevm.dts           |    8 +-
>  arch/arm/boot/dts/omap5.dtsi               |    2 +
>  arch/arm/mach-omap2/omap_hwmod_54xx_data.c |  157 ++++++++++++++++++++++++++++
>  4 files changed, 163 insertions(+), 12 deletions(-)
> 

