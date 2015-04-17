From: Roger Quadros <rogerq@ti.com>
Subject: Re: [RFC][PATCH v2 06/13] usb: hcd: Add hcd add/remove functions
 for OTG use
Date: Fri, 17 Apr 2015 10:21:19 +0300
Message-ID: <5530B46F.6010400@ti.com>
References: <1429008120-5395-1-git-send-email-rogerq@ti.com> <1429008120-5395-7-git-send-email-rogerq@ti.com> <20150417021812.GB13764@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150417021812.GB13764@shlinux2>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <peter.chen@freescale.com>
Cc: gregkh@linuxfoundation.org, balbi@ti.com, stern@rowland.harvard.edu, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 17/04/15 05:18, Peter Chen wrote:
> On Tue, Apr 14, 2015 at 01:41:53PM +0300, Roger Quadros wrote:
>> The existing usb_add/remove_hcd() functionality
>> remains unchanged for non-OTG devices. For OTG
>> devices they only register the HCD with the OTG core.
>>
>> Introduce _usb_add/remove_hcd() for use by OTG core.
>> These functions actually add/remove the HCD.
> 
> Would you please explain why additional _usb_add/remove_hcd are needed?

It is to differentiate if the add/remove_hcd was called by the
HCD drivers or by the OTG core as we want to behave a bit differently
in both cases.
When called by HCD drivers, we want to defer the add/remove if it is an
OTG device. When called by OTG core, we don't want to defer the add/remove.

HCD drivers use usb_add/remove_hcd()
OTG core uses _usb_add/remove_hcd()

cheers,
-roger

> 
> Peter
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  drivers/usb/common/usb-otg.c | 14 +++++++-------
>>  drivers/usb/core/hcd.c       | 24 ++++++++++++++++++++++--
>>  include/linux/usb/hcd.h      |  3 +++
>>  3 files changed, 32 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/usb/common/usb-otg.c b/drivers/usb/common/usb-otg.c
>> index e848e08..860e2e7 100644
>> --- a/drivers/usb/common/usb-otg.c
>> +++ b/drivers/usb/common/usb-otg.c
>> @@ -198,18 +198,18 @@ static int usb_otg_start_host(struct otg_fsm *fsm, int on)
>>  			otgd->start_host(fsm, on);
>>  
>>  		/* start host */
>> -		usb_add_hcd(otgd->primary_hcd.hcd, otgd->primary_hcd.irqnum,
>> -			    otgd->primary_hcd.irqflags);
>> +		_usb_add_hcd(otgd->primary_hcd.hcd, otgd->primary_hcd.irqnum,
>> +			     otgd->primary_hcd.irqflags);
>>  		if (otgd->shared_hcd.hcd) {
>> -			usb_add_hcd(otgd->shared_hcd.hcd,
>> -				    otgd->shared_hcd.irqnum,
>> -				    otgd->shared_hcd.irqflags);
>> +			_usb_add_hcd(otgd->shared_hcd.hcd,
>> +				     otgd->shared_hcd.irqnum,
>> +				     otgd->shared_hcd.irqflags);
>>  		}
>>  	} else {
>>  		/* stop host */
>>  		if (otgd->shared_hcd.hcd)
>> -			usb_remove_hcd(otgd->shared_hcd.hcd);
>> -		usb_remove_hcd(otgd->primary_hcd.hcd);
>> +			_usb_remove_hcd(otgd->shared_hcd.hcd);
>> +		_usb_remove_hcd(otgd->primary_hcd.hcd);
>>  
>>  		/* OTG device operations */
>>  		if (otgd->start_host)
>> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
>> index 45a915c..9a9c0f7 100644
>> --- a/drivers/usb/core/hcd.c
>> +++ b/drivers/usb/core/hcd.c
>> @@ -46,6 +46,7 @@
>>  #include <linux/usb.h>
>>  #include <linux/usb/hcd.h>
>>  #include <linux/usb/phy.h>
>> +#include <linux/usb/usb-otg.h>
>>  
>>  #include "usb.h"
>>  
>> @@ -2622,7 +2623,7 @@ static void usb_put_invalidate_rhdev(struct usb_hcd *hcd)
>>   * buffers of consistent memory, register the bus, request the IRQ line,
>>   * and call the driver's reset() and start() routines.
>>   */
>> -int usb_add_hcd(struct usb_hcd *hcd,
>> +int _usb_add_hcd(struct usb_hcd *hcd,
>>  		unsigned int irqnum, unsigned long irqflags)
>>  {
>>  	int retval;
>> @@ -2827,6 +2828,17 @@ err_phy:
>>  	}
>>  	return retval;
>>  }
>> +EXPORT_SYMBOL_GPL(_usb_add_hcd);
>> +
>> +int usb_add_hcd(struct usb_hcd *hcd,
>> +		unsigned int irqnum, unsigned long irqflags)
>> +{
>> +	/* If OTG device, OTG core takes care of adding HCD */
>> +	if (usb_otg_register_hcd(hcd, irqnum, irqflags))
>> +		return _usb_add_hcd(hcd, irqnum, irqflags);
>> +
>> +	return 0;
>> +}
>>  EXPORT_SYMBOL_GPL(usb_add_hcd);
>>  
>>  /**
>> @@ -2837,7 +2849,7 @@ EXPORT_SYMBOL_GPL(usb_add_hcd);
>>   * Disconnects the root hub, then reverses the effects of usb_add_hcd(),
>>   * invoking the HCD's stop() method.
>>   */
>> -void usb_remove_hcd(struct usb_hcd *hcd)
>> +void _usb_remove_hcd(struct usb_hcd *hcd)
>>  {
>>  	struct usb_device *rhdev = hcd->self.root_hub;
>>  
>> @@ -2911,6 +2923,14 @@ void usb_remove_hcd(struct usb_hcd *hcd)
>>  
>>  	usb_put_invalidate_rhdev(hcd);
>>  }
>> +EXPORT_SYMBOL_GPL(_usb_remove_hcd);
>> +
>> +void usb_remove_hcd(struct usb_hcd *hcd)
>> +{
>> +	/* If OTG device, OTG core takes care of stopping HCD */
>> +	if (usb_otg_unregister_hcd(hcd))
>> +		_usb_remove_hcd(hcd);
>> +}
>>  EXPORT_SYMBOL_GPL(usb_remove_hcd);
>>  
>>  void
>> diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
>> index 68b1e83..7993ae7 100644
>> --- a/include/linux/usb/hcd.h
>> +++ b/include/linux/usb/hcd.h
>> @@ -433,7 +433,10 @@ extern void usb_put_hcd(struct usb_hcd *hcd);
>>  extern int usb_hcd_is_primary_hcd(struct usb_hcd *hcd);
>>  extern int usb_add_hcd(struct usb_hcd *hcd,
>>  		unsigned int irqnum, unsigned long irqflags);
>> +extern int _usb_add_hcd(struct usb_hcd *hcd,
>> +		unsigned int irqnum, unsigned long irqflags);
>>  extern void usb_remove_hcd(struct usb_hcd *hcd);
>> +extern void _usb_remove_hcd(struct usb_hcd *hcd);
>>  extern int usb_hcd_find_raw_port_number(struct usb_hcd *hcd, int port1);
>>  
>>  struct platform_device;
>> -- 
>> 2.1.0
>>
> 
