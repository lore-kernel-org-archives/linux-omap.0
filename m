From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: [PATCH 03/11] AM3517: rename the i2c boardinfo to make it more
 readable
Date: Wed, 14 Apr 2010 10:44:52 +0800
Message-ID: <4BC52C24.8080707@windriver.com>
References: <1271151118-12999-1-git-send-email-stanley.miao@windriver.com> <1271151118-12999-4-git-send-email-stanley.miao@windriver.com> <19F8576C6E063C45BE387C64729E7394044E054200@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:52750 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754449Ab0DNCgT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Apr 2010 22:36:19 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044E054200@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

Hiremath, Vaibhav wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Stanley.Miao
>> Sent: Tuesday, April 13, 2010 3:02 PM
>> To: linux-omap@vger.kernel.org
>> Cc: tony@atomide.com
>> Subject: [PATCH 03/11] AM3517: rename the i2c boardinfo to make it more
>> readable
>>
>> There are three i3c buses on am3517, 
>>     
> [Hiremath, Vaibhav] Please correct the typo here.
>   

I will correct it in V2.
Thanks.

>   
>> now rename these three boardinfo
>> structure name to am3517evm_i2c1_boardinfo, am3517evm_i2c2_boardinfo,
>> and am3517evm_i2c3_boardinfo, to make it more readable.
>>
>> <snip>
>>  }
>> @@ -425,8 +425,8 @@ static void __init am3517_evm_init(void)
>>  	/* RTC - S35390A */
>>  	am3517_evm_rtc_init();
>>
>> -	i2c_register_board_info(1, am3517evm_i2c_boardinfo,
>> -				ARRAY_SIZE(am3517evm_i2c_boardinfo));
>> +	i2c_register_board_info(1, am3517evm_i2c1_boardinfo,
>> +				ARRAY_SIZE(am3517evm_i2c1_boardinfo));
>>  }
>>     
> [Hiremath, Vaibhav] personally I like the idea of specifying explicitly the I2C instance here which you did, I have seen other board files using slave device name while defining the I2C board info. I am not sure about whether we have any standard thing to follow here. 
>
> Let's take opinion from other folks here; if they are ok with this approach then I think we can merge this patch.
>   

There are many slave devices on each i2c bus.
I2C1: S35390, TPS65023, TSC2004, four INA219.
I2C2: TCA6416PW, two TLV320AIC23
I2C3: two TCA6416PW, TLV320AIC23, TVP5146.

So we can't name the i2c board files with the slave device names

Stanley.

> Thanks,
> Vaibhav
>
>   
>>  static void __init am3517_evm_map_io(void)
>> --
>> 1.5.4.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>     
>
>   

