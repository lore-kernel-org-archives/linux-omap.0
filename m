From: Peter Barada <peter.barada@gmail.com>
Subject: Re: Regulator question regarding I2C devices
Date: Sat, 29 Jan 2011 14:58:08 -0500
Message-ID: <4D447150.1000406@gmail.com>
References: <4D434201.6060108@logicpd.com> <20110129173446.GG32186@darwin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:55534 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634Ab1A2T6G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 29 Jan 2011 14:58:06 -0500
Received: by qwa26 with SMTP id 26so4344942qwa.19
        for <linux-omap@vger.kernel.org>; Sat, 29 Jan 2011 11:58:05 -0800 (PST)
In-Reply-To: <20110129173446.GG32186@darwin>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthias Kaehlcke <matthias@kaehlcke.net>
Cc: Peter Barada <peter.barada@logicpd.com>, linux-omap@vger.kernel.org

On 01/29/2011 12:34 PM, Matthias Kaehlcke wrote:
> Hi Peter,
>
> El Fri, Jan 28, 2011 at 05:24:01PM -0500 Peter Barada ha dit:
>
>> I have a tsc2004 touch controller on I2C3 that is powered by vaux1,
>> and since its probed I have to turn the power on before it can be
>> probed.
>>
>> I've created:
>>
>> static struct regulator_consumer_supply dm3730logic_vaux1_supply = {
>>     .supply            = "vaux1",
>> };
>>
>> /* VAUX1 for touch chip */
>> static struct regulator_init_data dm3730logic_vaux1 = {
>>     .constraints = {
>>         .min_uV        = 3000000,
>>         .max_uV        = 3000000,
>>         .apply_uV    = true,
>>         .valid_modes_mask    = REGULATOR_MODE_NORMAL
>>                     | REGULATOR_MODE_STANDBY,
>>         .valid_ops_mask        = REGULATOR_CHANGE_MODE
>>                     | REGULATOR_CHANGE_STATUS,
>>     },
>>     .num_consumer_supplies    = 1,
>>     .consumer_supplies    = &dm3730logic_vaux1_supply,
>> };
>>
>> and listed it in the twldata initializer
>>     .vaux1        = &dm3730logic_vaux1,
>>
>> But it never gets enabled...  How can I tell the kernel to turn the regulator on?
>>
>> If I try to call regulator_get() right before the call to omap_register_i2c_bus for I2C3, regulator_get returns a NULL due to regulator_map_list being empty.  If I look in sys/class/regulator I see VAUX1 listed (as regulator.4), but there are no users.
>>
>> Any suggestions on how I can turn on vaux1 so the tsc2004 touch
>> controller is visible to by the I2C system?
> I guess the problem is that the regulators aren't initialized when you
> call regulator_get() before the i2c bus registration
>
> I think the right thing is to do the regulator handling inside the
> tsc2004 driver
>
> The ADS7846 touchscreen driver (drivers/input/touchscreen/ads7846.c)
> in combination with the TimLL Devkit8000 board
> (arch/arm/mach-omap2/board-devkit8000.c) can serve you as a reference
Thanks; figured it out late last night and have it working.  I added two more hooks to the tsc2004.c driver, "pre_init_platform_hw" and "post_exit_platform_hw" that each take the pdata pointer as well as the regulator.  Then in my board file I get/enable the regulator in the pre_init hook, and disable/put the regulator in the post_exit hook....
> Best regards
>


-- 
Peter Barada
peter.barada@gmail.com

