From: Kevin Hilman <khilman@ti.com>
Subject: Re: [pm-wip/voltdm_nm][PATCH 02/10] OMAP4: PM: VC: allow channels use of default channel i2c_slaveaddr
Date: Thu, 09 Jun 2011 11:17:54 -0700
Message-ID: <8762oezx65.fsf@ti.com>
References: <1307412972-25854-1-git-send-email-nm@ti.com>
	<1307412972-25854-3-git-send-email-nm@ti.com> <87boy6zxo1.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:57574 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752924Ab1FISSA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 14:18:00 -0400
Received: by mail-pv0-f174.google.com with SMTP id 12so1157589pvg.33
        for <linux-omap@vger.kernel.org>; Thu, 09 Jun 2011 11:17:57 -0700 (PDT)
In-Reply-To: <87boy6zxo1.fsf@ti.com> (Kevin Hilman's message of "Thu, 09 Jun
	2011 11:07:10 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Kevin Hilman <khilman@ti.com> writes:

[...]

>> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
>> index f079167..1732258 100644
>> --- a/arch/arm/mach-omap2/voltage.h
>> +++ b/arch/arm/mach-omap2/voltage.h
>> @@ -109,6 +109,15 @@ struct omap_volt_data {
>>  	u8	vp_errgain;
>>  };
>>  
>> +/*
>> + * Introduced in OMAP4, is a concept of a default channel - in OMAP4, this
>> + * channel is MPU, all other domains such as IVA/CORE, could optionally
>> + * link their i2c reg configuration to use MPU channel's configuration if
>> + * required. To do this, mark in the PMIC structure's
>> + * i2c_slave_addr with this macro.
>> + */
>> +#define USE_DEFAULT_CHANNEL_I2C_PARAM  0x8000
>> +
>
> Needs a VC prefix, also use BIT().  
>
> Also, later on in the series you use the same value for things other
> than the I2C slave address.  How about just calling this:
>
> #define OMAP_VC_USE_DEFAULT_CHANNEL    BIT(15)
>

Also, this should be in vc.h, not voltage.h

Kevin
