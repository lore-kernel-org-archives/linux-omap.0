From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv10 22/41] ARM: dts: omap5 clock data
Date: Mon, 16 Dec 2013 10:51:18 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1312161046530.31680@utopia.booyaka.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com> <1385453182-24421-23-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:47632 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184Ab3LPKvT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Dec 2013 05:51:19 -0500
In-Reply-To: <1385453182-24421-23-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Tue, 26 Nov 2013, Tero Kristo wrote:

> This patch creates a unique node for each clock in the OMAP5 power,
> reset and clock manager (PRCM).

...

> +&cm_core_aon {
> +	pad_clks_src_ck: pad_clks_src_ck {
> +		#clock-cells = <0>;
> +		compatible = "fixed-clock";
> +		clock-frequency = <12000000>;
> +	};
> +
> +	pad_clks_ck: pad_clks_ck {
> +		#clock-cells = <0>;
> +		compatible = "ti,gate-clock";
> +		clocks = <&pad_clks_src_ck>;
> +		ti,bit-shift = <8>;
> +		reg = <0x0108>;
> +	};

All of the clock data should be underneath a "clocks {" node, for all of 
the chips.  Please see the Calxeda ECX clocks DT data as an example of how 
this should look:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/ecx-common.dtsi#n141


- Paul
