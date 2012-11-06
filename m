From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH RESEND 00/10] ARM: dts: AM33XX: Add device tree data
Date: Tue, 6 Nov 2012 15:56:48 +0100
Message-ID: <50992530.8030501@ti.com>
References: <1352209718-5586-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42604 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750977Ab2KFO5H (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Nov 2012 09:57:07 -0500
In-Reply-To: <1352209718-5586-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org

Hi Anil,

On 11/06/2012 02:48 PM, AnilKumar Ch wrote:
> Add device tree date for GPIO based various drivers matrix keypad,
> volume keys, push buttons and use leds accross three AM33XX devices
> viz EVM, BeagleBone and Starter Kit.
> 
> To make it functional this series also adds pinctrl data for all
> the GPIOs used by various drivers. In this series only default state
> pinmux/conf settings are added because of sleep/idle state pinctrl
> values are not available.
> 
> These patches are based on linux-omap-dt:for_3.8/dts_part2 tree and
> these were tested on am33xx devices according to added functionality.
> 
> Change log:
> 	- Rebased on for_3.8/dts_part2

Thanks for the update. Applied in for_3.8/dts_part2.

BTW, I've just noticed that am335x-evmsk is not built with make dtbs. The target was missing from the arch/arm/boot/dts/Makefile.

Please find below the patch to add it.

Thanks,
Benoit

---
>From 6990451aca80a5107206688308302241f799057a Mon Sep 17 00:00:00 2001
From: Benoit Cousson <b-cousson@ti.com>
Date: Tue, 6 Nov 2012 15:52:23 +0100
Subject: [PATCH] ARM: dts: Makefile: Add the am335x-evmsk target in dtbs list

The EVMSK was not built with the 'make dtbs' command.
Add the missing antry in the dts Makefile.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/boot/dts/Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 634bd42..2458b69 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -73,6 +73,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	omap4-sdp.dtb \
 	omap5-evm.dtb \
 	am335x-evm.dtb \
+	am335x-evmsk.dtb \
 	am335x-bone.dtb
 dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
 dtb-$(CONFIG_ARCH_U8500) += snowball.dtb
-- 
1.7.0.4

