From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: usb-related linux-next boot failures
Date: Wed, 28 Jun 2017 19:08:32 +0530
Message-ID: <71bae311-f85b-4fe1-06c2-d43bfee42b88@ti.com>
References: <0d1a491c-41c4-a02d-cdf8-e1a95a1fe989@ti.com>
 <20170628045543.GA28759@kroah.com> <87r2y45x97.fsf@linux.intel.com>
 <20170628103014.GC3730@atomide.com>
 <34a37d06-1929-814b-3476-6eaa5a45cd39@ti.com>
 <87k23w5qn2.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87k23w5qn2.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Carlos Hernandez <ceh-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On Wednesday 28 June 2017 04:24 PM, Felipe Balbi wrote:
> 
> Hi,
> 
> Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org> writes:
>> On Wednesday 28 June 2017 04:00 PM, Tony Lindgren wrote:
>>>  Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> [170628 01:32]:
>>>> Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> writes:
>>>>> On Tue, Jun 27, 2017 at 02:28:56PM -0400, Carlos Hernandez wrote:
>>>>>> Still seeing AM57xx/DRA72/DRA7x usb-related boot failures on linux-next...
>>>>>
>>>>> Is this a regression?  If so, any specific commit that caused it?
>>>>
>>>> I did ask for a bisection last time but nobody from TI replied ;-)
>>>>
>>>> https://marc.info/?i=87h8zi4gmx.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
>>>>
>>>> Can't really help without bisection logs :-)
>>>
>>> Seems this warning got add with 04c848d39879 ("genirq: Warn when
>>> IRQ_NOAUTOEN is used with shared interrupts"). The fix is to get
>>> rid of IRQ_NOAUTOEN and enable_irq for a shared interrupt. Hard
>>> to say as the warning line does not match the version of next I
>>> have so this should be verified.
>>>
>>
>> There seems to be two different problems here.
>> One is what Tony is pointing to above that throws a first warn dump
>> during dwc3_omap_probe().
>>
>> Second one is the imprecise external abort that happens later:
>> [   24.809939] Unhandled fault: imprecise external abort (0x1406) at
>> 0x00000000
>>
>> Bisecting the second issue lead to the first bad commit as:
>> commit f54edb539c1167e7a96073848d0afad100df4580
>> Author: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> Date:   Mon Jun 5 17:03:18 2017 +0300
>>
>>     usb: dwc3: core: initialize ULPI before trying to get the PHY
>>
>>     If don't reorder initialization like this, we will never be able to
>>     get a reference to ULPI PHYs.
>>
>>     Signed-off-by: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>>
>>
>>
>> Reverting above commit from -next seems to help.
> 
> reverting will break other things. Seems like we should move
> pm_runtime_* operations a little earlier to ensure clocks are enabled
> early enough.
> 

Looking at the above commit, I see that call to dwc3_core_get_phy() is
now moved from dwc3_probe() to dwc3_core_init() after
dwc3_core_soft_reset(). But dwc3_core_soft_reset() calls phy_init(),
therefore dwc3_core_get_phy() needs to be called before
dwc3_core_soft_reset().

Below diff fixes the issue on DRA7xx platforms. I can submit a formal
patch, if it looks fine.


diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 326b302fc440..03474d3575ab 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -766,15 +766,15 @@ static int dwc3_core_init(struct dwc3 *dwc)
                        dwc->maximum_speed = USB_SPEED_HIGH;
        }

-       ret = dwc3_core_soft_reset(dwc);
+       ret = dwc3_core_get_phy(dwc);
        if (ret)
                goto err0;

-       ret = dwc3_phy_setup(dwc);
+       ret = dwc3_core_soft_reset(dwc);
        if (ret)
                goto err0;

-       ret = dwc3_core_get_phy(dwc);
+       ret = dwc3_phy_setup(dwc);
        if (ret)
                goto err0;




-- 
Regards
Vignesh
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
