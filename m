From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v2 2/2] spi: Force CS to be in inactive state after off-mode
 transition
Date: Thu, 11 Nov 2010 12:57:33 +0100
Message-ID: <4CDBDA2D.7060903@free-electrons.com>
References: <4CDA74DB.1060102@free-electrons.com> <505AAE016A4D4EB5AC8F2EA48803AFD7@wipblrx0099946>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:49691 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755557Ab0KKL5n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Nov 2010 06:57:43 -0500
In-Reply-To: <505AAE016A4D4EB5AC8F2EA48803AFD7@wipblrx0099946>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>, spi-devel-general <spi-devel-general@lists.sourceforge.net>, linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>

On 11/11/2010 10:34 AM, Hemanth V wrote:
> ----- Original Message ----- From: "Gregory CLEMENT"
> <gregory.clement@free-electrons.com>
> To: "spi-devel-general" <spi-devel-general@lists.sourceforge.net>;
> "linux-omap" <linux-omap@vger.kernel.org>
> Cc: "David Brownell" <dbrownell@users.sourceforge.net>; "Grant Likely"
> <grant.likely@secretlab.ca>; "Kevin Hilman" <khilman@deeprootsystems.com>
> Sent: Wednesday, November 10, 2010 4:02 PM
> Subject: [PATCH v2 2/2] spi: Force CS to be in inactive state after
> off-mode transition
>
>
>> When SPI wake up from OFF mode, CS is in the wrong state: force it to
>> the inactive state.
>>
>> During the system life, I monitored the CS behavior using a
>> oscilloscope. I also activated debug in omap2_mcspi, so I saw when
>> driver disable the clocks and restore context when device is not used.
>> Each time the CS was in the correct state.
>> It was only when system was put suspend to ram with off-mode activated
>> that on resume the CS was in wrong state( ie activated).
>>
>
> Just to confirm the understanding. Are saying CHCONF[6] EPOL bit
> setting and CS state did not match and is actually a hardware bug. If so
> could u let us know which platform u are testing this on.
>

Well I am not sure it is related to CHCONF[6] EPOL bit. During exchange 
on SPI, CS is in the good state. But when system wake up from an 
off-mode, CS is in its active state (high state for our configuration). 
I thought it was more a problem with CHCONF[20] FORCE bit, indeed this 
bit is at 0, so CS should be in low state. It is only when we first set 
this bit to 1 and then to 0, that CS go to low state.
It sounds like an hardware bug on this bit, or let's say an undocumented 
feature ;)
CS stay in high state until the next transaction on the SPI bus, indeed 
as the driver use CHCONF[20] FORCE bit during exchange, it will do the 
transition on this bit. That's why nobody noticed it until now, because 
from the software point of view it works.

I didn't test it with CHCONF[6] EPOL bit set to 1.

Our silicon revision was OMAP3530-GP ES3.1.

> Thanks
> Hemanth
>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>> drivers/spi/omap2_mcspi.c | 10 ++++++++++
>> 1 files changed, 10 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
>> index 2a651e6..938f14c 100644
>> --- a/drivers/spi/omap2_mcspi.c
>> +++ b/drivers/spi/omap2_mcspi.c
>> @@ -1139,6 +1139,15 @@ static u8 __initdata spi4_txdma_id[] = {
>> };
>> #endif
>> +/* When SPI wake up, CS is in wrong state: force it to unactive state*/
>> +static void omap2_mcspi_resume(struct spi_device *spi)
>> +{
>> + omap2_mcspi_enable_clocks( spi_master_get_devdata(spi->master));
>> + /* We need to togle CS state for OMAP take this chang in account*/
>> + omap2_mcspi_force_cs(spi, 1);
>> + omap2_mcspi_force_cs(spi, 0);
>> + omap2_mcspi_disable_clocks( spi_master_get_devdata(spi->master));
>> +}
>> static int __init omap2_mcspi_probe(struct platform_device *pdev)
>> {
>> struct spi_master *master;
>> @@ -1194,6 +1203,7 @@ static int __init omap2_mcspi_probe(struct
>> platform_device *pdev)
>> master->transfer = omap2_mcspi_transfer;
>> master->cleanup = omap2_mcspi_cleanup;
>> master->num_chipselect = num_chipselect;
>> + master->resume = omap2_mcspi_resume;
>> dev_set_drvdata(&pdev->dev, master);
>> -- 1.7.0.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
