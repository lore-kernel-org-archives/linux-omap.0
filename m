From: John Youn <John.Youn@synopsys.com>
Subject: Re: [PATCH v5 01/46] usb: gadget: encapsulate endpoint claiming
 mechanism
Date: Thu, 20 Aug 2015 20:07:35 +0000
Message-ID: <2B3535C5ECE8B5419E3ECBE30077290901DC3380D9@us01wembx1.internal.synopsys.com>
References: <1438351258-31578-1-git-send-email-r.baldyga@samsung.com>
 <1438351258-31578-2-git-send-email-r.baldyga@samsung.com>
 <20150820153553.GD1639@saruman.tx.rr.com> <55D6001E.3000504@hackerion.com>
 <20150820164808.GB4938@saruman.tx.rr.com> <55D60B80.7040800@hackerion.com>
 <20150820174409.GB7270@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: "balbi@ti.com" <balbi@ti.com>, Robert Baldyga <r.baldyga@hackerion.com>
Cc: "nicolas.ferre@atmel.com" <nicolas.ferre@atmel.com>, "robert.jarzmik@free.fr" <robert.jarzmik@free.fr>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "cernekee@gmail.com" <cernekee@gmail.com>, "michal.simek@xilinx.com" <michal.simek@xilinx.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "Peter.Chen@freescale.com" <Peter.Chen@freescale.com>, "dahlmann.thomas@arcor.de" <dahlmann.thomas@arcor.de>, "leoli@freescale.com" <leoli@freescale.com>, Robert Baldyga <r.baldyga@samsung.com>, "linux-geode@lists.infradead.org" <linux-geode@lists.infradead.org>, "haojian.zhuang@gmail.com" <haojian.zhuang@gmail.com>, "andrzej.p@samsung.com" <andrzej.p@samsung.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "petr.cvek@tul.cz" <petr.cvek@tul.cz>"linux-arm-kernel@lists.infradead.org" <lin>
List-Id: linux-omap@vger.kernel.org

On 8/20/2015 10:45 AM, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Aug 20, 2015 at 07:16:48PM +0200, Robert Baldyga wrote:
>> On 08/20/2015 06:48 PM, Felipe Balbi wrote:
>>> On Thu, Aug 20, 2015 at 06:28:14PM +0200, Robert Baldyga wrote:
>>>> Hi Felipe,
>>>>
>>>> On 08/20/2015 05:35 PM, Felipe Balbi wrote:
>>>> [...]
>>>>> just letting you know that this regresses all gadget drivers making them
>>>>> try to disable previously disabled endpoints and enable previously
>>>>> enabled endpoints.
>>>>>
>>>>> I have a possible fix (see below) but then it shows a problem on the
>>>>> host side when using with g_zero (see further below):
>>>>>
>>>>> commit 3b8932100aacb6cfbffe288ca93025d8b8430c00
>>>>> Author: Felipe Balbi <balbi@ti.com>
>>>>> Date:   Wed Aug 19 18:05:27 2015 -0500
>>>>>
>>>>>     usb: gadget: fix ep->claimed lifetime
>>>>>
>>>>>     In order to fix a regression introduced by commit
>>>>>     cc476b42a39d ("usb: gadget: encapsulate endpoint
>>>>>     claiming mechanism") we have to introduce a simple
>>>>>     helper to check if a particular is enabled or not.
>>>>>
>>>>>     After that, we need to move ep->claimed lifetime to
>>>>>     usb_ep_enable() and usb_ep_disable() since those
>>>>>     are the only functions which actually enable and
>>>>>     disable endpoints.
>>>>>
>>>>>     A follow-up patch will come to drop all driver_data
>>>>>     checks from function drivers, since those are, now,
>>>>>     pointless.
>>>>>
>>>>>     Fixes: cc476b42a39d ("usb: gadget: encapsulate endpoint
>>>>>     	claiming mechanism")
>>>>>     Cc: Robert Baldyga <r.baldyga@samsung.com>
>>>>>     Signed-off-by: Felipe Balbi <balbi@ti.com>
>>>>>
>>>>> diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
>>>>> index 978435a51038..ad45070cd76f 100644
>>>>> --- a/drivers/usb/gadget/epautoconf.c
>>>>> +++ b/drivers/usb/gadget/epautoconf.c
>>>>> @@ -126,7 +126,6 @@ found_ep:
>>>>>  	ep->address = desc->bEndpointAddress;
>>>>>  	ep->desc = NULL;
>>>>>  	ep->comp_desc = NULL;
>>>>> -	ep->claimed = true;
>>>>
>>>> Removing this line causes autoconfig can return the same endpoint many
>>>> times. This probably causes problems with g_zero.
>>>>
>>>> I will try to fix it ASAP.
>>>
>>> I was considering the same thing, but the lifetime of ->claimed doesn't
>>> look correct to me either way. Note that once the flag is enabled, it
>>> won't get disabled by most gadget drivers.
>>
>> And it should not be. This flag is indicator, that endpoint is used by some
>> function. It should be set once by usb_ep_autoconfig() and cleared by
>> usb_ep_autoconfig_reset().

And the 'claimed' flag should be used for the ep autoconfig
mechanism alone. We may want to reset it during the autoconfig
phase for multiple configs and alt-interfaces. So there should be
separate 'claimed' and 'enabled' flags.


> 
> have you considered switching interfaces and/or alternate settings ?

We ran into similar issues before with this very scenario. Handling
of set_config(0 or N), in both addressed and configured states, and
set_interface requests.


John
