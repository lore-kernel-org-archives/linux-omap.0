From: Miguel Angel Aguilar Ulloa <miguel.aguilar@ridgerun.com>
Subject: Re: [PATCH 1/3] OMAP3 EVM: Add twl4030 keypad driver support
Date: Wed, 25 Jun 2008 09:13:26 -0600
Message-ID: <48626096.2030704@ridgerun.com>
References: <48601ACD.6040804@ridgerun.com> <c656a4d20806250704y1d1129c3jf7997360da91388f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.navvo.net ([74.208.67.6]:33778 "EHLO mail.navvo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758566AbYFYPJi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Jun 2008 11:09:38 -0400
In-Reply-To: <c656a4d20806250704y1d1129c3jf7997360da91388f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arun c <arun.edarath@gmail.com>
Cc: linux-omap@vger.kernel.org, Diego Dompe <diego.dompe@ridgerun.com>, Todd Fischer <todd.fischer@ridgerun.com>

The OMAP3 EVM has 15 keys arranged in a matrix from SW4 to SW18, but it also has 
a user key (power on/off) in SW3, this key is included in the keypad mapping. 
This is how mapping is done in an 4x4 array.

arun c wrote:
> On Tue, Jun 24, 2008 at 3:21 AM, Miguel Angel Aguilar Ulloa
> <miguel.aguilar@ridgerun.com> wrote:
>> Add twl4030 keypad driver support to OMAP3 EVM
>>
>> Signed-off-by: Miguel Angel Aguilar <miguel.aguilar@ridgerun.com>
>>
>> --- a/arch/arm/mach-omap2/board-omap3evm.c      2008-06-23
>> 15:07:13.000000000 -0600
>> +++ b/arch/arm/mach-omap2/board-omap3evm.c      2008-06-23
>> 14:32:29.000000000 -0600
>> @@ -19,6 +19,7 @@
>> #include <linux/err.h>
>> #include <linux/clk.h>
>> #include <linux/io.h>
>> +#include <linux/input.h>
>> #include <linux/spi/spi.h>
>> #include <linux/spi/ads7846.h>
>>
>> @@ -28,6 +29,7 @@
>> #include <asm/mach/map.h>
>>
>> #include <asm/arch/gpio.h>
>> +#include <asm/arch/keypad.h>
>> #include <asm/arch/board.h>
>> #include <asm/arch/hsmmc.h>
>> #include <asm/arch/usb-musb.h>
>> @@ -149,6 +151,56 @@ struct spi_board_info omap3evm_spi_board
>>        },
>> };
>>
>> +static int omap3evm_keymap[] = {
>> +       KEY(0, 0, KEY_LEFT),
>> +       KEY(0, 1, KEY_RIGHT),
>> +       KEY(0, 2, KEY_A),
>> +       KEY(0, 3, KEY_B),
>> +       KEY(0, 4, KEY_C),
>> +       KEY(1, 0, KEY_DOWN),
>> +       KEY(1, 1, KEY_UP),
>> +       KEY(1, 2, KEY_E),
>> +       KEY(1, 3, KEY_F),
>> +       KEY(1, 4, KEY_G),
>> +       KEY(2, 0, KEY_ENTER),
>> +       KEY(2, 1, KEY_I),
>> +       KEY(2, 2, KEY_J),
>> +       KEY(2, 3, KEY_K),
>> +       KEY(2, 4, KEY_3),
>> +       KEY(3, 0, KEY_M),
>> +       KEY(3, 1, KEY_N),
>> +       KEY(3, 2, KEY_O),
>> +       KEY(3, 3, KEY_P),
>> +       KEY(3, 4, KEY_Q),
>> +       KEY(4, 0, KEY_R),
>> +       KEY(4, 1, KEY_4),
>> +       KEY(4, 2, KEY_T),
>> +       KEY(4, 3, KEY_U),
>> +       KEY(4, 4, KEY_D),
>> +       KEY(5, 0, KEY_V),
>> +       KEY(5, 1, KEY_W),
>> +       KEY(5, 2, KEY_L),
>> +       KEY(5, 3, KEY_S),
>> +       KEY(5, 4, KEY_H),
>> +       0
>> +};
>> +
> 
> Omap3evm has only 15 keys right?(Some body correct me if I am wrong).
> Then how the
> mapping and dividing into rows and columns is done?
> 
>> +static struct omap_kp_platform_data omap3evm_kp_data = {
>> +       .rows           = 4,
>> +       .cols           = 4,
>> +       .keymap         = omap3evm_keymap,
>> +       .keymapsize     = ARRAY_SIZE(omap3evm_keymap),
>> +       .rep            = 1,
>> +};
>> +
>> +static struct platform_device omap3evm_kp_device = {
>> +       .name           = "omap_twl4030keypad",
>> +       .id             = -1,
>> +       .dev            = {
>> +                               .platform_data = &omap3evm_kp_data,
>> +                       },
>> +};
>> +
>> static void __init omap3_evm_init_irq(void)
>> {
>>        omap2_init_common_hw();
>> @@ -165,6 +217,7 @@ static struct omap_board_config_kernel o
>>
>> static struct platform_device *omap3_evm_devices[] __initdata = {
>>        &omap3_evm_lcd_device,
>> +       &omap3evm_kp_device,
>> #ifdef CONFIG_RTC_DRV_TWL4030
>>        &omap3_evm_twl4030rtc_device,
>> #endif
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>


-- 
Miguel Angel Aguilar Ulloa
Embedded Software Engineer
RidgeRun Embedded Solutions
miguel.aguilar@ridgerun.com
Office: +(506) 2225-9596
