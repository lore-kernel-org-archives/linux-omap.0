From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH 1/3] Adding-support-framework for PR785 board.
Date: Fri, 28 Nov 2008 11:11:29 +0100
Message-ID: <6D79EFBB-11E3-4956-893B-2F7815736BB4@student.utwente.nl>
References: <1227850078-16091-1-git-send-email-mani.pillai@ti.com> <20081128065130.GL23308@gandalf.research.nokia.com> <19F8576C6E063C45BE387C64729E739403E904EBE3@dbde02.ent.ti.com> <20081128094628.GO23308@gandalf.research.nokia.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-1-451786714"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx3.utsp.utwente.nl ([130.89.2.14]:27726 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752634AbYK1KLy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Nov 2008 05:11:54 -0500
In-Reply-To: <20081128094628.GO23308@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: "ext Pillai, Manikandan" <mani.pillai@ti.com>, linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-1-451786714
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 28 nov 2008, om 10:46 heeft Felipe Balbi het volgende geschreven:

> On Fri, Nov 28, 2008 at 01:52:27PM +0530, ext Pillai, Manikandan  
> wrote:
>
>> No way. Create separated versions of the omap3evm_i2c_boardinfo[] for
>> the "conflicting" devices and register one or the other version  
>> based on
>> if (machine_is_XXX()) or something similar.
>>
>> You can register as many i2c_board_infos as you want per bus.
>>
>>>>>>>> Mani: Not clear on what the comment is. Do I need to remove the
>> #if defined(CONFIG_PR785).
>
> Yes... you should for example:
>
> static struct i2c_board_info omap3evm_i2c_board_info[] __initdata = {
> ... (all devices but tps and twl) ...
> };
>
> static struct i2c_board_info pr785_i2c_board_info[] __initdata = {
> 	{
> 		I2C_BOARD_INFO("tps62352_core_pwr", 0x4A),
> 		.flags = I2C_CLIENT_WAKE,
> 	}, {
> 		I2C_BOARD_INFO("tps62353_mpu_pwr", 0x48),
> 		.flags = I2C_CLIENT_WAKE,
> 	},
> };
>
> static struct i2c_board_info twl4030_i2c_board_info[] __initdata = {
> 	{
> 		I2C_BOARD_INFO("twl4030", 0x48),
> 	},
> };
>
> Then on init:
>
> ...
>
> omap_register_i2c_bus(1, omap3_evm_i2c_board_info,
> 		ARRAY_SIZE(omap3evm_i2c_board_info);
>
> if (machine_is_pr785())
> 	i2c_register_board_info(1, pr785_i2c_board_info,
> 		ARRAY_SIZE(pr785_i2c_board_info));

That's looks like unreachable code to me, since the pr785 is a  
daughterboard of the omap3evm machine.

regards,

Koen



>
>
> if (machine_is_xxxx())
> 	i2c_register_board_info(1, twl4030_i2c_board_info,
> 		ARRAY_SIZE(twl4030_i2c_board_info));
>
>
>>> diff --git a/drivers/video/omap/lcd_omap3evm.c b/drivers/video/ 
>>> omap/lcd_omap3evm.c
>>> index 90aa015..ac51dd0 100644
>>> --- a/drivers/video/omap/lcd_omap3evm.c
>>> +++ b/drivers/video/omap/lcd_omap3evm.c
>>> @@ -66,9 +66,11 @@ static int omap3evm_panel_init(struct lcd_panel  
>>> *panel,
>>> 	gpio_direction_output(LCD_PANEL_LR, 1);
>>> 	gpio_direction_output(LCD_PANEL_UD, 1);
>>>
>>> +#if !defined(CONFIG_PR785)
>>> 	twl4030_i2c_write_u8(TWL4030_MODULE_LED, 0x11, TWL_LED_LEDEN);
>>> 	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x01, TWL_PWMA_PWMAON);
>>> 	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x02, TWL_PWMA_PWMAOFF);
>>> +#endif
>>> 	bklight_level = 100;
>>>
>>> 	return 0;
>>> @@ -97,12 +99,14 @@ static unsigned long  
>>> omap3evm_panel_get_caps(struct lcd_panel *panel)
>>> static int omap3evm_bklight_setlevel(struct lcd_panel *panel,
>>> 						unsigned int level)
>>> {
>>> +#if !defined(CONFIG_PR785)
>>> 	u8 c;
>>> 	if ((level >= 0) && (level <= 100)) {
>>> 		c = (125 * (100 - level)) / 100 + 2;
>>> 		twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, c, TWL_PWMA_PWMAOFF);
>>> 		bklight_level = level;
>>> 	}
>>> +#endif
>>
>> No!!
>>
>> NAK to all ifdefs. It'll break multiomap support.
>>>>>>>> Mani: Will use a positive #if defined.
>
> also not.. you need to use platform_data to tell you how to set stuff
> up for different boards, don't use pre-processor conditionals.
>
> -- 
> balbi
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--Apple-Mail-1-451786714
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJL8PTMkyGM64RGpERAor2AKCaaRHi+hYMYXivSShEVoVqaF8JoQCeJEz/
HSnVkip4r/jRHtxuPXgAw+k=
=tUmt
-----END PGP SIGNATURE-----

--Apple-Mail-1-451786714--
