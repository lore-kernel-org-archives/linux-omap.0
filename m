From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/3] Adding-support-framework for PR785 board.
Date: Fri, 28 Nov 2008 12:50:59 +0200
Message-ID: <20081128105058.GB6525@frodo>
References: <1227850078-16091-1-git-send-email-mani.pillai@ti.com> <20081128065130.GL23308@gandalf.research.nokia.com> <19F8576C6E063C45BE387C64729E739403E904EBE3@dbde02.ent.ti.com> <20081128094628.GO23308@gandalf.research.nokia.com> <6D79EFBB-11E3-4956-893B-2F7815736BB4@student.utwente.nl>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:44148 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277AbYK1Kvd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2008 05:51:33 -0500
Content-Disposition: inline
In-Reply-To: <6D79EFBB-11E3-4956-893B-2F7815736BB4@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: felipe.balbi@nokia.com, "ext Pillai, Manikandan" <mani.pillai@ti.com>, linux-omap@vger.kernel.org

On Fri, Nov 28, 2008 at 11:11:29AM +0100, Koen Kooi wrote:
>> Yes... you should for example:
>>
>> static struct i2c_board_info omap3evm_i2c_board_info[] __initdata = {
>> ... (all devices but tps and twl) ...
>> };
>>
>> static struct i2c_board_info pr785_i2c_board_info[] __initdata = {
>> 	{
>> 		I2C_BOARD_INFO("tps62352_core_pwr", 0x4A),
>> 		.flags = I2C_CLIENT_WAKE,
>> 	}, {
>> 		I2C_BOARD_INFO("tps62353_mpu_pwr", 0x48),
>> 		.flags = I2C_CLIENT_WAKE,
>> 	},
>> };
>>
>> static struct i2c_board_info twl4030_i2c_board_info[] __initdata = {
>> 	{
>> 		I2C_BOARD_INFO("twl4030", 0x48),
>> 	},
>> };
>>
>> Then on init:
>>
>> ...
>>
>> omap_register_i2c_bus(1, omap3_evm_i2c_board_info,
>> 		ARRAY_SIZE(omap3evm_i2c_board_info);
>>
>> if (machine_is_pr785())
>> 	i2c_register_board_info(1, pr785_i2c_board_info,
>> 		ARRAY_SIZE(pr785_i2c_board_info));
>
> That's looks like unreachable code to me, since the pr785 is a  
> daughterboard of the omap3evm machine.

Hmm... that's news to me. But make it runtime check somehow. We can't
accept this kind of ifdefs in the i2c_board_info since it breaks multiomap.

And Tony has been pushing for it for quite a while, so let's not make
his life more difficult.

-- 
balbi
