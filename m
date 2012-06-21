From: Zumeng Chen <zumeng.chen@windriver.com>
Subject: Re: [PATCH 4/5] ARM: OMAP3EVM: cosmetic fixes for parent clk set
Date: Thu, 21 Jun 2012 09:05:10 +0800
Message-ID: <4FE27346.30100@windriver.com>
References: <1340183693-3195-1-git-send-email-zumeng.chen@windriver.com> <1340183693-3195-5-git-send-email-zumeng.chen@windriver.com> <4FE1F39C.50104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:42731 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab2FUBGL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jun 2012 21:06:11 -0400
In-Reply-To: <4FE1F39C.50104@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: mike@compulab.co.il, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, khilman@ti.com, hvaibhav@ti.com, ajay.gupta@ti.com

=E4=BA=8E 2012=E5=B9=B406=E6=9C=8821=E6=97=A5 00:00, Jon Hunter =E5=86=99=
=E9=81=93:
> On 06/20/2012 04:14 AM, Zumeng Chen wrote:
>> Since it's no more sense to set parent for dummy clock,
>> so we can just ignore it to mute failed message.
>>
>> Signed-off-by: Jon Hunter<jon-hunter@ti.com>
>> Signed-off-by: Zumeng Chen<zumeng.chen@gmail.com>
>> ---
>>   arch/arm/plat-omap/clock.c  |    4 ++++
>>   drivers/mfd/omap-usb-host.c |    2 +-
>>   2 files changed, 5 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
>> index 62ec5c4..c7e26e4 100644
>> --- a/arch/arm/plat-omap/clock.c
>> +++ b/arch/arm/plat-omap/clock.c
>> @@ -149,6 +149,10 @@ int clk_set_parent(struct clk *clk, struct clk =
*parent)
>>   	if (!arch_clock || !arch_clock->clk_set_parent)
>>   		return ret;
>>
>> +	/* If the clock is a dummy clock just return */
>> +	if (clk =3D=3D&dummy_ck)
>> +		return 0;
>> +
>>   	spin_lock_irqsave(&clockfw_lock, flags);
>>   	if (clk->usecount =3D=3D 0) {
>>   		ret =3D arch_clock->clk_set_parent(clk, parent);
>> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host=
=2Ec
>> index 7e96bb2..c9d27c4 100644
>> --- a/drivers/mfd/omap-usb-host.c
>> +++ b/drivers/mfd/omap-usb-host.c
>> @@ -699,7 +699,7 @@ static int __devinit usbhs_omap_probe(struct pla=
tform_device *pdev)
>>   	}
>>
>>   	if (is_ehci_phy_mode(pdata->port_mode[0])) {
>> -		/* for OMAP3 , the clk set paretn fails */
>> +		/* for OMAP3 , the clk set parent fails */
> Can't we remove this comment now with the above fix? It is no longer
> relevant, right?
Yes, NP.

Regards,
Zumeng
>
> Cheers
> Jon
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
