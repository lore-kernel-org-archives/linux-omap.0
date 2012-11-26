From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 06/16] mfd: omap-usb-host: cleanup clock management code
Date: Mon, 26 Nov 2012 17:14:45 +0200
Message-ID: <50B38765.5070901@ti.com>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com> <1352990054-14680-7-git-send-email-rogerq@ti.com> <20121121133913.GH10216@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38384 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754948Ab2KZPOr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Nov 2012 10:14:47 -0500
In-Reply-To: <20121121133913.GH10216@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Felipe,

On 11/21/2012 03:39 PM, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Nov 15, 2012 at 04:34:04PM +0200, Roger Quadros wrote:
>> All ports have similarly named port clocks so we can
>> bunch them into a port data structure and use for loop
>> to enable/disable the clocks.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  drivers/mfd/omap-usb-host.c |  208 +++++++++++++++++++++----------------------
>>  1 files changed, 101 insertions(+), 107 deletions(-)
>>
>> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
>> index 23cec57..7303c41 100644
>> --- a/drivers/mfd/omap-usb-host.c
>> +++ b/drivers/mfd/omap-usb-host.c
>> @@ -76,6 +76,8 @@
>>  
>>  #define	OMAP_UHH_DEBUG_CSR				(0x44)
>>  
>> +#define MAX_HS_USB_PORTS	3	/* Increase this if any chip has more */
>> +
>>  /* Values of UHH_REVISION - Note: these are not given in the TRM */
>>  #define OMAP_USBHS_REV1		0x00000010	/* OMAP3 */
>>  #define OMAP_USBHS_REV2		0x50700100	/* OMAP4 */
>> @@ -87,14 +89,15 @@
>>  #define is_ehci_tll_mode(x)	(x == OMAP_EHCI_PORT_MODE_TLL)
>>  #define is_ehci_hsic_mode(x)	(x == OMAP_EHCI_PORT_MODE_HSIC)
>>  
>> +struct usbhs_port {
>> +	struct clk	*utmi_clk;
>> +};
> 
> I rather not since this will make it a lot more difficult to use
> pm_clk_add() :-s Also, this sort of thing should be dynamically
> allocated anyway ;-)
> 

Why do you say so? The whole point of this patch is to group similarly
named clocks so that we can use a for loop and set number of ports (or
clocks) dynamically. I suppose it would be just a matter of replacing
clk_enable/disable() with pm_clk_add() later, right?

If you see patch 11, we are adding 2 HSIC related clocks to this
structure. This means 9 clocks (i.e. 3 clocks for 3 ports) can be
managed using a simple for loop instead of coding each clock name by hand.

--
cheers,
-roger
