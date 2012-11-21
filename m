From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 10/16] mfd: omap-usb-host: Intialize all available ports
Date: Wed, 21 Nov 2012 17:47:06 +0200
Message-ID: <50ACF77A.9060308@ti.com>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com> <1352990054-14680-11-git-send-email-rogerq@ti.com> <20121121135246.GL10216@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48532 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755209Ab2KUPrI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Nov 2012 10:47:08 -0500
In-Reply-To: <20121121135246.GL10216@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On 11/21/2012 03:52 PM, Felipe Balbi wrote:
> On Thu, Nov 15, 2012 at 04:34:08PM +0200, Roger Quadros wrote:
>> OMAPs till date can have upto 3 ports. We need to initialize
> 
> s/upto/up to/
> 
>> the port mode in HOSTCONFIG register for all of them.
> 
> why *all* of them ? Isn't it enough to initialize only the ones we're
> going to use ? If not, why ?

Right. I'll correct the $SUBJECT and comment.

> 
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  drivers/mfd/omap-usb-host.c |   31 ++++++++++++-------------------
>>  1 files changed, 12 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
>> index c20234b..0d39bd7 100644
>> --- a/drivers/mfd/omap-usb-host.c
>> +++ b/drivers/mfd/omap-usb-host.c
>> @@ -67,12 +67,9 @@
>>  #define OMAP4_UHH_SYSCONFIG_NOSTDBY			(1 << 4)
>>  #define OMAP4_UHH_SYSCONFIG_SOFTRESET			(1 << 0)
>>  
>> -#define OMAP4_P1_MODE_CLEAR				(3 << 16)
>> +#define OMAP4_P1_MODE_MASK				(3 << 16)
> 
> changing this name isn't part of $SUBJECT.
> 
>>  #define OMAP4_P1_MODE_TLL				(1 << 16)
>>  #define OMAP4_P1_MODE_HSIC				(3 << 16)
>> -#define OMAP4_P2_MODE_CLEAR				(3 << 18)
>> -#define OMAP4_P2_MODE_TLL				(1 << 18)
>> -#define OMAP4_P2_MODE_HSIC				(3 << 18)
> 
> why do you delete these ? Also not part of $SUBJECT.
> 
>>  
>>  #define	OMAP_UHH_DEBUG_CSR				(0x44)
>>  
>> @@ -343,6 +340,7 @@ static void omap_usbhs_init(struct device *dev)
>>  	struct usbhs_omap_platform_data	*pdata = omap->pdata;
>>  	unsigned long			flags;
>>  	unsigned			reg;
>> +	int i;
>>  
>>  	dev_dbg(dev, "starting TI HSUSB Controller\n");
>>  
>> @@ -403,21 +401,16 @@ static void omap_usbhs_init(struct device *dev)
>>  				reg |= OMAP_UHH_HOSTCONFIG_ULPI_P3_BYPASS;
>>  		}
>>  	} else if (is_omap_usbhs_rev2(omap)) {
>> -		/* Clear port mode fields for PHY mode*/
>> -		reg &= ~OMAP4_P1_MODE_CLEAR;
>> -		reg &= ~OMAP4_P2_MODE_CLEAR;
>> -
>> -		if (is_ehci_tll_mode(pdata->port_mode[0]) ||
>> -			(is_ohci_port(pdata->port_mode[0])))
>> -			reg |= OMAP4_P1_MODE_TLL;
>> -		else if (is_ehci_hsic_mode(pdata->port_mode[0]))
>> -			reg |= OMAP4_P1_MODE_HSIC;
>> -
>> -		if (is_ehci_tll_mode(pdata->port_mode[1]) ||
>> -			(is_ohci_port(pdata->port_mode[1])))
>> -			reg |= OMAP4_P2_MODE_TLL;
>> -		else if (is_ehci_hsic_mode(pdata->port_mode[1]))
>> -			reg |= OMAP4_P2_MODE_HSIC;
>> +		for (i = 0; i < omap->nports; i++) {
>> +			/* Clear port mode fields for PHY mode*/
>> +			reg &= ~(OMAP4_P1_MODE_MASK << 2*i);
> 
> add spaces around '*' operator.
> 
>> +			if (is_ehci_tll_mode(pdata->port_mode[i]) ||
>> +				(is_ohci_port(pdata->port_mode[i])))
>> +				reg |= OMAP4_P1_MODE_TLL << 2*i;
> 
> ditto
> 
>> +			else if (is_ehci_hsic_mode(pdata->port_mode[i]))
>> +				reg |= OMAP4_P1_MODE_HSIC << 2*i;
> 
> ditto
> 
> in fact, I would convert this construct into a switch which would look
> like:
> 
> reg &= ~(OMAP4_P1_MODE_MASK << i * 2);
> 
> switch (port_mode[i]) {
> case OMAP4_P1_MODE_TLL:
> 	reg |= OMAP4_P1_MODE_TLL << i * 2;
> 	break;
> case OMAP_P1_MODE_HSIC:
> 	reg |= OMAP4_P1_MODE_HSIC << i * 2;
> 	break;
> }
> 
> Also, it looks like the whoel for loop with port mode settings could be
> re-factored to a separate function to aid readability.
> 

To clarify, did you mean to use a function for the above code snippet
where we set the HOSTCONFIG part?

cheers,
-roger

