From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 3/3] omap: rx51: Add supplies for the tlv320aic3x codec
 driver
Date: Wed, 5 May 2010 17:20:11 +0300
Message-ID: <20100505172011.c57044f0.jhnikula@gmail.com>
References: <1272902176-21033-1-git-send-email-jhnikula@gmail.com>
	<1272902176-21033-3-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f222.google.com ([209.85.219.222]:63228 "EHLO
	mail-ew0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760161Ab0EEOS6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 10:18:58 -0400
Received: by ewy22 with SMTP id 22so1498443ewy.37
        for <linux-omap@vger.kernel.org>; Wed, 05 May 2010 07:18:57 -0700 (PDT)
In-Reply-To: <1272902176-21033-3-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

On Mon,  3 May 2010 18:56:16 +0300
Jarkko Nikula <jhnikula@gmail.com> wrote:

> Upcoming change to tlv320aic3x codec driver require four supplies.
> Implement this by connecting analogic supplies to TWL4030 VMMC2 and digital
> supplies to TWL4030 VIO.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
> 
> ---
> 
> Analogic supplies were able to find from Maemo kernel sources and earlier
> patch from Eduardo:
> 
> http://marc.info/?l=linux-omap&m=125500331032616&w=2
> 
> I made an educated guess that digital codec supplies are connected to 1.8 V
> IO voltage and it is derived from TWL4030 VIO (like in BeagleBoard).
> ---
>  arch/arm/mach-omap2/board-rx51-peripherals.c |   60 +++++++++++++++++++++++---
>  1 files changed, 53 insertions(+), 7 deletions(-)
> 
I have one patch more to this set but it cannot be applied before this
tlv320aic3x patch hits into mainline:

http://mailman.alsa-project.org/pipermail/alsa-devel/2010-May/027408.html


-- 
Jarkko

==================== CUT HERE ============================
From: Jarkko Nikula <jhnikula@gmail.com>
Date: Wed, 5 May 2010 13:57:00 +0300
Subject: [PATCH] omap: rx51: Add platform_data for tlv320aic3x with reset gpio number

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 8179d55..0047026 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -33,6 +33,8 @@
 #include <plat/onenand.h>
 #include <plat/gpmc-smc91x.h>
 
+#include <sound/tlv320aic3x.h>
+
 #include "mux.h"
 #include "hsmmc.h"
 
@@ -664,6 +666,10 @@ static struct twl4030_platform_data rx51_twldata __initdata = {
 	.vio			= &rx51_vio,
 };
 
+static struct aic3x_pdata rx51_aic3x_data __initdata = {
+	.gpio_reset		= 60,
+};
+
 static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_1[] = {
 	{
 		I2C_BOARD_INFO("twl5030", 0x48),
@@ -676,6 +682,7 @@ static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_1[] = {
 static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_2[] = {
 	{
 		I2C_BOARD_INFO("tlv320aic3x", 0x18),
+		.platform_data = &rx51_aic3x_data,
 	},
 };
 
-- 
1.7.0
