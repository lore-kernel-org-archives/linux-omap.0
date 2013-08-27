From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 0/2] OMAP4+: Get rid of internal SRAM handling
Date: Tue, 27 Aug 2013 09:25:51 -0400
Message-ID: <521CA8DF.9040400@ti.com>
References: <1377598305-15539-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46537 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753432Ab3H0N0V (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Aug 2013 09:26:21 -0400
In-Reply-To: <1377598305-15539-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcousson@baylibre.com, Paul Walmsley <paul@pwsan.com>

+ Paul,

On Tuesday 27 August 2013 06:11 AM, Rajendra Nayak wrote:
> Make all OMAP DT only platforms (am33xx, am43xx, omap4 and omap5)
> use drivers/misc/sram.c driver instead of the omap internal
> implementation for SRAM handling.
> 
> Rajendra Nayak (2):
>   ARM: AM335x: Get rid of unused sram init function
>   ARM: OMAP4+: Move SRAM data to DT
> 
>  arch/arm/boot/dts/am33xx.dtsi        |    5 +++++
>  arch/arm/boot/dts/am4372.dtsi        |    5 +++++
>  arch/arm/boot/dts/omap4.dtsi         |    5 +++++
>  arch/arm/boot/dts/omap5.dtsi         |    5 +++++
>  arch/arm/configs/omap2plus_defconfig |    1 +
>  arch/arm/mach-omap2/sram.c           |   39 +---------------------------------
>  arch/arm/mach-omap2/sram.h           |    1 -
>  7 files changed, 22 insertions(+), 39 deletions(-)
> 
Really nice to see the SRAM code getting moved now. Thanks
a lot Rajendra.

- The sram_init() seems to be the post core init call.
Hope this is not a problem for SDRC init which needs to have
SRAM ready to update the DDR parameters.

Regards,
Santosh


