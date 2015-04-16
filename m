From: Roger Quadros <rogerq@ti.com>
Subject: Re: [RFC][PATCH v2 03/13] usb: otg-fsm: Prevent build warning "VDBG"
 redefined
Date: Thu, 16 Apr 2015 14:59:12 +0300
Message-ID: <552FA410.4030508@ti.com>
References: <1429008120-5395-1-git-send-email-rogerq@ti.com> <1429008120-5395-4-git-send-email-rogerq@ti.com> <20150416114152.GC3181@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41857 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753230AbbDPL7V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Apr 2015 07:59:21 -0400
In-Reply-To: <20150416114152.GC3181@shlinux2>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Chen <peter.chen@freescale.com>
Cc: gregkh@linuxfoundation.org, balbi@ti.com, stern@rowland.harvard.edu, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

On 16/04/15 14:41, Peter Chen wrote:
> On Tue, Apr 14, 2015 at 01:41:50PM +0300, Roger Quadros wrote:
>> If usb/otg-fsm.h and usb/composite.h are included together
>> then it results in the build warning [1].
>>
>> Prevent that by moving the VDBG defination into the
>> usb-otg-fsm.c file where it is used.
>>
>> Also get rid of MPC_LOC which doesn't seem to be used
>> by anyone.
>>
>> [1] - warning fixed by this patch:
>>
>>    In file included from drivers/usb/dwc3/core.h:33,
>>                     from drivers/usb/dwc3/ep0.c:33:
>>    include/linux/usb/otg-fsm.h:30:1: warning: "VDBG" redefined
>>    In file included from drivers/usb/dwc3/ep0.c:31:
>>    include/linux/usb/composite.h:615:1: warning: this is the location of the previous definition
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  drivers/usb/common/usb-otg-fsm.c |  9 +++++++++
>>  include/linux/usb/otg-fsm.h      | 15 ---------------
>>  2 files changed, 9 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/usb/common/usb-otg-fsm.c b/drivers/usb/common/usb-otg-fsm.c
>> index 0caa37b..35f311a 100644
>> --- a/drivers/usb/common/usb-otg-fsm.c
>> +++ b/drivers/usb/common/usb-otg-fsm.c
>> @@ -30,6 +30,15 @@
>>  #include <linux/usb/otg.h>
>>  #include <linux/usb/otg-fsm.h>
>>  
>> +#undef VDBG
>> +
>> +#ifdef VERBOSE
>> +#define VDBG(fmt, args...) pr_debug("[%s]  " fmt , \
>> +				 __func__, ## args)
>> +#else
>> +#define VDBG(stuff...)	do {} while (0)
>> +#endif
>> +
> 
> It is obsolete too, we may use dev_vdbg instead of it.

ok, we need to add 'struct device *' to 'struct otg_fsm' then.

cheers,
-roger

> 
>>  /* Change USB protocol when there is a protocol change */
>>  static int otg_set_protocol(struct otg_fsm *fsm, int protocol)
>>  {
>> diff --git a/include/linux/usb/otg-fsm.h b/include/linux/usb/otg-fsm.h
>> index 85a9150..73136aa 100644
>> --- a/include/linux/usb/otg-fsm.h
>> +++ b/include/linux/usb/otg-fsm.h
>> @@ -21,21 +21,6 @@
>>  #include <linux/mutex.h>
>>  #include <linux/errno.h>
>>  
>> -#undef VERBOSE
>> -
>> -#ifdef VERBOSE
>> -#define VDBG(fmt, args...) pr_debug("[%s]  " fmt , \
>> -				 __func__, ## args)
>> -#else
>> -#define VDBG(stuff...)	do {} while (0)
>> -#endif
>> -
>> -#ifdef VERBOSE
>> -#define MPC_LOC printk("Current Location [%s]:[%d]\n", __FILE__, __LINE__)
>> -#else
>> -#define MPC_LOC do {} while (0)
>> -#endif
>> -
>>  #define PROTO_UNDEF	(0)
>>  #define PROTO_HOST	(1)
>>  #define PROTO_GADGET	(2)
>> -- 
>> 2.1.0
>>
> 

