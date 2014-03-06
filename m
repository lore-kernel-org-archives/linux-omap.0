From: Roger Quadros <rogerq@ti.com>
Subject: Re: Help needed USB hub disconnected at resume
Date: Thu, 6 Mar 2014 11:07:11 +0200
Message-ID: <53183ABF.50408@ti.com>
References: <F690310232FDDF4AB457E8B3EF90DDE0AA85E10B@MARCM-SBS2011.marcmltd.local> <F690310232FDDF4AB457E8B3EF90DDE0AA85E1E7@MARCM-SBS2011.marcmltd.local> <F690310232FDDF4AB457E8B3EF90DDE0AA85E21F@MARCM-SBS2011.marcmltd.local> <53146225.8040403@ti.com> <531472B3.1060104@compulab.co.il> <F690310232FDDF4AB457E8B3EF90DDE0AA85E7F2@MARCM-SBS2011.marcmltd.local> <5315761D.8080103@compulab.co.il> <F690310232FDDF4AB457E8B3EF90DDE0AA85FF56@MARCM-SBS2011.marcmltd.local> <20140304224427.GA31462@saruman.home> <F690310232FDDF4AB457E8B3EF90DDE0AA86001B@MARCM-SBS2011.marcmltd.local> <20140304234240.GB2521@saruman.home> <F690310232FDDF4AB457E8B3EF90DDE0AA8612DC@MARCM-SBS2011.marcmltd.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60707 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190AbaCFJHV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Mar 2014 04:07:21 -0500
In-Reply-To: <F690310232FDDF4AB457E8B3EF90DDE0AA8612DC@MARCM-SBS2011.marcmltd.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Murphy <marcmltd@marcm.co.uk>, "'balbi@ti.com'" <balbi@ti.com>
Cc: 'Igor Grinberg' <grinberg@compulab.co.il>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 03/06/2014 01:29 AM, Marc Murphy wrote:
>> -----Original Message-----
>> From: Felipe Balbi [mailto:balbi@ti.com]
>> Sent: 04 March 2014 23:43
>> To: Marc Murphy
>> Cc: 'balbi@ti.com'; 'Igor Grinberg'; Roger Quadros; linux-
>> omap@vger.kernel.org
>> Subject: Re: Help needed USB hub disconnected at resume
>>
>> On Tue, Mar 04, 2014 at 11:05:58PM +0000, Marc Murphy wrote:
>>>> -----Original Message-----
>>>> From: Felipe Balbi [mailto:balbi@ti.com]
>>>> Sent: 04 March 2014 22:44
>>>> To: Marc Murphy
>>>> Cc: 'Igor Grinberg'; Roger Quadros; linux-omap@vger.kernel.org
>>>> Subject: Re: Help needed USB hub disconnected at resume
>>>>
>>>> Hi,
>>>>
>>>> On Tue, Mar 04, 2014 at 10:34:56PM +0000, Marc Murphy wrote:
>>>>> static __init void tam3517_ehci_init(void) {
>>>>>     /* Configure GPIO for EHCI port */
>>>>>     omap_mux_init_gpio(TAM3517_EHCI_RESET, OMAP_PIN_OUTPUT);
>>>>>
>>>>>     gpio_request(TAM3517_EHCI_RESET, "USB_RESET");
>>>>>     gpio_direction_output(TAM3517_EHCI_RESET, 1);
>>>>>     gpio_export(TAM3517_EHCI_RESET, 0);
>>>>
>>>> why are you exporting this gpio ?
>>>
>>>
>>> It makes no difference whether I configure the GPIO or not.
>>
>> gpio_export() is only to expose the gpio to sysfs. Check if that pin is active
>> high or active low. Then what you need, most likely, is something like below:
>>
>> gpio_direction_output(RESET, HIGH);
>> usleep_range(50000, 2000000);
>> gpio_set_value(RESET, LOW);
>>
>> (assuming active high here)
> 
> Thanks, the export was for sysfs so that I could toggle the state myself to debug.  The reference has now been removed and the toggling left to the driver (ehci)
> 
> Igor, I have been looking at the ehci driver and the reset pin of the 3320 is toggled at initialisation but there is no resetting when resuming from sleep.  I have created a resume function;
> 

There should be no need to reset the PHY during suspend/resume.

Can you please try your board on v3.13? A lot of cleanup has been done since 3.4.

cheers,
-roger


> static void ehci_hcd_omap_resume(struct platform_device *pdev)
> {
>     struct device *dev              = &pdev->dev;
>     struct usb_hcd *hcd             = dev_get_drvdata(dev);
>     struct ehci_hcd_omap_platform_data *pdata   = dev->platform_data;
> 
> 
>     if (pdata->phy_reset) {
>         if (gpio_is_valid(pdata->reset_gpio_port[0]))
>             gpio_set_value(pdata->reset_gpio_port[0], 0);
> 
>         if (gpio_is_valid(pdata->reset_gpio_port[1]))
>             gpio_set_value(pdata->reset_gpio_port[1], 0);
> 
>         /* Hold the PHY in RESET for enough time till DIR is high */
>         udelay(100);
>     }
> 
>     if (pdata->phy_reset) {
>         /* Hold the PHY in RESET for enough time till
>          * PHY is settled and ready
>          */
>         udelay(10);
> 
>         if (gpio_is_valid(pdata->reset_gpio_port[0]))
>             gpio_set_value(pdata->reset_gpio_port[0], 1);
> 
>         if (gpio_is_valid(pdata->reset_gpio_port[1]))
>             gpio_set_value(pdata->reset_gpio_port[1], 1);
>     }
> }
> 
> And linked in the static struct platform_driver ehci_hcd_omap_driver = {
> 	.resume		= ehci_hcd_omap_resume,
> 
> It calls the function at resume and I can see the line toggle on the scope but still the same response from the driver of disconnecting the hub.
> 
> I have even stepped through ehci_bus_resume (struct usb_hcd *hcd) and it all seems to be OK with the bringup.
> 
> Is there any way to enable more debug so that I can see the path through the pm and hci code ?
> 
> I have enabled dynamic debug in the kernel but when I pass the dyndbg modules on the command line I don't seem to get any additional output... e.g.
> rootfstype=nfs ip=dhcp nohlt no_console_suspend=1 dyndbg=" module ehci_hcd +p ; module uhci_hcd +p ; module ohci_hcd +p" rw
> 
> 
> Marc
>>
>> --
>> balbi

