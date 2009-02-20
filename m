From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: OMAP3530 USB host problems
Date: Fri, 20 Feb 2009 12:35:29 -0700
Message-ID: <499F0601.7080608@mlbassoc.com>
References: <499EF348.6020302@mlbassoc.com> <20090220182904.GP20723@frodo> <499EFB84.1020201@mlbassoc.com> <20090220185426.GR20723@frodo> <499EFF0D.6060602@mlbassoc.com> <20090220192330.GN32564@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 137-67-76-76.skybeam.com ([76.76.67.137]:5177 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1755387AbZBTTfg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Feb 2009 14:35:36 -0500
In-Reply-To: <20090220192330.GN32564@gandalf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Felipe Balbi wrote:
> On Fri, Feb 20, 2009 at 12:05:49PM -0700, Gary Thomas wrote:
>> Felipe Balbi wrote:
>>> On Fri, Feb 20, 2009 at 11:50:44AM -0700, Gary Thomas wrote:
>>>> Felipe Balbi wrote:
>>>>> On Fri, Feb 20, 2009 at 11:15:36AM -0700, Gary Thomas wrote:
>>>>>> I have a 3530 board (similar to the OMAP3EVM) and I'm trying
>>>>>> to get the USB host working.  Sadly, this is failing, but I
>>>>>> don't quite see why.  From drivers/usb/host/echi-omap.c:
>>>>>> 	/* Wait for TLL to be Active */
>>>>>>         timeout = 1000;
>>>>>> 	while ((cm_read_mod_reg(CORE_MOD, OMAP2430_CM_IDLEST3)
>>>>>> 			& (1 << OMAP3430ES2_ST_USBTLL_SHIFT)))
>>>>>>         {
>>>>>>             if (--timeout <= 0) {
>>>>>>                 printk(KERN_ERR "USB TLL is unavailable\n");
>>>>>>                 return -ENODEV;
>>>>>>             }
>>>>>> 		cpu_relax();
>>>>>>         }
>>>>>>
>>>>>> Any clues on why this might be?  How do I solve it?
>>>>> could you enable CONFIG_DEBUG_LL and post the seria console output ?
>>>>>
>>>>> do you really use TLL ?? I don't really know omap3evm, but I guess it
>>>>> uses PHY mode (correct me if I'm wrong).
>>>>>
>>>> It's not that I _need_ TLL, the driver function omap_start_ehci()
>>>> tries to reset the part of the USB controller and fails.  I'm just
>>>> trying to understand why this part of the code falls over.
>>> you have OMAP_EHCI_TLL_MODE set, you should probably use
>>> OMAP_EHCI_PHY_MODE instead.
>>>
>>> You can fix it via "make menuconfig"
>>>
>> I already have that; this code is still being used.
>>   # CONFIG_OMAP_EHCI_TLL_MODE is not set
>>   CONFIG_OMAP_EHCI_PHY_MODE=y
>>
>> This is not used in the function above at all.
> 
> hmm.. true, just checked the function.
> 
> Weird, TRM says when that bit is 1, we cannot access ST_USBTLL, we
> should access it when it's 0, try the following:
> 
> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
> index 1b3266c..122e95b 100644
> --- a/drivers/usb/host/ehci-omap.c
> +++ b/drivers/usb/host/ehci-omap.c
> @@ -250,7 +250,7 @@ static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
>  
>         /* Wait for TLL to be Active */
>         while ((cm_read_mod_reg(CORE_MOD, OMAP2430_CM_IDLEST3)
> -                       & (1 << OMAP3430ES2_ST_USBTLL_SHIFT)))
> +                       & (0 << OMAP3430ES2_ST_USBTLL_SHIFT)))
>                 cpu_relax();
>  
>         /* perform TLL soft reset, and wait until reset is complete */
> 
> and tell us if it worked
> 

Sadly, I've already tried this and things just continue to fall apart.

  Unhandled fault: external abort on non-linefetch (0x1008) at 0xd8062010
  Internal error: : 1008 [#1]
  Modules linked in:
  CPU: 0    Not tainted  (2.6.27-omap1-svn4799-dirty14 #60)
  PC is at ehci_hcd_omap_drv_probe+0x370/0x5e4
  LR is at release_console_sem+0x1a8/0x1d8

Hence, my desired to figure out the TLL timeout...

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
