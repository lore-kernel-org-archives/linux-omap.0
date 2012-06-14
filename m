From: Zumeng Chen <zumeng.chen@windriver.com>
Subject: Re: [PATCH V2 5/5] Input: ads7846: set proper debounce time in driver
 level
Date: Thu, 14 Jun 2012 14:59:28 +0800
Message-ID: <4FD98BD0.7090901@windriver.com>
References: <zumeng.chen@gmail.com> <1339551850-20827-1-git-send-email-zumeng.chen@gmail.com> <1339551850-20827-6-git-send-email-zumeng.chen@gmail.com> <79CD15C6BA57404B839C016229A409A83EA4F07F@DBDE01.ent.ti.com> <4FD96CBF.5040106@windriver.com> <79CD15C6BA57404B839C016229A409A83EA4FC98@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------020107020903070406040603"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:48061 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849Ab2FNHAc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 03:00:32 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA4FC98@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "mike@compulab.co.il" <mike@compulab.co.il>
Cc: Zumeng Chen <zumeng.chen@gmail.com>, "tony@atomide.com" <tony@atomide.com>, "Hunter, Jon" <jon-hunter@ti.com>, "grinberg@compulab.co.il" <grinberg@compulab.co.il>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, "Syed Mohammed, Khasim" <khasim@ti.com>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

--------------020107020903070406040603
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit

于 2012年06月14日 14:31, Hiremath, Vaibhav 写道:
> On Thu, Jun 14, 2012 at 10:16:55, Zumeng Chen wrote:
>> 于 2012年06月13日 20:18, Hiremath, Vaibhav 写道:
>>> On Wed, Jun 13, 2012 at 07:14:10, Zumeng Chen wrote:
>>>> From: Zumeng Chen<zumeng.chen@windriver.com>
>>>>
>>>> If we don't set proper debouce time for ads7846, then there are
>>>> flooded interrupt counters of ads7846 responding to one time
>>>> touch on screen, so the driver couldn't work well.
>>>>
>>>> And since most OMAP3 series boards pass NULL pointer of board_pdata
>>>> to omap_ads7846_init, so it's more proper to set it in driver level
>>>> after having gpio_request done.
>>>>
>>>> This patch has been validated on 3530evm.
>>>>
>>>> Signed-off-by: Zumeng Chen<zumeng.chen@windriver.com>
>>>> Signed-off-by: Syed Mohammed Khasim<khasim@ti.com>
>>>> ---
>>>>   drivers/input/touchscreen/ads7846.c |    4 ++++
>>>>   1 files changed, 4 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
>>>> index f02028e..459ff29 100644
>>>> --- a/drivers/input/touchscreen/ads7846.c
>>>> +++ b/drivers/input/touchscreen/ads7846.c
>>>> @@ -980,6 +980,10 @@ static int __devinit ads7846_setup_pendown(struct spi_device *spi, struct ads784
>>>>   		}
>>>>
>>>>   		ts->gpio_pendown = pdata->gpio_pendown;
>>>> +#ifdef CONFIG_ARCH_OMAP3
>>>> +		/* 310 means about 10 microsecond for omap3 */
>>>> +		gpio_set_debounce(pdata->gpio_pendown, 310);
>>>> +#endif
>>>>
>>> Zumeng,
>>>
>>> With my sign-off you are changing the original code, that too
>>> without my sign-off and ack.
>>> I wouldn't mind you to submit patches from my tree, but the expectation is
>>> if you are changing the original code, it should be under your sign-off.
>> Thanks, good to learn. I'll remove in next time.
>>> Coming to the patch, #ifdef in driver is not recommended, and this 10msec
>>> delay is specific to OMAP GPIO and driver should not be aware of this,
>>> that's where you will find the original patch handling it in board file.
>> According to the git blame of the board-omap3evm.c I think
>> 96974a24 did a good thing to all the related codes for omap3
>> boards. So I think we can call board and driver as BSP level :-)
>>
>> If #ifdef in driver can save many codes, I guess it's deserved.
>>
> No, not really.
>
> In the same commit, the debounce time is already handled as an argument to 
> the function omap_ads7846_init(), and that’s the way it should be.
That means you'd like to implement the same get_pendown_state for every
omap3 board? Currently, board_pdata is NULL.

And actually, the reason why I agree 96974a24 is that get_pendown_state
for all omap3 boards is the common chip level gpio operations. so I think
we should set debounce for them in one common point.

But since Igor and you don't like them, I have created and tested the
attachment
patch, and I'd like Mike to check if convenience too
But obviously there are more codes than mine before :-)

Regards,
Zumeng
> So no need for #ifdefs in driver...
>
> Thanks,
> Vaibhav


--------------020107020903070406040603
Content-Type: text/x-patch; name="ads7846-common.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ads7846-common.diff"

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 56cce1e..887bd35 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -58,7 +58,6 @@
 #include "hsmmc.h"
 #include "common-board-devices.h"
 
-#define OMAP3_EVM_TS_GPIO	175
 #define OMAP3_EVM_EHCI_VBUS	22
 #define OMAP3_EVM_EHCI_SELECT	61
 
diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/mach-omap2/common-board-devices.c
index 719f62e..8cf0140 100644
--- a/arch/arm/mach-omap2/common-board-devices.c
+++ b/arch/arm/mach-omap2/common-board-devices.c
@@ -34,6 +34,11 @@
 static struct omap2_mcspi_device_config ads7846_mcspi_config = {
 	.turbo_mode	= 0,
 };
+	
+static int omap3_get_pendown_state(void)
+{
+	return !gpio_get_value(OMAP3_EVM_TS_GPIO);
+}
 
 static struct ads7846_platform_data ads7846_config = {
 	.x_max			= 0x0fff,
@@ -45,6 +50,7 @@ static struct ads7846_platform_data ads7846_config = {
 	.debounce_rep		= 1,
 	.gpio_pendown		= -EINVAL,
 	.keep_vref_on		= 1,
+	.get_pendown_state	= &omap3_get_pendown_state,
 };
 
 static struct spi_board_info ads7846_spi_board_info __initdata = {
@@ -63,17 +69,14 @@ void __init omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
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
+	gpio_export(gpio_pendown, 0);
+	if (gpio_debounce)
+		gpio_set_debounce(gpio_pendown, gpio_debounce);
 
 	spi_bi->bus_num	= bus_num;
 	spi_bi->irq	= gpio_to_irq(gpio_pendown);
diff --git a/arch/arm/mach-omap2/common-board-devices.h b/arch/arm/mach-omap2/common-board-devices.h
index a0b4a428..4c4ef6a 100644
--- a/arch/arm/mach-omap2/common-board-devices.h
+++ b/arch/arm/mach-omap2/common-board-devices.h
@@ -4,6 +4,7 @@
 #include "twl-common.h"
 
 #define NAND_BLOCK_SIZE	SZ_128K
+#define OMAP3_EVM_TS_GPIO	175
 
 struct mtd_partition;
 struct ads7846_platform_data;

--------------020107020903070406040603--
