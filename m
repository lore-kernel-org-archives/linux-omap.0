From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH 1/1] Default MUX configuration added - GPIO140-143,
 GPIO0 and GPIO9
Date: Tue, 16 Dec 2008 11:07:36 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087025127BA53@dbde02.ent.ti.com>
References: <1229405483-32438-1-git-send-email-mani.pillai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36788 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbYLPFht convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Dec 2008 00:37:49 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id mBG5bfuW020663
	for <linux-omap@vger.kernel.org>; Mon, 15 Dec 2008 23:37:47 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id mBG5bfMr026470
	for <linux-omap@vger.kernel.org>; Tue, 16 Dec 2008 11:07:41 +0530 (IST)
In-Reply-To: <1229405483-32438-1-git-send-email-mani.pillai@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pillai, Manikandan" <mani.pillai@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Pillai,
>Manikandan
>Sent: Monday, December 15, 2008 11:31 PM
>To: linux-omap@vger.kernel.org
>Cc: Pillai, Manikandan
>Subject: [PATCH 1/1] Default MUX configuration added - GPIO140-143, GPIO0 and GPIO9
>
>Default MUX configurations for GPIO on OMAP3 EVM boards are added.
>Fixed for "_UP" naming convention for GPIOs comment.

Patch is fine but looks like 
Mux framework seems to be not efficient.

"There is one GLOBAL table for all omap devices." 
How maintainable is that? 
Also care has to be taken to match the enum position with mux.c array location. This is error prone.

Mux tables should be per device basis.
Any thoughts.


>
>Signed-off-by: Manikandan Pillai <mani.pillai@ti.com>
>---
> arch/arm/mach-omap2/mux.c             |   13 +++++++++++++
> arch/arm/plat-omap/include/mach/mux.h |    6 ++++++
> 2 files changed, 19 insertions(+), 0 deletions(-)
>
>diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
>index dacb41f..1556688 100644
>--- a/arch/arm/mach-omap2/mux.c
>+++ b/arch/arm/mach-omap2/mux.c
>@@ -459,6 +459,19 @@ MUX_CFG_34XX("AH8_34XX_GPIO29", 0x5fa,
> 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
> MUX_CFG_34XX("J25_34XX_GPIO170", 0x1c6,
> 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
>+MUX_CFG_34XX("AF26_34XX_GPIO0", 0x1e0,
>+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
>+MUX_CFG_34XX("AF22_34XX_GPIO9", 0xa18,
>+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
>+MUX_CFG_34XX("AF6_34XX_GPIO140_UP", 0x16c,
>+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT_PULLUP)
>+MUX_CFG_34XX("AE6_34XX_GPIO141", 0x16e,
>+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
>+MUX_CFG_34XX("AF5_34XX_GPIO142", 0x170,
>+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
>+MUX_CFG_34XX("AE5_34XX_GPIO143", 0x172,
>+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
>+
> };
>
> #define OMAP34XX_PINS_SZ	ARRAY_SIZE(omap34xx_pins)
>diff --git a/arch/arm/plat-omap/include/mach/mux.h b/arch/arm/plat-omap/include/mach/mux.h
>index f4362b8..67fddec 100644
>--- a/arch/arm/plat-omap/include/mach/mux.h
>+++ b/arch/arm/plat-omap/include/mach/mux.h
>@@ -790,6 +790,12 @@ enum omap34xx_index {
> 	 */
> 	AH8_34XX_GPIO29,
> 	J25_34XX_GPIO170,
>+	AF26_34XX_GPIO0,
>+	AF22_34XX_GPIO9,
>+	AF6_34XX_GPIO140_UP,
>+	AE6_34XX_GPIO141,
>+	AF5_34XX_GPIO142,
>+	AE5_34XX_GPIO143
> };
>
> struct omap_mux_cfg {
>--
>1.5.6
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

