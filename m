From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] ARM: OMAP: USB: fix warning on EHCI PHY reset path
Date: Wed, 28 Mar 2012 13:13:23 +0200
Message-ID: <4F72F253.5020606@compulab.co.il>
References: <1332857335-27911-1-git-send-email-grinberg@compulab.co.il> <4F72E1F9.3020400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:44783
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758106Ab2C1LNk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Mar 2012 07:13:40 -0400
In-Reply-To: <4F72E1F9.3020400@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti <shubhrajyoti@ti.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Balbi, Felipe" <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Munegowda, Keshava" <keshava_mgowda@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Shubhrajyoti,

On 03/28/12 12:03, Shubhrajyoti wrote:
> On Tuesday 27 March 2012 07:38 PM, Igor Grinberg wrote:
>> When PHY reset pin is connected to a GPIO on external GPIO chip
>> (e.g. I2C), we should not call the gpio_set_value() function, but
>> gpio_set_value_cansleep().
> Why so ? Whats the error otherwise ?

Otherwise, we get a very confusing warnings:
WARNING: at /home/grinberg/git-repo/linux-omap/drivers/gpio/gpiolib.c:1584 __gpio_set_value+0x5c/0x64()
Modules linked in:
[<c001ae6c>] (unwind_backtrace+0x0/0xfc) from [<c003ba10>] (warn_slowpath_common+0x54/0x64)
[<c003ba10>] (warn_slowpath_common+0x54/0x64) from [<c003ba3c>] (warn_slowpath_null+0x1c/0x24)
[<c003ba3c>] (warn_slowpath_null+0x1c/0x24) from [<c0260860>] (__gpio_set_value+0x5c/0x64)
[<c0260860>] (__gpio_set_value+0x5c/0x64) from [<c035fde8>] (ehci_hcd_omap_probe+0x390/0x6c0)
[<c035fde8>] (ehci_hcd_omap_probe+0x390/0x6c0) from [<c02d59dc>] (platform_drv_probe+0x18/0x1c)
[<c02d59dc>] (platform_drv_probe+0x18/0x1c) from [<c02d44d0>] (really_probe+0x64/0x160)
[<c02d44d0>] (really_probe+0x64/0x160) from [<c02d4614>] (driver_probe_device+0x48/0x60)
[<c02d4614>] (driver_probe_device+0x48/0x60) from [<c02d46c0>] (__driver_attach+0x94/0x98)
[<c02d46c0>] (__driver_attach+0x94/0x98) from [<c02d2f4c>] (bus_for_each_dev+0x54/0x80)
[<c02d2f4c>] (bus_for_each_dev+0x54/0x80) from [<c02d3680>] (bus_add_driver+0xa8/0x2a4)
[<c02d3680>] (bus_add_driver+0xa8/0x2a4) from [<c02d4cbc>] (driver_register+0x78/0x184)
[<c02d4cbc>] (driver_register+0x78/0x184) from [<c062e744>] (ehci_hcd_init+0xd8/0x114)
[<c062e744>] (ehci_hcd_init+0xd8/0x114) from [<c0008758>] (do_one_initcall+0x34/0x184)
[<c0008758>] (do_one_initcall+0x34/0x184) from [<c0612248>] (do_basic_setup+0x34/0x40)
[<c0612248>] (do_basic_setup+0x34/0x40) from [<c06122b8>] (kernel_init+0x64/0xec)
[<c06122b8>] (kernel_init+0x64/0xec) from [<c00154cc>] (kernel_thread_exit+0x0/0x8)
---[ end trace 1b75b31a2719ed1e ]---

Because GPIOs can be used from atomic context, there are two versions
of GPIO control functions: gpio_<set|get>_value() and
gpio_<set|get>_value_cansleep().
The warning above means that the atomic context safe function
has been called, but the GPIO chip is not atomic safe - requires an I2C
transaction which may sleep and therefore a warning.

Now, for all on SoC GPIOs, the time for the gpio_set_value_cansleep()
call should not be different then the one for the gpio_set_value().
After my patch, the behavior should not change, but eliminate the warning
for external GPIO chip users.

>> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
>> ---
>> This patch depends on the patch from Keshava [1]:
>> ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue
>>
>> [1] http://www.spinics.net/lists/linux-omap/msg66774.html
>>
>>  drivers/usb/host/ehci-omap.c |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
>> index 5c78f9e..26e9241 100644
>> --- a/drivers/usb/host/ehci-omap.c
>> +++ b/drivers/usb/host/ehci-omap.c
>> @@ -258,10 +258,10 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
>>  		udelay(10);
>>  
>>  		if (gpio_is_valid(pdata->reset_gpio_port[0]))
>> -			gpio_set_value(pdata->reset_gpio_port[0], 1);
>> +			gpio_set_value_cansleep(pdata->reset_gpio_port[0], 1);
>>  
>>  		if (gpio_is_valid(pdata->reset_gpio_port[1]))
>> -			gpio_set_value(pdata->reset_gpio_port[1], 1);
>> +			gpio_set_value_cansleep(pdata->reset_gpio_port[1], 1);
>>  	}
>>  
>>  	return 0;
> 
> 

-- 
Regards,
Igor.
