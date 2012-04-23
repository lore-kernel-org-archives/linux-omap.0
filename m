From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCHv8 08/10] I2C: OMAP: fix missing handling of errata I2C_OMAP3_1P153
Date: Mon, 23 Apr 2012 23:05:14 +0530
Message-ID: <4F9592D2.5050100@ti.com>
References: <1334842101-20670-1-git-send-email-shubhrajyoti@ti.com> <1334842101-20670-9-git-send-email-shubhrajyoti@ti.com> <20120423164356.GD27321@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:44114 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751186Ab2DWRfW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Apr 2012 13:35:22 -0400
Received: by pbcuo5 with SMTP id uo5so4108781pbc.32
        for <linux-omap@vger.kernel.org>; Mon, 23 Apr 2012 10:35:21 -0700 (PDT)
In-Reply-To: <20120423164356.GD27321@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, Tasslehoff Kjappfot <tasskjapp@gmail.com>

On Monday 23 April 2012 10:13 PM, Wolfram Sang wrote:
> On Thu, Apr 19, 2012 at 06:58:19PM +0530, Shubhrajyoti D wrote:
>> From: Tasslehoff Kjappfot <tasskjapp@gmail.com>
>>
>> i2c_probe set the dev->errata flag, but omap_i2c_init cleared the flag again.
>> Move the errata handling to i2c_probe.
>>
>> Signed-off-by: Tasslehoff Kjappfot <tasskjapp@gmail.com>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> Subject looks bogus to me. You are handling I207 here.
Actually probe set ip153 then i2c init cleared so moved all the errata
handling
in one place so that such errors are prevented.

WIll update the changelogs and resend
>
>> ---
>>  drivers/i2c/busses/i2c-omap.c |   10 +++++-----
>>  1 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
>> index d555dcd..9323201 100644
>> --- a/drivers/i2c/busses/i2c-omap.c
>> +++ b/drivers/i2c/busses/i2c-omap.c
>> @@ -427,11 +427,6 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>>  	/* Take the I2C module out of reset: */
>>  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
>>  
>> -	dev->errata = 0;
>> -
>> -	if (dev->flags & OMAP_I2C_FLAG_APPLY_ERRATA_I207)
>> -		dev->errata |= I2C_OMAP_ERRATA_I207;
>> -
>>  	/* Enable interrupts */
>>  	dev->iestate = (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
>>  			OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
>> @@ -1023,6 +1018,11 @@ omap_i2c_probe(struct platform_device *pdev)
>>  
>>  	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
>>  
>> +	dev->errata = 0;
>> +
>> +	if (dev->flags & OMAP_I2C_FLAG_APPLY_ERRATA_I207)
>> +		dev->errata |= I2C_OMAP_ERRATA_I207;
>> +
>>  	if (dev->rev <= OMAP_I2C_REV_ON_3430)
>>  		dev->errata |= I2C_OMAP3_1P153;
>>  
>> -- 
>> 1.7.5.4
>>

