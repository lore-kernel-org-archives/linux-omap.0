From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH] OMAP2+: enable TPS65217 support in omap2plus_defconfig
Date: Tue, 20 Nov 2012 10:15:03 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA76FDB@DBDE01.ent.ti.com>
References: <50AA1BD5.1000002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57998 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751871Ab2KTKPK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Nov 2012 05:15:10 -0500
In-Reply-To: <50AA1BD5.1000002@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "i.mazanov@gmail.com" <i.mazanov@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Nov 19, 2012 at 17:15:25, Igor Mazanov wrote:
> TPS65217 is described in arch/arm/boot/dts/am335x-bone.dts
> but doesn't enabled in arch/arm/configs/omap2plus_defconfig.
> 
> Enable TPS65217 support in omap2plus_defconfig.
> 
> Signed-off-by: Igor Mazanov <i.mazanov@gmail.com>
> ---
>   arch/arm/configs/omap2plus_defconfig |    3 +++
>   1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig 
> b/arch/arm/configs/omap2plus_defconfig
> index 6230304..00f2ce3 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -240,3 +240,6 @@ CONFIG_CRC_ITU_T=y
>   CONFIG_CRC7=y
>   CONFIG_LIBCRC32C=y
>   CONFIG_SOC_OMAP5=y
> +CONFIG_MFD_CORE=y
> +CONFIG_MFD_TPS65217=y
> +CONFIG_REGULATOR_TPS65217=y

Hi Igor,

Can you try this, MFD_CORE is selected by default and note that
remaining flags should be added at appropriate places.

Author: AnilKumar Ch <anilkumar@ti.com>
Date:   Tue Nov 20 15:34:51 2012 +0530

    Custom: ARM: OMAP2+: omap2plus_defconfig: Add tps65217 support
    
    Signed-off-by: AnilKumar Ch <anilkumar@ti.com>

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 6230304..69ddbf7 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -132,9 +132,11 @@ CONFIG_POWER_SUPPLY=y
 CONFIG_WATCHDOG=y
 CONFIG_OMAP_WATCHDOG=y
 CONFIG_TWL4030_WATCHDOG=y
+CONFIG_MFD_TPS65217=y
 CONFIG_REGULATOR_TWL4030=y
 CONFIG_REGULATOR_TPS65023=y
 CONFIG_REGULATOR_TPS6507X=y
+CONFIG_REGULATOR_TPS65217=y
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_MODE_HELPERS=y

Thanks
AnilKumar
