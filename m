From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 2/5] omap board changes for v3.6 merge window
Date: Tue, 10 Jul 2012 15:34:12 +0000
Message-ID: <201207101534.13166.arnd@arndb.de>
References: <0M4ZFU-1RqIwX3VUq-00yonj@mx.kundenserver.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:55028 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661Ab2GJPeY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jul 2012 11:34:24 -0400
In-Reply-To: <0M4ZFU-1RqIwX3VUq-00yonj@mx.kundenserver.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Zumeng Chen <zumeng.chen@windriver.com>, Igor Grinberg <grinberg@compulab.co.il>

On Tuesday 10 July 2012, Tony Lindgren wrote:
> The following changes since commit 6887a4131da3adaab011613776d865f4bcfb5678:
> 
>   Linux 3.5-rc5 (2012-06-30 16:08:57 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-devel-board-for-v3.6
> 
> for you to fetch changes up to b103a2e22a238085f5c50d96345e1a09bb1efd50:
> 
>   ARM: OMAP3: Fix omap3evm randconfig error introduced by VBUS support (2012-07-09 23:22:24 -0700)
> 
> ----------------------------------------------------------------
> Board and platform data related changes for omaps
> 
> ----------------------------------------------------------------
> Andy Gross (1):
>       omap2+: add drm device
> 
> Dmitry Lifshitz (2):
>       ARM: OMAP3: cm-t35: add mt9t001 camera sensor support
>       ARM: OMAP3: cm-t35: add tvp5150 decoder support
> 
> Peter Ujfalusi (2):
>       ARM: OMAP: board-4430sdp: MUX configuration for sys_nirq2
>       ARM: OMAP: board-omap4panda: MUX configuration for sys_nirq2
> 
> Tony Lindgren (1):
>       ARM: OMAP3: Fix omap3evm randconfig error introduced by VBUS support
> 
> Zumeng Chen (4):
>       ARM: OMAP3EVM: Add NAND flash definition
>       ARM: OMAP3EVM: Adding USB internal LDOs board file
>       ARM: omap3evm: enable VBUS switch for EHCI tranceiver
>       ARM: OMAP3530evm: set pendown_state and debounce time for ads7846

> diff --cc arch/arm/mach-omap2/common-board-devices.c

I got a conflict in arch/arm/mach-omap2/common-board-devices.c between
16aced80f6739 "ARM: OMAP3530evm: set pendown_state and debounce time for
ads7846" and 97ee9f01d6f26 "ARM: OMAP: fix the ads7846 init code",
see my resolution below.

Please check if what I have in the for-next branch makese sense to you
all.

	Arnd

* Unmerged path arch/arm/mach-omap2/common-board-devices.c
diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/mach-omap2/common-board-devices.c
index 1706ebc..1473474 100644
--- a/arch/arm/mach-omap2/common-board-devices.c
+++ b/arch/arm/mach-omap2/common-board-devices.c
@@ -35,6 +35,16 @@ static struct omap2_mcspi_device_config ads7846_mcspi_config = {
 	.turbo_mode	= 0,
  };
 
 +/*
 + * ADS7846 driver maybe request a gpio according to the value
 + * of pdata->get_pendown_state, but we have done this. So set
 + * get_pendown_state to avoid twice gpio requesting.
 + */
 +static int omap3_get_pendown_state(void)
 +{
 +	return !gpio_get_value(OMAP3_EVM_TS_GPIO);
 +}
 +
  static struct ads7846_platform_data ads7846_config = {
 	.x_max			= 0x0fff,
 	.y_max			= 0x0fff,
@@ -45,6 +55,7 @@ static struct ads7846_platform_data ads7846_config = {
 	.debounce_rep		= 1,
 	.gpio_pendown		= -EINVAL,
 	.keep_vref_on		= 1,
 +	.get_pendown_state	= &omap3_get_pendown_state,
  };
 
  static struct spi_board_info ads7846_spi_board_info __initdata = {
@@ -63,28 +74,30 @@ void __init omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
 	struct spi_board_info *spi_bi = &ads7846_spi_board_info;
 	int err;
 
-	if (board_pdata && board_pdata->get_pendown_state) {
-		err = gpio_request_one(gpio_pendown, GPIOF_IN, "TSPenDown");
-		if (err) {
-			pr_err("Couldn't obtain gpio for TSPenDown: %d\n", err);
-			return;
-		}
-		gpio_export(gpio_pendown, 0);
-
-		if (gpio_debounce)
-			gpio_set_debounce(gpio_pendown, gpio_debounce);
+	err = gpio_request_one(gpio_pendown, GPIOF_IN, "TSPenDown");
+	if (err) {
+		pr_err("Couldn't obtain gpio for TSPenDown: %d\n", err);
+		return;
 	}
 
+	if (gpio_debounce)
+		gpio_set_debounce(gpio_pendown, gpio_debounce);
+
 	spi_bi->bus_num	= bus_num;
 	spi_bi->irq	= gpio_to_irq(gpio_pendown);
 
 	if (board_pdata) {
 		board_pdata->gpio_pendown = gpio_pendown;
 		spi_bi->platform_data = board_pdata;
+		if (board_pdata->get_pendown_state)
+			gpio_export(gpio_pendown, 0);
 	} else {
 		ads7846_config.gpio_pendown = gpio_pendown;
 	}
 
+	if (!board_pdata || (board_pdata && !board_pdata->get_pendown_state))
+		gpio_free(gpio_pendown);
+
 	spi_register_board_info(&ads7846_spi_board_info, 1);
 }
 #else
