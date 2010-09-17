From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] usb: omap: ohci: Missing driver unregister in module
 exit
Date: Fri, 17 Sep 2010 09:43:16 +0300
Message-ID: <20100917064316.GF23325@legolas.emea.dhcp.ti.com>
References: <1284419401-32101-1-git-send-email-keshava_mgowda@ti.com>
 <0680EC522D0CC943BC586913CF3768C003C210F6A6@dbde02.ent.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47650 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752199Ab0IQGni (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Sep 2010 02:43:38 -0400
Content-Disposition: inline
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003C210F6A6@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Cc: "greg@kroah.com" <greg@kroah.com>, "linux-usb-owner@vger.kernel.org" <linux-usb-owner@vger.kernel.org>, "Gadiyar, Anand" <gadiyar@ti.com>, "Kamat, Nishant" <nskamat@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Sep 16, 2010 at 06:39:20AM -0500, Munegowda, Keshava wrote:
>> -----Original Message-----
>> From: Munegowda, Keshava
>> Sent: Tuesday, September 14, 2010 4:40 AM
>> To: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org
>> Cc: Gadiyar, Anand; Kamat, Nishant; Munegowda, Keshava
>> Subject: [PATCH] usb: omap: ohci: Missing driver unregister in module exit
>>
>> The un-registration of OHCI driver was not done in
>> the ohci_hcd_mod_exit function. This was affecting rmmod command not
>> to work for OMAP3 platforms.
>> The platform driver un-registration for OMAP3 platforms is perfomed
>> while removing the OHCI module from kernel.
>>
>> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
>> ---
>>  drivers/usb/host/ohci-hcd.c |    3 +++
>>  1 file changed, 3 insertions(+)
>>
>> Index: linux-2.6/drivers/usb/host/ohci-hcd.c
>> ===================================================================
>> --- linux-2.6.orig/drivers/usb/host/ohci-hcd.c
>> +++ linux-2.6/drivers/usb/host/ohci-hcd.c
>> @@ -1270,6 +1270,9 @@ static void __exit ohci_hcd_mod_exit(voi
>>  #ifdef PLATFORM_DRIVER
>>  	platform_driver_unregister(&PLATFORM_DRIVER);
>>  #endif
>> +#ifdef OMAP3_PLATFORM_DRIVER
>> +	platform_driver_unregister(&OMAP3_PLATFORM_DRIVER);
>> +#endif
>>  #ifdef PS3_SYSTEM_BUS_DRIVER
>>  	ps3_ohci_driver_unregister(&PS3_SYSTEM_BUS_DRIVER);
>>  #endif
>
>Hi Greg,
>     Do you any comments on this patch?

my missing S-O-B, maybe. Here it goes:

Signed-of-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
