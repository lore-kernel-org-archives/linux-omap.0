From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH 1/3] Adding-support-framework for PR785 board.
Date: Fri, 28 Nov 2008 12:02:14 +0100
Message-ID: <FD15C8F2-5F3C-49EE-B0D5-16E58E016AB4@student.utwente.nl>
References: <1227850078-16091-1-git-send-email-mani.pillai@ti.com> <20081128065130.GL23308@gandalf.research.nokia.com> <19F8576C6E063C45BE387C64729E739403E904EBE3@dbde02.ent.ti.com> <20081128094628.GO23308@gandalf.research.nokia.com> <6D79EFBB-11E3-4956-893B-2F7815736BB4@student.utwente.nl> <20081128105058.GB6525@frodo>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-1-454831594"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.utsp.utwente.nl ([130.89.2.12]:59165 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751547AbYK1LCx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Nov 2008 06:02:53 -0500
In-Reply-To: <20081128105058.GB6525@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: "ext Pillai, Manikandan" <mani.pillai@ti.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-1-454831594
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 28 nov 2008, om 11:50 heeft Felipe Balbi het volgende geschreven:

> On Fri, Nov 28, 2008 at 11:11:29AM +0100, Koen Kooi wrote:
>>> Yes... you should for example:
>>>
>>> static struct i2c_board_info omap3evm_i2c_board_info[] __initdata  
>>> = {
>>> ... (all devices but tps and twl) ...
>>> };
>>>
>>> static struct i2c_board_info pr785_i2c_board_info[] __initdata = {
>>> 	{
>>> 		I2C_BOARD_INFO("tps62352_core_pwr", 0x4A),
>>> 		.flags = I2C_CLIENT_WAKE,
>>> 	}, {
>>> 		I2C_BOARD_INFO("tps62353_mpu_pwr", 0x48),
>>> 		.flags = I2C_CLIENT_WAKE,
>>> 	},
>>> };
>>>
>>> static struct i2c_board_info twl4030_i2c_board_info[] __initdata = {
>>> 	{
>>> 		I2C_BOARD_INFO("twl4030", 0x48),
>>> 	},
>>> };
>>>
>>> Then on init:
>>>
>>> ...
>>>
>>> omap_register_i2c_bus(1, omap3_evm_i2c_board_info,
>>> 		ARRAY_SIZE(omap3evm_i2c_board_info);
>>>
>>> if (machine_is_pr785())
>>> 	i2c_register_board_info(1, pr785_i2c_board_info,
>>> 		ARRAY_SIZE(pr785_i2c_board_info));
>>
>> That's looks like unreachable code to me, since the pr785 is a
>> daughterboard of the omap3evm machine.
>
> Hmm... that's news to me. But make it runtime check somehow. We can't
> accept this kind of ifdefs in the i2c_board_info since it breaks  
> multiomap.
>
> And Tony has been pushing for it for quite a while, so let's not make
> his life more difficult.

I'm not advocating ifdefs, quite the reverse. I was just pointing out  
that the pr785 is a daughterboard for the evm :) My omap3evm board has  
the twl4030 daughterboard, so I sadly can't test patches for the pr785.

regards,

Koen


>
>
> -- 
> balbi
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--Apple-Mail-1-454831594
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJL8+4MkyGM64RGpERArv8AJ9EyfYGhDF3eSUEQnSzGp6eAA5seQCcCx/0
Vp5dcAfctIFhoKaIDb9BnVo=
=xGYB
-----END PGP SIGNATURE-----

--Apple-Mail-1-454831594--
