From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 10/11] arm/dts: OMAP4: Add a main ocp entry bound to l3-noc
 driver
Date: Mon, 26 Sep 2011 14:13:04 +0200
Message-ID: <4E806C50.80300@ti.com>
References: <1316809399-19579-1-git-send-email-b-cousson@ti.com> <1316809399-19579-11-git-send-email-b-cousson@ti.com> <20110923225825.GB6324@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57041 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752571Ab1IZMNT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Sep 2011 08:13:19 -0400
In-Reply-To: <20110923225825.GB6324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "paul@pwsan.com" <paul@pwsan.com>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

On 9/24/2011 12:58 AM, Tony Lindgren wrote:
> * Benoit Cousson<b-cousson@ti.com>  [110923 12:50]:
>> Used the main OCP node to add bindings with the l3_noc driver.
>> Remove l3_noc static device creation if DT is populated.
>> --- a/arch/arm/mach-omap2/devices.c
>> +++ b/arch/arm/mach-omap2/devices.c
>> @@ -16,6 +16,7 @@
>>   #include<linux/clk.h>
>>   #include<linux/err.h>
>>   #include<linux/slab.h>
>> +#include<linux/of.h>
>>
>>   #include<mach/hardware.h>
>>   #include<mach/irqs.h>
>> @@ -77,6 +78,10 @@ static int __init omap4_l3_init(void)
>>   	struct platform_device *pdev;
>>   	char oh_name[L3_MODULES_MAX_LEN];
>>
>> +	/* If dtb is there, the devices will be created dynamically */
>> +	if (of_have_populated_dt())
>> +		return -ENODEV;
>> +
>>   	/*
>>   	 * To avoid code running on other OMAPs in
>>   	 * multi-omap builds
>
> How about just remove omap3_l3_init and omap4_l3_init completely
> instead?
>
> There should not be any need for the platform glue code if the
> driver, it's OK for us to require that either DT is passed from
> the bootloader or as appended DT as soon as the appended DT patches
> are merged.

Yeah, but we should still allow the others board files to work in case 
DT is not passed by the bootloader. Otherwise the DT support need to be 
added to every other boards, and in that case that generic board become 
useless. The effort / duplication will be much important if we start 
hacking every boards with some DT code in them.

Whereas that code is simple and will be removed easily when the DT 
migration will be completed.

Regards,
Benoit
