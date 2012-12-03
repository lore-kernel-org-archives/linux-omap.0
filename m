From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2 22/22] mfd: omap-usb-host: Don't spam console on clk_set_parent
 failure
Date: Mon, 3 Dec 2012 17:48:55 +0200
Message-ID: <50BCC9E7.7090106@ti.com>
References: <1354114150-11941-1-git-send-email-rogerq@ti.com> <1354114150-11941-23-git-send-email-rogerq@ti.com> <50BB8B78.9010207@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58468 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753906Ab2LCPs5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Dec 2012 10:48:57 -0500
In-Reply-To: <50BB8B78.9010207@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: balbi@ti.com, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On 12/02/2012 07:10 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 28-11-2012 18:49, Roger Quadros wrote:
> 
>> clk_set_parent is expected to fail on OMAP3 platforms. We don't
>> consider that as fatal so don't spam console.
> 
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>   drivers/mfd/omap-usb-host.c |   10 +++++-----
>>   1 files changed, 5 insertions(+), 5 deletions(-)
> 
>> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
>> index 6ede319..493e010 100644
>> --- a/drivers/mfd/omap-usb-host.c
>> +++ b/drivers/mfd/omap-usb-host.c
>> @@ -653,17 +653,17 @@ static int __devinit usbhs_omap_probe(struct
>> platform_device *pdev)
>>       }
>>
>>       if (is_ehci_phy_mode(pdata->port_mode[0])) {
>> -        /* for OMAP3 , the clk set paretn fails */
>> +        /* for OMAP3 , the clk set parent fails */
> 
>    Worth removing spave before comma too.
>
All valid points. Thanks for review.

cheers,
-roger

