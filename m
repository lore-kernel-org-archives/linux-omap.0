From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] fix ehrpwm tbclk data on am33xx and am43xx
Date: Tue, 24 Feb 2015 09:15:46 -0800
Message-ID: <20150224171546.GB28244@atomide.com>
References: <1423546542-29664-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta2.delivery6.ore.mailhop.org ([54.200.129.228]:45990 "EHLO
	pmta2.delivery6.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752339AbbBXRUH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Feb 2015 12:20:07 -0500
Content-Disposition: inline
In-Reply-To: <1423546542-29664-1-git-send-email-vigneshr@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, Tero Kristo <t-kristo@ti.com>, Russell King <linux@arm.linux.org.uk>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

* Vignesh R <vigneshr@ti.com> [150209 22:43]:
> In am33xx and am43xx, ehrpwm tbclk is derived from functional clock of
> PWMSS. The schematics and TRMs show that there is only one input clock to
> the PWMSS. But currently, tbclk is wrongly shown to be deriving from
> dpll_per_m2_ck instead of functional clock l4ls_gclk in the DT.
> 
> Fixing ehrpwm tbclk data to reflect the right clk source.
> Tested on beaglebone and am437x-gp-evm.
> 
> Vignesh R (2):
>   ARM: dts: am33xx-clocks: Fix ehrpwm tbclk data on am33xx
>   ARM: dts: am43xx-clocks: Fix ehrpwm tbclk data on am43xx
> 
>  arch/arm/boot/dts/am33xx-clocks.dtsi |  6 +++---
>  arch/arm/boot/dts/am43xx-clocks.dtsi | 12 ++++++------
>  2 files changed, 9 insertions(+), 9 deletions(-)

Tero, care to check this one too and ack if OK?

Thanks,

Tony
