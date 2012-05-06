From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] ARM: OMAP: USB: fix warning on EHCI PHY reset path
Date: Sun, 06 May 2012 09:25:05 +0300
Message-ID: <4FA61941.5080603@compulab.co.il>
References: <4F901CCC.9000703@compulab.co.il> <Pine.LNX.4.44L0.1204191059581.2070-100000@iolanthe.rowland.org> <20120420115728.GF12830@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:56774
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751220Ab2EFGZM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 May 2012 02:25:12 -0400
In-Reply-To: <20120420115728.GF12830@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com, Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keshava Munegowda <Keshava_mgowda@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Alan,


On 04/20/12 14:57, Felipe Balbi wrote:
> On Thu, Apr 19, 2012 at 11:01:16AM -0400, Alan Stern wrote:
>> On Thu, 19 Apr 2012, Igor Grinberg wrote:
>>
>>> ping
>>>
>>> Alan, Felipe,
>>> Can this go into 3.5?
>>
>> It's okay with me.
>>
>> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> 
> Also fine from my side:
> 
> Acked-by: Felipe Balbi <balbi@ti.com>
> 
>>> The dependency patch has already reached Samuel's tree,
>>> what would be the best way to apply this one?
>>> Should I ask Samuel to apply this one also (after having your acks)
>>> via his tree, to reduce possible merge failures/conflicts?
>>
>> Sure, go ahead.

Sorry, for being jumpy...
Samuel has not answered yet (it has been more then two weeks already)
and I'd like this to go into 3.5.
Also, the dependency patch is already in Linus' tree. It has been merged with
fixes (I thought it will happen only during the merge window...).

Can you, please take this one?

Thanks

>>
>>> On 03/27/12 16:08, Igor Grinberg wrote:
>>>> When PHY reset pin is connected to a GPIO on external GPIO chip
>>>> (e.g. I2C), we should not call the gpio_set_value() function, but
>>>> gpio_set_value_cansleep().
>>>>
>>>> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
>>>> ---
>>>> This patch depends on the patch from Keshava [1]:
>>>> ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue
>>>>
>>>> [1] http://www.spinics.net/lists/linux-omap/msg66774.html
>>>>
>>>>  drivers/usb/host/ehci-omap.c |    4 ++--
>>>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
>>>> index 5c78f9e..26e9241 100644
>>>> --- a/drivers/usb/host/ehci-omap.c
>>>> +++ b/drivers/usb/host/ehci-omap.c
>>>> @@ -258,10 +258,10 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
>>>>  		udelay(10);
>>>>  
>>>>  		if (gpio_is_valid(pdata->reset_gpio_port[0]))
>>>> -			gpio_set_value(pdata->reset_gpio_port[0], 1);
>>>> +			gpio_set_value_cansleep(pdata->reset_gpio_port[0], 1);
>>>>  
>>>>  		if (gpio_is_valid(pdata->reset_gpio_port[1]))
>>>> -			gpio_set_value(pdata->reset_gpio_port[1], 1);
>>>> +			gpio_set_value_cansleep(pdata->reset_gpio_port[1], 1);
>>>>  	}
>>>>  
>>>>  	return 0;
>>
> 

- -- 
Regards,
Igor.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJPphlAAAoJEBDE8YO64EfaejYP/0cjyLNgGzxeWJy9X5Q34C8S
UIvAb6bHQrYxIqpdZ8vctPI1vnXgHvaWAdUg24Y5IWY+TPCvr6NWv5PGfMe7zAD6
YHF6T7Yakn1C9geuPMCUNR0KRdd4EEN5YSXEu+ILr/xa7Bp2IzFvtThD8rqLeLWi
8z411WT/eCpGdk2Y6WPw41AWW1YyfEaFwPz49w6siypyw032tB32zIghaYzy2C8W
QtAUAbpBSw627tHRVPeVAqfQIK6plLoyCP9ql1FtaDbx/BwYlgALJv/1NrAgqtCe
8Kd6vfkEfZiUhsG2uO4cx9QwY2gKTu285mpMQe0824rWUSFd8s/JS3HdYhPxIZOb
HKjcYT4T9N0ZSJyPx0SqCOvP5wLPySSc2g37PdOis7+awH2a0HGIsoZJgXTkWbR/
giLmvaOvKoTjsSsPRCUBKuU4eRPlK2k7tm4eobo/7VAJnhrD0IGAWn4vH981PE1h
eM4b9TwAxC4s2xUdxe/v5e+zF0wqtBvfWjultQw9OvKskZfroPspdzhuzhrt86P6
Ecedu+moMNG00zFuoEgPZYY7h/de+8gPFp+jZfuWNDQSLwDmRpZINLcAB2VEnY8G
YrTN6lmaH00Fy8EVAqOhh7wnIB192myVo6axiGKwSbus3E91YboKYoTLEjArJEF7
DE5AB9sKxnZQpzihpwAt
=OFXi
-----END PGP SIGNATURE-----
