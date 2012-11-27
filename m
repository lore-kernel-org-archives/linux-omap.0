From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 06/16] mfd: omap-usb-host: cleanup clock management code
Date: Tue, 27 Nov 2012 11:41:38 +0200
Message-ID: <50B48AD2.7070008@ti.com>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com> <1352990054-14680-7-git-send-email-rogerq@ti.com> <20121121133913.GH10216@arwen.pp.htv.fi> <50B38765.5070901@ti.com> <20121126200242.GA15259@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54227 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758561Ab2K0Jll (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Nov 2012 04:41:41 -0500
In-Reply-To: <20121126200242.GA15259@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On 11/26/2012 10:02 PM, Felipe Balbi wrote:
> Hi,
> 
> On Mon, Nov 26, 2012 at 05:14:45PM +0200, Roger Quadros wrote:
>> Felipe,
>>
>> On 11/21/2012 03:39 PM, Felipe Balbi wrote:
>>> Hi,
>>>
>>> On Thu, Nov 15, 2012 at 04:34:04PM +0200, Roger Quadros wrote:
>>>> All ports have similarly named port clocks so we can
>>>> bunch them into a port data structure and use for loop
>>>> to enable/disable the clocks.
>>>>
>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>> ---
>>>>  drivers/mfd/omap-usb-host.c |  208 +++++++++++++++++++++----------------------
>>>>  1 files changed, 101 insertions(+), 107 deletions(-)
>>>>
>>>> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
>>>> index 23cec57..7303c41 100644
>>>> --- a/drivers/mfd/omap-usb-host.c
>>>> +++ b/drivers/mfd/omap-usb-host.c
>>>> @@ -76,6 +76,8 @@
>>>>  
>>>>  #define	OMAP_UHH_DEBUG_CSR				(0x44)
>>>>  
>>>> +#define MAX_HS_USB_PORTS	3	/* Increase this if any chip has more */
>>>> +
>>>>  /* Values of UHH_REVISION - Note: these are not given in the TRM */
>>>>  #define OMAP_USBHS_REV1		0x00000010	/* OMAP3 */
>>>>  #define OMAP_USBHS_REV2		0x50700100	/* OMAP4 */
>>>> @@ -87,14 +89,15 @@
>>>>  #define is_ehci_tll_mode(x)	(x == OMAP_EHCI_PORT_MODE_TLL)
>>>>  #define is_ehci_hsic_mode(x)	(x == OMAP_EHCI_PORT_MODE_HSIC)
>>>>  
>>>> +struct usbhs_port {
>>>> +	struct clk	*utmi_clk;
>>>> +};
>>>
>>> I rather not since this will make it a lot more difficult to use
>>> pm_clk_add() :-s Also, this sort of thing should be dynamically
>>> allocated anyway ;-)
>>>
>>
>> Why do you say so? The whole point of this patch is to group similarly
>> named clocks so that we can use a for loop and set number of ports (or
>> clocks) dynamically. I suppose it would be just a matter of replacing
>> clk_enable/disable() with pm_clk_add() later, right?
>>
>> If you see patch 11, we are adding 2 HSIC related clocks to this
>> structure. This means 9 clocks (i.e. 3 clocks for 3 ports) can be
>> managed using a simple for loop instead of coding each clock name by hand.
> 
> that's usually not what you want, actually. You want clock management to
> be explicit so you can have micro-power optimizations. I fear that the
> time omap-usb-host.c gets *truly* stabilized and we move to more
> aggressive PM, we will undo these changes just to have a more granular
> control of the clocks, at which point your patch would be rendered
> useless.
> 

The granularity is still there, just that port clocks are grouped
together. Do you think it is better if I get rid of 'struct usbhs_port'
and keep the clocks in the main structure instead?

e.g.

struct usbhs_hcd_omap {
	struct clk	**utmi_clk;
	struct clk	**hsic1_clk;
	struct clk	**hsic2_clk;
...
}

The clocks can then be accessed as follows

	omap->utmi_clk[i];	/* i is port number */

Does this sound OK to you?

cheers,
-roger
