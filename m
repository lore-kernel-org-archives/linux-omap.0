From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] OMAP hwspinlock DT updates
Date: Fri, 28 Feb 2014 14:14:39 -0800
Message-ID: <20140228221439.GI13624@atomide.com>
References: <1389659207-39445-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19010 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752036AbaB1WOx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Feb 2014 17:14:53 -0500
Content-Disposition: inline
In-Reply-To: <1389659207-39445-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, Mark Rutland <mark.rutland@arm.com>, Ohad Ben-Cohen <ohad@wizery.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Suman Anna <s-anna@ti.com> [140113 16:29]:
> Hi,
> 
> This series updates the existing OMAP hwspinlock DT nodes to have a
> #hwlock-cells property as suggested by Mark Rutland [1], and adds the
> hwspinlock nodes for two other newer SoCs - DRA7xx and AM43xx.
> 
> Posting the series separately from the driver DT adapation changes [2]
> to avoid maintainer confusion.

Thanks applying into omap-for-v3.15/dt.

Tony
 
> [1] http://marc.info/?l=linux-omap&m=138433541420926&w=2
> [2] http://marc.info/?l=linux-omap&m=138965904015225&w=2 
> 
> Suman Anna (3):
>   ARM: dts: OMAP: Add #hwlock-cells property to hwspinlock nodes
>   ARM: dts: DRA7: Add hwspinlock node
>   ARM: dts: AM4372: Add hwspinlock node
> 
>  arch/arm/boot/dts/am33xx.dtsi | 1 +
>  arch/arm/boot/dts/am4372.dtsi | 7 +++++++
>  arch/arm/boot/dts/dra7.dtsi   | 7 +++++++
>  arch/arm/boot/dts/omap4.dtsi  | 1 +
>  arch/arm/boot/dts/omap5.dtsi  | 1 +
>  5 files changed, 17 insertions(+)
> 
> -- 
> 1.8.4.3
> 
