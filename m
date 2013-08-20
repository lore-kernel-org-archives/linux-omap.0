From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/3] ARM: OMAP4: dts: Add main and optional clock data
 into DT
Date: Tue, 20 Aug 2013 23:57:26 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1308202352330.6426@utopia.booyaka.com>
References: <1374560679-14666-1-git-send-email-rnayak@ti.com> <1374560679-14666-4-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:45627 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab3HTX51 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Aug 2013 19:57:27 -0400
In-Reply-To: <1374560679-14666-4-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, t-kristo@ti.com, benoit.cousson@gmail.com, linux-arm-kernel@lists.infradead.org, nm@ti.com, mark.rutland@arm.com, pawel.moll@arm.com, swarren@wwwdotorg.org, tomasz.figa@gmail.com, rob.herring@calxeda.com, ian.campbell@citrix.com, galak@codeaurora.org, mturquette@linaro.org

Hi

On Tue, 23 Jul 2013, Rajendra Nayak wrote:

> With support to parse clock data from DT, move all main and optional
> clock information from hwmod to DT.
> 
> We still retain clocks in hwmod for devices which do not have a DT node.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/boot/dts/omap4.dtsi               |  100 +++++++++++++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  112 ----------------------------
>  2 files changed, 100 insertions(+), 112 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 8e142f9..4dddf64 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -106,6 +106,8 @@
>  			compatible = "ti,omap-counter32k";
>  			reg = <0x4a304000 0x20>;
>  			ti,hwmods = "counter_32k";
> +			clocks = <&sys_32k_ck>;
> +			clock-names = "fck";

Shouldn't these patches be using the official DT clock binding format?  
Either the 'clocks' property should be something like:

    clocks = <&prm 10>;

or a change to the bindings needs to be discussed and implemented.


- Paul
